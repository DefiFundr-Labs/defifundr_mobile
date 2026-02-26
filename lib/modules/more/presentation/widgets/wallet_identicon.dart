import 'package:flutter/material.dart';

/// A deterministic pixel-art style identicon generated from a wallet address.
class WalletIdenticon extends StatelessWidget {
  final String address;
  final double size;

  const WalletIdenticon({
    super.key,
    required this.address,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(size * 0.2),
      child: CustomPaint(
        size: Size(size, size),
        painter: _IdenticonPainter(address),
      ),
    );
  }
}

class _IdenticonPainter extends CustomPainter {
  final String address;

  _IdenticonPainter(this.address);

  @override
  void paint(Canvas canvas, Size size) {
    final hash = _normalizeAddress(address);
    const grid = 5;
    final cellSize = size.width / grid;

    // Derive foreground color from first 6 chars of hash
    final r = _hexByte(hash, 0);
    final g = _hexByte(hash, 2);
    final b = _hexByte(hash, 4);
    final fgColor = Color.fromARGB(255, r, g, b);

    // Light background based on complementary hue
    final bgColor = Color.fromARGB(255, 240, 240, 245);

    // Fill background
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = bgColor,
    );

    // Draw symmetric 5x5 cells
    for (int row = 0; row < grid; row++) {
      for (int col = 0; col <= grid ~/ 2; col++) {
        final idx = (row * (grid ~/ 2 + 1) + col) % hash.length;
        final cellVal = int.tryParse(hash[idx], radix: 16) ?? 0;

        if (cellVal > 7) {
          final paint = Paint()..color = fgColor;
          canvas.drawRect(
            Rect.fromLTWH(col * cellSize, row * cellSize, cellSize, cellSize),
            paint,
          );
          // Mirror horizontally (skip center column)
          if (col < grid ~/ 2) {
            canvas.drawRect(
              Rect.fromLTWH(
                (grid - 1 - col) * cellSize,
                row * cellSize,
                cellSize,
                cellSize,
              ),
              paint,
            );
          }
        }
      }
    }
  }

  String _normalizeAddress(String addr) {
    final clean = addr.toLowerCase().replaceAll('0x', '').replaceAll('...', '');
    // Pad to at least 25 chars so we never go out of bounds
    return clean.padRight(25, clean.isEmpty ? '0' : clean[0]);
  }

  int _hexByte(String hash, int offset) {
    if (hash.length < offset + 2) return 128;
    return int.tryParse(hash.substring(offset, offset + 2), radix: 16) ?? 128;
  }

  @override
  bool shouldRepaint(_IdenticonPainter old) => old.address != address;
}
