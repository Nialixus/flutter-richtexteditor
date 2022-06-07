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
    var oldT = value.text.split('');
    var newT = newValue.text.split('');
    List left = List.generate(newT.length, (x) {
      try {
        return newT[x] == oldT[x];
      } catch (e) {
        return false;
      }
    });
    List right = List.generate(newT.length, (x) {
      var oldT2 = oldT.reversed.toList();
      var newT2 = newT.reversed.toList();
      try {
        return newT2[x] == oldT2[x];
      } catch (e) {
        return false;
      }
    });
    if (newValue.selection.affinity != TextAffinity.upstream &&
        newValue.text != super.value.text) {
      log(left.indexWhere((val) => val == false).toString() +
          '\n' +
          right.indexWhere((val) => val == false).toString());
    }

    super.value = newValue;
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
      selection = richTrexRaw
          ? TextSelection(
              baseOffset: richSelection.start, extentOffset: newText.length)
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
