part of '/richtrex.dart';

/// State manager or [RichTrex].
///
/// Connecting text editor and command button.
class RichTrexController extends TextEditingController {
  bool viewSource;
  RichTrexController({String? text, this.viewSource = false})
      : super(text: text);

  RichTrexHistory richTrexHistory = RichTrexHistory(index: 0, history: []);
  late RichTrexSelection richTrexSelection =
      RichTrexSelection.fromSelection(selection: selection, text: text);

  @override
  set selection(TextSelection newSelection) {
    richTrexSelection = viewSource
        ? RichTrexSelection(
            end: newSelection.end,
            start: newSelection.start,
            text: text.substring(newSelection.start, newSelection.end))
        : RichTrexSelection.fromSelection(
            selection: newSelection, text: super.text);
    final String finalText =
        viewSource ? text : RichTrexFormat._decode(text).toPlainText();
    super.selection = newSelection.copyWith(
        baseOffset: newSelection.baseOffset >= finalText.length
            ? finalText.length
            : newSelection.baseOffset,
        extentOffset: newSelection.extentOffset >= finalText.length
            ? finalText.length
            : newSelection.extentOffset);
  }

  @override
  set value(TextEditingValue newValue) {
    if (newValue.selection.affinity != TextAffinity.upstream &&
        newValue.text != super.value.text) {
      try {
        String newText = newValue.text
            .substring(value.selection.start, newValue.selection.start);
        String finalText = value.selection.start > newValue.selection.start
            ? super.value.text.replaceRange(
                richTrexSelection.start, richTrexSelection.start, "@")
            : super.value.text.replaceRange(
                richTrexSelection.start, richTrexSelection.end, newText);

        text = finalText;
        selection = newValue.selection;
      } catch (e) {
        super.value = newValue;
      }
    } else if (newValue.selection.affinity != TextAffinity.upstream) {
      log(text.substring(richTrexSelection.start, text.length));
      super.value = newValue;
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
      selection = viewSource
          ? TextSelection(
              baseOffset: richSelection.start,
              extentOffset: richSelection.start + newText.length)
          : rawSelection;
    } else {
      viewSource = !viewSource;
      notifyListeners();

      selection = viewSource
          ? TextSelection(
              baseOffset: richTrexSelection.start,
              extentOffset: richTrexSelection.end)
          : RichTrexSelection.toSelection(selection: selection, text: text);
    }
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    return viewSource
        ? TextSpan(
            children: super
                .text
                .split(RegExp(
                    r'(?=<tag=".*?">)|(?<=<tag=".*?">)|(?=</tag>)|(?<=</tag>)'))
                .map((e) => TextSpan(
                    text: e,
                    style: e.contains(RegExp(r'<tag=".*?">|</tag>'))
                        ? TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.shade700)
                        : null))
                .toList(),
            style: style?.copyWith(
                fontWeight: viewSource ? FontWeight.w300 : style.fontWeight))
        : RichTrexFormat._decode(text, style: style);
  }
}
