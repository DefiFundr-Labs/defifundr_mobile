#!/usr/bin/env python3
"""
l10n.py — Localization helper for DeFiFundr mobile

Commands:
  add  <key> <en> [--es <es>]   Add a new key to both ARBs and regenerate
  add-param <key> <en> [--es]   Add a parameterized key (use {placeholder} syntax)
  adopt [path]                  Interactive: scan → prompt accept/edit/skip → batch add
  scan [path]                    Find likely hardcoded UI strings in Dart files
  gen                            Run flutter gen-l10n
  list [filter]                  List all ARB keys (optionally filtered)

Examples:
  python3 scripts/l10n.py adopt lib/modules/more/
  python3 scripts/l10n.py adopt lib/modules/finance/presentation/select_assets/asset_details_screen.dart
  python3 scripts/l10n.py add submitButton "Submit" --es "Enviar"
  python3 scripts/l10n.py scan lib/modules/payment/
  python3 scripts/l10n.py gen
  python3 scripts/l10n.py list password
"""

import argparse
import bisect
import json
import re
import subprocess
import sys
from pathlib import Path

# ── paths ──────────────────────────────────────────────────────────────────────
ROOT = Path(__file__).parent.parent
EN_ARB = ROOT / "lib/core/localization/intl_en.arb"
ES_ARB = ROOT / "lib/core/localization/intl_es.arb"

# ── scan config ────────────────────────────────────────────────────────────────

# Patterns are applied to the FULL file content (not line-by-line) so that
# multi-line constructs like:
#   Text(
#     'Transactions',   ← on the next line
# are captured correctly.  \s* in each pattern handles newline + indent gaps.

TEXT_PATTERNS = [
    # Text('...') or Text("...") — string may be on the next line after (
    r"""Text\s*\(\s*['"]([^'"${}\n][^'"]*)['"]\s*[,)]""",
    # Named widget params: labelText / hintText / title / text / hint / label / etc.
    r"""(?:labelText|hintText|title|text|hint|label|subtitle|message|tooltip)\s*:\s*['"]([^'"${}\n][^'"]*)['"]""",
]

EXCLUDE_PATTERNS = [
    r'^package:',
    r'^assets/',
    r'^\.',
    r'^\d',
    r'^\$',
    r'\.dart$',
    r'\.svg$|\.png$|\.jpg$',
    r'^[A-Z_]+$',
    r'^\w+\(\)',
    r'^https?://',
]

# ── helpers ────────────────────────────────────────────────────────────────────

def _load_arb(path: Path) -> dict:
    with open(path, encoding="utf-8") as f:
        return json.load(f)


def _save_arb_raw(path: Path, data: dict) -> None:
    """Pretty-print ARB, indenting nested objects nicely."""
    lines = ["{\n"]
    items = list(data.items())
    for i, (k, v) in enumerate(items):
        comma = "," if i < len(items) - 1 else ""
        key_str = json.dumps(k)
        if isinstance(v, str):
            val_str = json.dumps(v, ensure_ascii=False)
            lines.append(f'  {key_str}: {val_str}{comma}\n')
        elif isinstance(v, dict):
            val_str = json.dumps(v, ensure_ascii=False, indent=2)
            indented = "\n".join(
                ("  " + line if li > 0 else line)
                for li, line in enumerate(val_str.splitlines())
            )
            lines.append(f'  {key_str}: {indented}{comma}\n')
    lines.append("}\n")
    with open(path, "w", encoding="utf-8") as f:
        f.writelines(lines)


def _run_gen() -> bool:
    print("→ Running flutter gen-l10n …")
    result = subprocess.run(
        ["flutter", "gen-l10n"],
        cwd=ROOT,
        capture_output=True,
        text=True,
    )
    if result.returncode == 0:
        print("  ✓ Generated successfully.\n")
        return True
    else:
        print(f"  ✗ flutter gen-l10n failed:\n{result.stderr}\n")
        return False


def _text_to_key(text: str) -> str:
    """Convert a UI string to a camelCase Dart identifier.

    Examples:
      "See all"         → seeAll
      "Receive"         → receive
      "DeFi Staking Reward" → deFiStakingReward
      "No saved addresses yet" → noSavedAddressesYet
    """
    cleaned = re.sub(r"[^a-zA-Z0-9 ]+", "", text)
    words = cleaned.split()
    if not words:
        return "unknownKey"
    result = words[0].lower() + "".join(w.capitalize() for w in words[1:])
    # Must start with a lowercase letter
    if not result or not result[0].isalpha():
        result = "key" + result
    # Truncate to reasonable length
    return result[:50]


