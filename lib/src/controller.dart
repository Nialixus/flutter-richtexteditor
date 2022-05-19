part of '/flutter_richtexteditor.dart';

class RichTextController extends ChangeNotifier {
  RichTextController({this.text = ""});
  String text;
  TextSelection textSelection = const TextSelection.collapsed(
    offset: 0,
  );

  void onTap({required RichTextFormat format}) {
    if (!textSelection.isCollapsed) {
      int start = textSelection.baseOffset;
      int end = textSelection.extentOffset;
      print("start : $start, end : $end");
      if (text.isformatted(end)) {
        start = start + 10;
      }

      log("syled : $text" +
          '\n' +
          "substyled : ${text.substring(start, end)}" +
          '\n' +
          "origin : ${text.span.toPlainText()} " +
          '\n' +
          "suborigin : ${text.span.toPlainText().substring(start, end)}");

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
    print(textSelection);
    notifyListeners();
  }
}
