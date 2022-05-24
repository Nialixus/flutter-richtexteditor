part of '/richtrex.dart';

class RichTrexFormat {
  final String code;
  final String? value;

  RichTrexFormat.bold({this.value}) : code = "font-weight:${value ?? 6};";
  RichTrexFormat.color({this.value})
      : code = "font-color:${value ?? 0xff000000};";

  /// Splitting [String] into [List] of String.
  static List<String> _split(String string) {
    List<String> newlist = string.split(RegExp(r'<style=|</style>'));
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
  static TextSpan _decode(String string) => TextSpan(
      children: List.generate(
          _split(string).length, (index) => _span(_split(string)[index])),
      style: const TextStyle(color: Colors.black));
}

class RichTextSelection {
  final int start, end;
  final String text;
  const RichTextSelection(
      {required this.start, required this.end, required this.text});

  @override
  String toString() {
    return "RichTextSelection(start: $start, end: $end, text: $text)";
  }
}
