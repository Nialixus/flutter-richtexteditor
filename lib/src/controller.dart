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

      if (text.substring(0, end).contains("<")) {
        RegExp regex = RegExp(r'<style=".*?">');
        if (regex.hasMatch(text)) {
          String newText = regex.stringMatch(text)!;
          print(text.substring(start + newText.length, end + newText.length));
        }
      }

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
