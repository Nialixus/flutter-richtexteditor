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
  static TextSpan _decode(String string) => TextSpan(
      children: List.generate(
          _split(string).length, (index) => _span(_split(string)[index])),
      style: const TextStyle(color: Colors.black));
}

class RichTrexSelection {
  final int start, end;
  final String text;
  const RichTrexSelection(
      {required this.start, required this.end, required this.text});
  factory RichTrexSelection.fromTextSelection(
      {required TextSelection selection, required String fullText}) {
    List<RichTrexSelection> richSelection = RegExp(r'<tag=".*?">|</tag>')
        .allMatches(fullText)
        .map((e) => RichTrexSelection(
            start: e.start,
            end: e.end,
            text: fullText.substring(e.start, e.end)))
        .toList();

    int start() {
      List<bool> selected = [
        for (int x = 0; x < richSelection.length; x++)
          selection.start +
                  (x > 0
                      ? richSelection
                          .sublist(0, x)
                          .fold(0, (p, e) => p + e.text.length)
                      : 0) +
                  (richSelection[x].text.contains(RegExp(r'<tag=".*?">|</tag>'))
                      ? 1
                      : 0) >
              richSelection[x].start
      ];

      return selected.contains(true)
          ? selection.start +
              richSelection
                  .sublist(0, selected.lastIndexWhere((val) => val == true) + 1)
                  .fold<int>(0, (p, e) => p + e.text.length)
          : selection.start;
    }

    int end() {
      List<bool> selected = [
        for (int x = 0; x < richSelection.length; x++)
          selection.end +
                  (x > 0
                      ? richSelection
                          .sublist(0, x)
                          .fold(0, (p, e) => p + e.text.length)
                      : 0) +
                  (richSelection[x].text.contains(RegExp(r'</tag>')) ? 1 : 0) >
              richSelection[x].start
      ];

      return selected.contains(true)
          ? selection.end +
              richSelection
                  .sublist(0, selected.lastIndexWhere((val) => val == true) + 1)
                  .fold<int>(0, (p, e) => p + e.text.length)
          : selection.end;
    }

    // log("raw(${selection.start} ${selection.end});rich(${start()} ${end()})");

    return RichTrexSelection(
        start: start(), end: end(), text: fullText.substring(start(), end()));
  }

  @override
  String toString() {
    return "RichTrexSelection(start: $start, end: $end, text: $text)";
  }
}

extension TextSpanString on String {
  TextSpan get span => RichTrexFormat._decode(this);
}
