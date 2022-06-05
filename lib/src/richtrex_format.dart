part of '/richtrex.dart';

class RichTrexFormat {
  final String code;

  RichTrexFormat.bold({required FontWeight value})
      : code = "font-weight:${value.index};";
  RichTrexFormat.color({required Color value})
      : code = "font-color:0x${value.value.toRadixString(16)};";
  RichTrexFormat.raw({required bool value}) : code = "text-raw:$value;";

  /// Splitting [String] into [List] of String.
  static List<String> _split(String string) {
    List<String> newlist = string.split(RegExp(r'<tag=|</tag>'));
    return newlist;
  }

  /// Decode [Color] from [String].
  static Color? _color(String string) {
    try {
      RegExp regex = RegExp(r'(?<=font-color:).*?(?=;)');
      String color = regex.stringMatch(string)!;
      return Color(int.parse(color));
    } catch (e) {
      return null;
    }
  }

  /// Decode [FontWeight] from [String].
  static FontWeight? _fontWeight(String string) {
    try {
      RegExp regex = RegExp(r'(?<=font-weight:).');
      String weight = regex.stringMatch(string)!;
      return FontWeight.values[int.parse(weight)];
    } catch (e) {
      return null;
    }
  }

  /// Cleaning [String] from [RichTextFormat].
  static String _text(String string) {
    try {
      return string.replaceAll(RegExp(r'".*">'), "");
    } catch (e) {
      return string;
    }
  }

  /// Wrapping every parameter into [InlineSpan].
  static InlineSpan _span(String string) {
    return TextSpan(
        text: _text(string),
        style:
            TextStyle(color: _color(string), fontWeight: _fontWeight(string)));
  }

  /// Decode [String] to [TextSpan].
  static TextSpan _decode(String string, {TextStyle? style}) => TextSpan(
      children: List.generate(
          _split(string).length, (index) => _span(_split(string)[index])),
      style: style ?? const TextStyle(color: Colors.black));
}

extension TextSpanString on String {
  TextSpan get span => RichTrexFormat._decode(this);
}
