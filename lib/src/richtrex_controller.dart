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
    richTrexSelection = RichTrexSelection.fromTextSelection(raw,
        selection: newSelection, fullText: super.text);

    super.selection = newSelection;
  }

  void onTap({required RichTrexFormat format}) {
    if (selection.isCollapsed && format._code.contains("text-raw")) {
      bool matched = bool.fromEnvironment(
          RegExp(r'(?<=text-raw:).*?(?=;)').stringMatch(format._code)!);
      if (raw == matched) {
        raw = !matched;
        notifyListeners();
      } else {
        raw = matched;
        notifyListeners();
      }
    } else {
      final int end = selection.end;

      final String newText = format._code.contains("text-raw:")
          ? text
          : text.replaceRange(richTrexSelection.start, richTrexSelection.end,
              """<style="${format._code}">${text.substring(richTrexSelection.start, richTrexSelection.end)}</style>""");

      text = newText;
      selection =
          TextSelection.collapsed(offset: raw ? richTrexSelection.end : end);
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