def _collect_findings(scan_path: Path) -> list[dict]:
    """Return finding dicts for all hardcoded strings under scan_path.

    Scans each file as a whole (not line-by-line) so multi-line Text() widgets
    like:
        Text(
          'Transactions',   ← string on next line
    are captured correctly.
    """
    en_data = _load_arb(EN_ARB)
    existing_values = {v.lower() for v in en_data.values() if isinstance(v, str)}

    dart_files = list(scan_path.rglob("*.dart")) if scan_path.is_dir() else [scan_path]
    dart_files = [
        f for f in dart_files
        if "generated" not in str(f) and ".dart_tool" not in str(f)
    ]

    findings = []

    for dart_file in sorted(dart_files):
        try:
            content = dart_file.read_text(encoding="utf-8")
        except Exception:
            continue

        rel_path = dart_file.relative_to(ROOT)
        lines = content.splitlines()

        # Build cumulative char-offset → line-number lookup via bisect.
        # line_starts[i] = char offset of the start of line i+1 (0-indexed).
        line_starts: list[int] = [0]
        for line in lines:
            line_starts.append(line_starts[-1] + len(line) + 1)  # +1 for \n

        def line_of(offset: int) -> int:
            """Return 1-based line number for a character offset."""
            return bisect.bisect_right(line_starts, offset)

        seen: set[tuple[int, str]] = set()  # deduplicate (line_no, text) across patterns

        for pattern in TEXT_PATTERNS:
            for m in re.finditer(pattern, content):
                candidate = m.group(1).strip()

                # Skip interpolated strings (e.g. 'My ${asset.name}')
                if "${" in candidate:
                    continue

                line_no = line_of(m.start())
                actual_line = lines[line_no - 1] if 0 < line_no <= len(lines) else ""

                # Skip lines that already use l10n
                if "l10n." in actual_line or "context.l10n" in actual_line:
                    continue

                # Skip comment and import lines
                stripped = actual_line.strip()
                if stripped.startswith("//") or stripped.startswith("*"):
                    continue
                if stripped.startswith("import ") or stripped.startswith("export "):
                    continue

                # Exclusion filters
                if any(re.search(ep, candidate) for ep in EXCLUDE_PATTERNS):
                    continue
                if len(candidate) < 3:
                    continue

                dedup = (line_no, candidate)
                if dedup in seen:
                    continue
                seen.add(dedup)

                findings.append({
                    "file": str(rel_path),
                    "line": line_no,
                    "text": candidate,
                    "in_arb": candidate.lower() in existing_values,
                })

    return findings


# ── commands ───────────────────────────────────────────────────────────────────

def cmd_add(args):
    key = args.key
    en_val = args.en
    es_val = args.es

    if not re.fullmatch(r"[a-z][a-zA-Z0-9]*", key):
        print(f"✗ Invalid key '{key}'. Must be camelCase starting with a lowercase letter.")
        sys.exit(1)

    en_data = _load_arb(EN_ARB)
    es_data = _load_arb(ES_ARB)

    if key in en_data:
        print(f"✗ Key '{key}' already exists in intl_en.arb  →  \"{en_data[key]}\"")
        print("  Use a different key or edit the ARB files directly.")
        sys.exit(1)

    if es_val is None:
        print(f"  English: {en_val}")
        es_val = input("  Spanish translation (press Enter to skip for now): ").strip()
        if not es_val:
            es_val = en_val

    en_data[key] = en_val
    es_data[key] = es_val

    _save_arb_raw(EN_ARB, en_data)
    _save_arb_raw(ES_ARB, es_data)

    print(f"✓ Added key '{key}'")
    print(f"  EN: {en_val}")
    print(f"  ES: {es_val}\n")

    _run_gen()
    print(f"Usage in Dart:  context.l10n.{key}")


def cmd_add_param(args):
    """Add a parameterized key, e.g. 'hello {name}' → with @key metadata."""
    key = args.key
    en_val = args.en
    es_val = args.es

    if not re.fullmatch(r"[a-z][a-zA-Z0-9]*", key):
        print(f"✗ Invalid key '{key}'.")
        sys.exit(1)

    placeholders_found = re.findall(r"\{(\w+)\}", en_val)
    if not placeholders_found:
        print('✗ No placeholders found. Use {name} syntax, e.g.: "Hello {name}"')
        sys.exit(1)

    en_data = _load_arb(EN_ARB)
    es_data = _load_arb(ES_ARB)

    if key in en_data:
        print(f"✗ Key '{key}' already exists.")
        sys.exit(1)

    if es_val is None:
        print(f"  English: {en_val}")
        es_val = input("  Spanish translation (include same {placeholders}): ").strip()
        if not es_val:
            es_val = en_val

    metadata_key = f"@{key}"
    placeholders_meta = {p: {"type": "String"} for p in placeholders_found}

    en_data[key] = en_val
    en_data[metadata_key] = {"placeholders": placeholders_meta}
    es_data[key] = es_val
    es_data[metadata_key] = {"placeholders": placeholders_meta}

    _save_arb_raw(EN_ARB, en_data)
    _save_arb_raw(ES_ARB, es_data)

    print(f"✓ Added parameterized key '{key}'")
    print(f"  EN: {en_val}")
    print(f"  ES: {es_val}")
    print(f"  Placeholders: {placeholders_found}\n")

    _run_gen()

    param_args = ", ".join(f"'{p}Value'" for p in placeholders_found)
    print(f"Usage in Dart:  context.l10n.{key}({param_args})")


