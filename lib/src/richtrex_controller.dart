part of '/richtrex.dart';

/// State manager or [RichTrex].
///
/// Connecting text editor and command button.
class RichTrexController extends TextEditingController {
  RichTrexController({String? text}) : super(text: text);

  bool richTrexRaw = false;
  String character = "";
  RichTrexHistory richTrexHistory = RichTrexHistory(index: 0, history: []);
  late RichTrexSelection richTrexSelection = RichTrexSelection(
      start: 0,
      end: super.text.length,
      text: super.text.substring(0, super.text.length));

  void updateCharacter(String newCharacter) {
    character = newCharacter;

    String startText = super.text.substring(0, richTrexSelection.end);
    String endText = super.text.substring(richTrexSelection.end, text.length);

    log(startText + character + endText);

    notifyListeners();

    text = startText + character + endText;
    selection = TextSelection.collapsed(
        offset: startText.span.toPlainText().length + character.length);
  }

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
      final RichTrexSelection oldSelection = richTrexSelection;
      int start = newValue.text
          .split('')
          .asMap()
          .entries
          .map((e) {
            try {
              return e.value == value.text.split('')[e.key];
            } catch (e) {
              return false;
            }
          })
          .toList()
          .indexWhere((val) => val == false);
      int end = newValue.text.length -
          newValue.text
              .split("")
              .reversed
              .toList()
              .asMap()
              .entries
              .map((e) {
                try {
                  return e.value ==
                      value.text.split('').reversed.toList()[e.key];
                } catch (e) {
                  return false;
                }
              })
              .toList()
              .indexWhere((val) => val == false);

      try {
        final firstString = newValue.text.substring(0, richTrexSelection.start);
        final lastString = newValue.text
            .substring(richTrexSelection.end, newValue.text.length);
        final midString = newValue.text.substring(start, end);

        log(firstString + midString + lastString);

        super.value = newValue;
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
        ? TextSpan(text: text, style: style)
        : RichTrexFormat._decode(text, style: style);
  }
}
