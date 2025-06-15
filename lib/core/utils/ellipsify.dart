String ellipsify({required String word, int? maxLength}) {
  maxLength ??= 10;
  if (maxLength % 2 != 0) {
    maxLength++;
  }
  if (word.length <= maxLength) return word;

// word... (no second part)
  return '${word.substring(0, maxLength)}...';
}


String ellipsifyAddress({required String word, int? maxLength}) {
  maxLength ??= 10;
  if (maxLength % 2 != 0) {
    maxLength++;
  }
  if (word.length <= maxLength) return word;
  // get first four and last four characters
  final first = word.substring(0, maxLength ~/ 2);
  final last = word.substring((word.length - maxLength / 2).toInt(), word.length);
  return '$first...$last';
}