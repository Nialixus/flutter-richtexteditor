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
    if (!raw) {
      richTrexSelection = RichTrexSelection.fromTextSelection(
          selection: newSelection, text: super.text);
    } else {
      richTrexSelection = RichTrexSelection(
          start: newSelection.start,
          end: newSelection.end,
          text: text.substring(newSelection.start, newSelection.end));
    }
/*
    log(raw.toString() +
        '\n' +
        selection.asString(text) +
        '\n' +
        richTrexSelection.toString());*/

    super.selection = newSelection;
  }

  void onTap({required RichTrexFormat format}) async {
    if (!format.code.contains("text-raw")) {
      final TextSelection rawSelection = selection;
      final String newText =
          """<tag="${format.code}">${text.substring(richTrexSelection.start, richTrexSelection.end)}</tag>""";
      final TextSelection richSelection = TextSelection(
          baseOffset: rawSelection.start, extentOffset: newText.length);
      text = text.replaceRange(
          richTrexSelection.start, richTrexSelection.end, newText);
      selection = !raw
          ? rawSelection
          : TextSelection(
              baseOffset: richSelection.start, extentOffset: newText.length);
    } else {
      raw = !raw;
      notifyListeners();

      selection = raw
          ? TextSelection(
              baseOffset: richTrexSelection.start,
              extentOffset: richTrexSelection.end)
          : RichTrexSelection.toTextSelection(selection: selection, text: text);
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
