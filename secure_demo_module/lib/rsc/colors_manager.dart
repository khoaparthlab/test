import 'dart:ui';

Color getColorFromHex(String hexString) {
  /// MODIFY CODE ONLY BELOW THIS LINE

  final buffer = StringBuffer();
  if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
  buffer.write(hexString.replaceFirst('#', ''));
  return Color(int.parse(buffer.toString(), radix: 16));

  /// MODIFY CODE ONLY ABOVE THIS LINE
}
