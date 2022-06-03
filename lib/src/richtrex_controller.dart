part of '/richtrex.dart';

class RichTrexController extends TextEditingController {
  RichTrexController({String? text}) : super(text: text);
  bool raw = false;
  late RichTrexSelection richTrexSelection = RichTrexSelection(
      start: 0,
      end: super.text.length,
      text: super.text.substring(0, super.text.length));

  @override
  set selection(TextSelection newSelection) {
    richTrexSelection = RichTrexSelection.fromTextSelection(
        selection: newSelection, fullText: super.text);

    super.selection = newSelection;
  }

  void onTap({required RichTrexFormat format}) {
    if (format.code.contains("text-raw")) {
      raw = !raw;
      notifyListeners();
    }

    if (!selection.isCollapsed) {
      final TextSelection rawSelection = selection;
      final RichTrexSelection richSelection =
          RichTrexSelection.fromTextSelection(
              selection: selection, fullText: text);

      final String newText = text.replaceRange(
          richTrexSelection.start,
          richTrexSelection.end,
          """<tag="${format.code}">${text.substring(richTrexSelection.start, richTrexSelection.end)}</tag>""");
      if (!format.code.contains("text-raw")) text = newText;

      selection = raw
          ? TextSelection(
              baseOffset: richTrexSelection.start,
              extentOffset: richTrexSelection.end)
          : rawSelection;
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
