part of '/richtrex.dart';

class RichTrexFormat {
  final String code;
  final String name;
  final String value;

  RichTrexFormat({required this.name, required this.value})
      : code = "$name:$value;";

  @override
  String toString() =>
      'RichTrexFormat(name: $name, value: $value, code: "$code")';

  static RichTrexFormat bold({required FontWeight value}) {
    return RichTrexFormat(name: "font-color", value: '$value');
  }

  static RichTrexFormat color({required Color value}) {
    return RichTrexFormat(
        name: "font-color", value: '0x${value.value.toRadixString(16)}');
  }

  static RichTrexFormat viewsource({required bool value}) {
    return RichTrexFormat(name: "view-source", value: '$value');
  }

  /// Splitting [String] into [List] of String.
  static List<String> _split(String string) {
    List<String> newlist = string.split(RegExp(
        r'(?=<(style|widget)=.*?</(style|widget)>)|(?<=<(style|widget)=.*?</(style|widget)>)'));
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
      RegExp regex = RegExp(r'(?<=font-weight:).*?(?=;)');
      String weight = regex.stringMatch(string)!;
      return FontWeight.values[int.parse(weight)];
    } catch (e) {
      return null;
    }
  }

  /// Cleaning [String] from [RichTrexFormat].
  static String _text(String string) {
    try {
      return string.replaceAll(
          RegExp(r'(<(style|widget)=".*?">)|(</(style|widget)>)'), "");
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
  static TextSpan _decode(String string,
      {TextStyle style = const TextStyle(color: Colors.black)}) {
    var split = _split(string);
    return TextSpan(
        children: List.generate(split.length, (index) => _span(split[index])),
        style: style);
  }
}