def cmd_adopt(args):
    """Interactive: scan → present each new string → accept/edit/skip → batch add."""
    raw = Path(args.path) if args.path else ROOT / "lib"
    scan_path = raw if raw.is_absolute() else ROOT / raw

    all_findings = _collect_findings(scan_path)
    missing = [f for f in all_findings if not f["in_arb"]]

    if not missing:
        print(f"✓ No new strings to adopt in {scan_path}.\n")
        return

    # Deduplicate by lowercase text — keep first occurrence for location info
    seen_texts: dict[str, dict] = {}
    for f in missing:
        key = f["text"].lower()
        if key not in seen_texts:
            seen_texts[key] = f

    unique = list(seen_texts.values())

    # Count extra occurrences for display
    occurrence_count: dict[str, int] = {}
    for f in missing:
        occurrence_count[f["text"].lower()] = occurrence_count.get(f["text"].lower(), 0) + 1

    print(f"\nFound {len(unique)} unique string(s) to adopt ({len(missing)} total occurrences).")
    print("Commands:  [Enter] accept   e = edit key/value   s = skip   q = quit\n")

    queued: list[dict] = []  # {key, en, es, locations}
    quit_early = False

    # Build a location map: text → all (file, line) pairs
    locations_map: dict[str, list[str]] = {}
    for f in missing:
        t = f["text"].lower()
        loc = f"{f['file']}:{f['line']}"
        locations_map.setdefault(t, []).append(loc)

    en_data_current = _load_arb(EN_ARB)

    for idx, item in enumerate(unique, 1):
        text = item["text"]
        text_key = text.lower()
        suggested_key = _text_to_key(text)
        locs = locations_map.get(text_key, [f"{item['file']}:{item['line']}"])
        count = occurrence_count.get(text_key, 1)

        print(f"─── [{idx}/{len(unique)}] ───────────────────────────────────────")
        print(f"  Text     : \"{text}\"")
        print(f"  Location : {locs[0]}" + (f"  (+{count - 1} more)" if count > 1 else ""))
        print(f"  Key      : {suggested_key}", end="")
        if suggested_key in en_data_current:
            print(f"  ⚠  (key exists → \"{en_data_current[suggested_key]}\")", end="")
        print()

        final_key = suggested_key
        final_en = text
        accepted = False

        while True:
            try:
                choice = input("  > ").strip().lower()
            except (EOFError, KeyboardInterrupt):
                print("\nAborted.")
                quit_early = True
                break

            if choice == "q":
                quit_early = True
                break

            elif choice == "s":
                print("  Skipped.\n")
                break

            elif choice == "e":
                # Edit key
                try:
                    new_key = input(f"  Key [{final_key}]: ").strip()
                    if new_key:
                        if not re.fullmatch(r"[a-z][a-zA-Z0-9]*", new_key):
                            print("  ✗ Invalid key — must be camelCase. Try again.")
                            continue
                        final_key = new_key

                    # Edit English value
                    new_en = input(f"  English [{final_en}]: ").strip()
                    if new_en:
                        final_en = new_en
                except (EOFError, KeyboardInterrupt):
                    print("\nAborted.")
                    quit_early = True
                    break

                # Fall through to accept after editing
                choice = ""

            if choice in ("", "e"):
                # Check key collision after possible edit
                if final_key in en_data_current:
                    existing_val = en_data_current[final_key]
                    if existing_val.lower() != final_en.lower():
                        print(f"  ⚠  Key '{final_key}' already maps to \"{existing_val}\".")
                        try:
                            override = input("  Use existing key as-is? [y/n]: ").strip().lower()
                        except (EOFError, KeyboardInterrupt):
                            quit_early = True
                            break
                        if override != "y":
                            continue  # let user re-enter
                    else:
                        # Same value — just skip adding, it's already there
                        print(f"  ✓ Already in ARB as '{final_key}'. Skipped add.\n")
                        break

                # Ask for Spanish
                try:
                    es_val = input(f"  Spanish [{final_en}]: ").strip()
                except (EOFError, KeyboardInterrupt):
                    quit_early = True
                    break

                if not es_val:
                    es_val = final_en

                queued.append({
                    "key": final_key,
                    "en": final_en,
                    "es": es_val,
                    "locations": locs,
                })
                print(f"  ✓ Queued: {final_key}\n")
                accepted = True
                break

        if quit_early:
            break

    # ── Summary ────────────────────────────────────────────────────────────────
    print(f"\n{'═' * 50}")
    if not queued:
        print("Nothing adopted. ARBs unchanged.\n")
        return

    # Batch-insert into ARBs
    en_data = _load_arb(EN_ARB)
    es_data = _load_arb(ES_ARB)

    added = 0
    for entry in queued:
        if entry["key"] not in en_data:
            en_data[entry["key"]] = entry["en"]
            es_data[entry["key"]] = entry["es"]
            added += 1
        else:
            print(f"  ⚠  '{entry['key']}' already existed — skipped.")

    _save_arb_raw(EN_ARB, en_data)
    _save_arb_raw(ES_ARB, es_data)

    print(f"✓ Added {added} key(s) to ARBs.\n")
    _run_gen()

    # Print Dart replacement hints
    print("Dart replacements needed:")
    print("─" * 50)
    for entry in queued:
        for loc in entry["locations"]:
            print(f"  {loc}")
        print(f'    "{entry["en"]}"')
        print(f"    → context.l10n.{entry['key']}\n")


