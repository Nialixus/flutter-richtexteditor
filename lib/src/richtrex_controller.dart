part of '/richtrex.dart';

/// State manager or [RichTrex].
///
/// Connecting text editor and command button.
class RichTrexController extends TextEditingController {
  RichTrexController(
      {String? text, this.viewSource = false, List<RichTrexFormat>? formats})
      : formats = formats ??
            [
              /* RichTrexFormat.color(value: Colors.red),
                
                 RichTrexFormat.image(
                    value:
                        "https://4.img-dpreview.com/files/p/E~TS590x0~articles/3925134721/0266554465.jpeg"),*/
              RichTrexFormat.bold(value: FontWeight.w900),
              //  RichTrexFormat.viewsource(value: viewSource),
            ],
        super(text: text);

  final List<RichTrexFormat> formats;
  bool viewSource;
  late RichTrexSelection selectionSource =
      RichTrexSelection.fromSelection(selection: selection, text: text);

  @override
  set selection(TextSelection newSelection) {
    selectionSource = viewSource
        ? RichTrexSelection(
            end: newSelection.end,
            start: newSelection.start,
            text: text.substring(newSelection.start, newSelection.end))
        : RichTrexSelection.fromSelection(
            selection: newSelection, text: super.text);
    final String finalText = viewSource
        ? text
        : RichTrexFormat._decode(text, formats: formats).toPlainText();
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
            ? super
                .value
                .text
                .replaceRange(selectionSource.start, selectionSource.start, "@")
            : super.value.text.replaceRange(
                selectionSource.start, selectionSource.end, newText);

        text = finalText;
        selection = newValue.selection;
      } catch (e) {
        super.value = newValue;
      }
    } else if (newValue.selection.affinity != TextAffinity.upstream) {
      //log(text.substring(selectionSource.start, text.length));
      super.value = newValue;
    } else {
      super.value = newValue;
    }
  }

  void onTap({required RichTrexFormat format}) async {
    if (!format.code.contains("view-source")) {
      final TextSelection rawSelection = selection;
      final String newText =
          """<${format.type}="${format.code}">${text.substring(selectionSource.start, selectionSource.end)}</${format.type}>""";
      final TextSelection richSelection = TextSelection(
          baseOffset: rawSelection.start, extentOffset: rawSelection.end);
      text = text.replaceRange(
          selectionSource.start, selectionSource.end, newText);
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
              baseOffset: selectionSource.start,
              extentOffset: selectionSource.end)
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
                    r'(?=<(style|widget)=".*?">)|(?<=<(style|widget)=".*?">)|(?=</(style|widget)>)|(?<=</(style|widget)>)'))
                .map((e) => TextSpan(
                    text: e,
                    style: e.contains(
                            RegExp(r'<(style|widget)=".*?">|</(style|widget)>'))
                        ? TextStyle(
                            fontWeight: FontWeight.w400,
                            color: Colors.blue.shade700)
                        : null))
                .toList(),
            style: style?.copyWith(
                fontWeight: viewSource ? FontWeight.w300 : style.fontWeight))
        : RichTrexFormat._decode(text, formats: formats);
  }
}
