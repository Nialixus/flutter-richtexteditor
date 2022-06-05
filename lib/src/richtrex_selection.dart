part of '/richtrex.dart';

class RichTrexSelection {
  final int start, end;
  final String text;
  const RichTrexSelection(
      {required this.start, required this.end, required this.text});
  factory RichTrexSelection.fromTextSelection(
      {required TextSelection selection, required String text}) {
    List<RichTrexSelection> richSelection = RegExp(r'<tag=".*?">|</tag>')
        .allMatches(text)
        .map((e) => RichTrexSelection(
            start: e.start, end: e.end, text: text.substring(e.start, e.end)))
        .toList();

    int start() {
      List<bool> selected = [
        for (int x = 0; x < richSelection.length; x++)
          selection.start +
                  (x > 0
                      ? richSelection
                          .sublist(0, x)
                          .fold(0, (p, e) => p + e.text.length)
                      : 0) >
              richSelection[x].start
      ];

      return selected.contains(true)
          ? selection.start +
              richSelection
                  .sublist(0, selected.lastIndexWhere((val) => val == true) + 1)
                  .fold<int>(0, (p, e) => p + e.text.length)
          : selection.start;
    }

    int end() {
      List<bool> selected = [
        for (int x = 0; x < richSelection.length; x++)
          selection.end +
                  (x > 0
                      ? richSelection
                          .sublist(0, x)
                          .fold(0, (p, e) => p + e.text.length)
                      : 0) +
                  (richSelection[x].text.contains(RegExp(r'</tag>')) ? 1 : 0) >
              richSelection[x].start
      ];

      return selected.contains(true)
          ? selection.end +
              richSelection
                  .sublist(0, selected.lastIndexWhere((val) => val == true) + 1)
                  .fold<int>(0, (p, e) => p + e.text.length)
          : selection.end;
    }

    // log("raw(${selection.start} ${selection.end});rich(${start()} ${end()})");

    return RichTrexSelection(
        start: start(), end: end(), text: text.substring(start(), end()));
  }

  static TextSelection toTextSelection(
      {required TextSelection selection, required String text}) {
    List<RichTrexSelection> richSelection = RegExp(r'<tag=".*?">|</tag>')
        .allMatches(text)
        .map((e) => RichTrexSelection(
            start: e.start, end: e.end, text: text.substring(e.start, e.end)))
        .toList();

    int start() {
      List<bool> selected = [
        for (int x = 0; x < richSelection.length; x++)
          selection.start > richSelection[x].start
      ];

      int lastRichSelection = selected.lastIndexWhere((val) => val == true);

      return selected.contains(true)
          ? (selection.start < richSelection[lastRichSelection].end
                  ? richSelection[lastRichSelection].end
                  : selection.start) -
              richSelection
                  .sublist(0, lastRichSelection + 1)
                  .fold<int>(0, (p, e) => p + e.text.length)
          : selection.start;
    }

    int end() {
      List<bool> selected = [
        for (int x = 0; x < richSelection.length; x++)
          selection.end +
                  (richSelection[x].text.contains(RegExp(r'</tag>')) ? 1 : 0) >
              richSelection[x].start
      ];

      int lastRichSelection = selected.lastIndexWhere((val) => val == true);

      return selected.contains(true)
          ? (selection.end < richSelection[lastRichSelection].end
                  ? richSelection[lastRichSelection].end
                  : selection.end) -
              richSelection
                  .sublist(0, lastRichSelection + 1)
                  .fold<int>(0, (p, e) => p + e.text.length)
          : selection.end;
    }

    return TextSelection(baseOffset: start(), extentOffset: end());
  }

  @override
  String toString() {
    return "RichTrexSelection(start: $start, end: $end, text: $text)";
  }
}

extension TextSelectionString on TextSelection {
  String asString(String text) {
    return '$this'
        .replaceAll(RegExp(r'(affinity|isDirectional).*?(true|false)'),
            'text: ${textInside(text)}')
        .replaceAll('baseOffset', 'start')
        .replaceAll('extentOffset', 'end');
  }
}
