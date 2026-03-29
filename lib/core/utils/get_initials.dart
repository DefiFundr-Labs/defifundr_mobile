/// Extracts the initials from a given text string.
///
/// Takes the first letter of the first two words if available,
/// otherwise takes the first two characters of the string.
///
/// Example:
/// ```dart
/// getInitials('John Doe') // => 'JD'
/// getInitials('DefiFundr Mobile') // => 'DM'
/// getInitials('Hi') // => 'HI'
/// ```
String getInitials(String text) {
  if (text.isEmpty) return '';

  final words = text.trim().split(RegExp(r'\s+'));
  if (words.length >= 2) {
    return '${words[0][0]}${words[1][0]}'.toUpperCase();
  }

  return text.length >= 2
      ? text.substring(0, 2).toUpperCase()
      : text[0].toUpperCase();
}
