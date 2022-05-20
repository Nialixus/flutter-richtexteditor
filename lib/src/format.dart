class RichTextFormat {
  final String code;
  final String? value;

  RichTextFormat.bold({this.value}) : code = "font-weight:${value ?? 6};";
  RichTextFormat.color({this.value})
      : code = "font-color:${value ?? 0xff000000};";
}

class RichTextFormatCodes {
  static const String bold = "font-weight:6;";
  static const String color = "font-color:0xff000000;";

  static const List<String> list = [bold, color];
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
