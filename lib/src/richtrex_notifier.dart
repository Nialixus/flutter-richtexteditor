part of '/richtrex.dart';

class RichTrexNotifier extends ChangeNotifier {
  RichTrexNotifier({this.text = ""});
  String text;
  TextSelection textSelection = const TextSelection.collapsed(
    offset: 0,
  );

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }

  void onTap({required RichTextFormat format}) {
    if (!textSelection.isCollapsed) {
      int start = textSelection.baseOffset;
      int end = textSelection.extentOffset;

      List<RichTextSelection> codeSelection = RegExp(r'<style=".*?">|</style>')
          .allMatches(text)
          .map((e) => RichTextSelection(
              start: e.start, end: e.end, text: text.substring(e.start, e.end)))
          .toList();

      log(codeSelection.toString());
/*
      for (int x = 0; x < codeSelection.length; x++) {
        start = start +
            codeSelection
                .where((element) => element.start < start)
                .toList()
                .fold(0, (p, n) => p + n.text.length);

        
      }*/

      for (int x = 0; x < codeSelection.length; x++) {}

      log("length : [${text.span.toPlainText().length},${text.length}]; start : [${textSelection.start},$start]; end : [${textSelection.end},$end]; text: [${text.span.toPlainText().substring(textSelection.start, textSelection.end)},${text.substring(start, end)}]");

      /* final String newText = text.replaceRange(
          textSelection.baseOffset,
          textSelection.extentOffset,
          """<style="${format.code}">${text.substring(textSelection.baseOffset, textSelection.extentOffset)}</style>""");

      text = newText;
      notifyListeners();*/
    }
  }

  void updateTextSelection(TextSelection newTextSelection) {
    textSelection = newTextSelection;
    notifyListeners();
  }
}
