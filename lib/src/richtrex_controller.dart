part of '/richtrex.dart';

/// State manager or [RichTrex].
///
/// Connecting text editor and command button.
class RichTrexController extends TextEditingController {
  RichTrexController({String? text}) : super(text: text);

  bool richTrexRaw = false;
  RichTrexHistory richTrexHistory = RichTrexHistory(index: 0, history: []);
  late RichTrexSelection richTrexSelection = RichTrexSelection(
      start: 0,
      end: super.text.length,
      text: super.text.substring(0, super.text.length));

  @override
  set selection(TextSelection newSelection) {
    richTrexSelection = richTrexRaw
        ? RichTrexSelection(
            end: newSelection.end,
            start: newSelection.start,
            text: text.substring(newSelection.start, newSelection.end))
        : RichTrexSelection.fromTextSelection(
            selection: newSelection, text: super.text);
    super.selection = newSelection;

    //log(selection.asString(text) + '\n' + richTrexSelection.toString());
  }

  @override
  set value(TextEditingValue newValue) {
    if (newValue.selection.affinity != TextAffinity.upstream &&
        newValue.text != super.value.text) {
      try {
        var newRichSelection = RichTrexSelection.fromTextSelection(
            selection: TextSelection(
                baseOffset: newValue.selection.start,
                extentOffset: newValue.selection.end),
            text: newValue.text);
        log(newValue.text
            .substring(richTrexSelection.start, newRichSelection.start));

        final finalText = newRichSelection.start == newRichSelection.end
            ? value.text.replaceRange(
                richTrexSelection.start, richTrexSelection.end, "")
            : value.text.substring(0, newRichSelection.start) +
                newValue.text
                    .substring(richTrexSelection.start, richTrexSelection.end) +
                value.text.substring(newRichSelection.end, value.text.length);

        super.value = newValue.copyWith(text: finalText);
      } catch (e) {
        super.value = newValue;
      }
    } else {
      super.value = newValue;
    }
  }

  void onTap({required RichTrexFormat format}) async {
    if (!format.code.contains("text-raw")) {
      final TextSelection rawSelection = selection;
      final String newText =
          """<tag="${format.code}">${text.substring(richTrexSelection.start, richTrexSelection.end)}</tag>""";
      final TextSelection richSelection = TextSelection(
          baseOffset: rawSelection.start, extentOffset: rawSelection.end);
      text = text.replaceRange(
          richTrexSelection.start, richTrexSelection.end, newText);
      selection = richTrexRaw
          ? TextSelection(
              baseOffset: richSelection.start,
              extentOffset: richSelection.start + newText.length)
          : rawSelection;
    } else {
      richTrexRaw = !richTrexRaw;
      notifyListeners();

      selection = richTrexRaw
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
    return richTrexRaw
        ? TextSpan(
            text: text,
            style: style?.copyWith(
                fontWeight: richTrexRaw ? FontWeight.w300 : style.fontWeight))
        : RichTrexFormat._decode(text, style: style);
  }
}
