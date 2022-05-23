part of '/richtrex.dart';

class RichTrexController extends TextEditingController {
  RichTrexController({super.text});

  //final RichTrexNotifier _notifier = RichTrexNotifier();

  List<LineMetrics> metrics = [];

  void updateMetrics(List<LineMetrics> metrics) {
    this.metrics = metrics;
    notifyListeners();
  }

  void onTap({required RichTextFormat format}) {
    log('selection: $selection\nvalue: ${value.selection}\n${super.selection}'); /*
    if (!super.selection.isCollapsed) {
      int start = selection.baseOffset;
      int end = selection.extentOffset;

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

      log("length : [${text.span.toPlainText().length},${text.length}]; start : [${selection.start},$start]; end : [${selection.end},$end]; text: [${text.span.toPlainText().substring(selection.start, selection.end)},${text.substring(start, end)}]");

      /* final String newText = text.replaceRange(
          textSelection.baseOffset,
          textSelection.extentOffset,
          """<style="${format.code}">${text.substring(textSelection.baseOffset, textSelection.extentOffset)}</style>""");

      text = newText;
      notifyListeners();*/
    }
*/
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return text.span;
  }
}
