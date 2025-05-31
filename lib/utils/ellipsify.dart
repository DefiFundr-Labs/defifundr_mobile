String ellipsify({required String word, int? maxLength}) {
  maxLength ??= 10;
  if (maxLength % 2 != 0) {
    maxLength++;
  }
  if (word.length <= maxLength) return word;

// word... (no second part)
  return '${word.substring(0, maxLength)}...';
}
