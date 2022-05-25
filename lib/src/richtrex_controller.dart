part of '/richtrex.dart';

class RichTrexController extends TextEditingController {
  RichTrexController({super.text});
  bool raw = false;
  RichTrexSelection get richTrexSelection => RichTrexSelection(
      start: super.selection.start,
      end: super.selection.end,
      text: super.selection.textInside(text));

  @override
  set selection(TextSelection newSelection) {
    List<RichTrexSelection> codeSelection = RegExp(r'<style=".*?">|</style>')
        .allMatches(text)
        .map((e) => RichTrexSelection(
            start: e.start, end: e.end, text: text.substring(e.start, e.end)))
        .toList();

    log(codeSelection.toString());
    super.selection = newSelection;
  }

  void onTap({required RichTrexFormat format}) {
    if (format._code.contains("text-raw")) {
      bool matched = bool.fromEnvironment(
          RegExp(r'(?<=text-raw:).*?(?=;)').stringMatch(format._code)!);

      raw = raw == matched ? !matched : matched;
      notifyListeners();
    }

    if (!selection.isCollapsed) {
/*
      for (int x = 0; x < codeSelection.length; x++) {
        start = start +
            codeSelection
                .where((element) => element.start < start)
                .toList()
                .fold(0, (p, n) => p + n.text.length);

        
      }*/

      //log("length : [${RichTrexFormat._decode(text).toPlainText().length},${text.length}]; start : [${selection.start},$start]; end : [${selection.end},$end]; text: [${RichTrexFormat._decode(text).toPlainText().substring(selection.start, selection.end)},${text.substring(start, end)}]");

      final String newText = format._code.contains("text-raw:")
          ? text
          : text.replaceRange(selection.start, selection.end,
              """<style="${format._code}">${text.substring(selection.start, selection.end)}</style>""");

      text = newText;
    }
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return raw
        ? TextSpan(
            text: text,
            style: const TextStyle(color: Colors.black, fontSize: 14))
        : RichTrexFormat._decode(text);
  }
}
