int countWords(String text) {
  if (text.isEmpty) return 0;
  return text.trim().split(RegExp(r'\s+')).length;
}

String toUpperCase(String text) {
  return text.toUpperCase();
}

String toLowerCase(String text) {
  return text.toLowerCase();
}

String reverseText(String text) {
  return text.split('').reversed.join('');
}

String removeExtraSpaces(String text) {
  return text.replaceAll(RegExp(r'\s+'), ' ').trim();
}

String capitalizeWords(String text) {
  if (text.isEmpty) return text;
  
  return text.split(' ').map((word) {
    if (word.isEmpty) return word;
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}