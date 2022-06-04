part of '/richtrex.dart';

/// State manager or [RichTrex].
///
/// By default connecting text editor and command button.
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

  void onTap({required RichTrexFormat format}) async {
    if (format.code.contains("text-raw")) {
      final TextSelection rawSelection = selection;
      final RichTrexSelection richSelection =
          RichTrexSelection.fromTextSelection(
              selection: rawSelection, fullText: text);
      raw = !raw;

      log(rawSelection.toString() + '\n' + richSelection.toString());
      notifyListeners();

      selection = !raw
          ? TextSelection(
              baseOffset: richSelection.start, extentOffset: richSelection.end)
          : rawSelection;
    }

    if (!selection.isCollapsed) {
      final TextSelection rawSelection = selection;

      final String newText = text.replaceRange(
          richTrexSelection.start,
          richTrexSelection.end,
          """<tag="${format.code}">${text.substring(richTrexSelection.start, richTrexSelection.end)}</tag>""");
      if (!format.code.contains("text-raw")) text = newText;
      selection = rawSelection;
    }
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return raw
        ? TextSpan(text: text, style: style)
        : RichTrexFormat._decode(text, style: style);
  }
}