def cmd_gen(_=None):
    _run_gen()


def cmd_list(args):
    en_data = _load_arb(EN_ARB)
    filt = (args.filter or "").lower() if args.filter else ""

    rows = [
        (k, v) for k, v in en_data.items()
        if isinstance(v, str) and not k.startswith("@") and (filt in k.lower() or filt in v.lower())
    ]

    if not rows:
        print(f"No keys found matching '{filt}'.")
        return

    key_w = min(max(len(k) for k, _ in rows), 40)
    print(f"\n{'Key':<{key_w}}  Value")
    print("-" * (key_w + 50))
    for k, v in rows:
        print(f"{k:<{key_w}}  {v[:80]}")
    print(f"\n{len(rows)} key(s) total.\n")


def cmd_scan(args):
    raw = Path(args.path) if args.path else ROOT / "lib"
    scan_path = raw if raw.is_absolute() else ROOT / raw

    findings = _collect_findings(scan_path)

    if not findings:
        print(f"✓ No hardcoded UI strings found in {scan_path}.\n")
        return

    from collections import defaultdict
    by_file: dict = defaultdict(list)
    for f in findings:
        by_file[f["file"]].append(f)

    total_new = sum(1 for f in findings if not f["in_arb"])
    total_existing = sum(1 for f in findings if f["in_arb"])

    print(f"\nFound {len(findings)} potential hardcoded string(s) in {len(by_file)} file(s).")
    print(f"  {total_new} not yet in ARB   |   {total_existing} already in ARB (may just need wiring)\n")

    for file_path, items in sorted(by_file.items()):
        print(f"  {file_path}")
        for item in items:
            status = "✓ in ARB" if item["in_arb"] else "✗ missing"
            print(f"    L{item['line']:>4}  [{status}]  \"{item['text']}\"")
        print()


# ── CLI ────────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Localization helper for DeFiFundr mobile",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    sub = parser.add_subparsers(dest="command", required=True)

    # add
    p_add = sub.add_parser("add", help="Add a simple key to both ARBs and regenerate")
    p_add.add_argument("key", help="Dart-valid camelCase key, e.g. submitButton")
    p_add.add_argument("en", help="English value")
    p_add.add_argument("--es", default=None, help="Spanish value (prompted if omitted)")
    p_add.set_defaults(func=cmd_add)

    # add-param
    p_addp = sub.add_parser("add-param", help="Add a parameterized key (use {placeholder} in value)")
    p_addp.add_argument("key", help="Dart-valid camelCase key")
    p_addp.add_argument("en", help="English value with {placeholder} markers")
    p_addp.add_argument("--es", default=None, help="Spanish value")
    p_addp.set_defaults(func=cmd_add_param)

    # adopt
    p_adopt = sub.add_parser(
        "adopt",
        help="Interactive: scan → accept/edit/skip each string → batch add to ARBs",
    )
    p_adopt.add_argument("path", nargs="?", help="File or directory to scan (default: lib/)")
    p_adopt.set_defaults(func=cmd_adopt)

    # gen
    p_gen = sub.add_parser("gen", help="Run flutter gen-l10n")
    p_gen.set_defaults(func=cmd_gen)

    # list
    p_list = sub.add_parser("list", help="List ARB keys")
    p_list.add_argument("filter", nargs="?", help="Optional filter string")
    p_list.set_defaults(func=cmd_list)

    # scan
    p_scan = sub.add_parser("scan", help="Scan Dart files for hardcoded UI strings")
    p_scan.add_argument("path", nargs="?", help="File or directory to scan (default: lib/)")
    p_scan.set_defaults(func=cmd_scan)

    args = parser.parse_args()
    args.func(args)


if __name__ == "__main__":
    main()
