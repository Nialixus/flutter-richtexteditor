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
    log(richTrexSelection.toString());
    if (newValue.selection.affinity != TextAffinity.upstream &&
        newValue.text != super.value.text) {
      try {
        var compare = super.value.text.compareWith(newValue.text);

        String midText = newValue.text.substring(compare.start, compare.end);
        String startText = super.text.substring(0, richTrexSelection.end);
        String endText =
            super.text.substring(richTrexSelection.end, text.length);
        if (compare.start == compare.end ||
            compare.end == richTrexSelection.start) {
          // log('${richTrexSelection.toString()}, $start, $end');
          super.value = newValue;
        } else {
          super.value = newValue.copyWith(
            text: selection.isCollapsed
                ? startText + midText + endText
                : newValue.text,
          );
        }
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
