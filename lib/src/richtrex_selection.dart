part of '/richtrex.dart';

class RichTrexSelection {
  final int start, end;
  final String text;
  const RichTrexSelection(
      {required this.start, required this.end, required this.text});
  factory RichTrexSelection.fromSelection(
      {required TextSelection selection, required String text}) {
    List<RichTrexSelection> richSelection =
        RegExp(r'<(style|widget)=".*?">|</(style|widget)>')
            .allMatches(text)
            .map((e) => RichTrexSelection(
                start: e.start,
                end: e.end,
                text: text.substring(e.start, e.end)))
            .toList();

    int start() {
      int index = -1;
      for (int x = 0; x < richSelection.length; x++) {
        if (selection.start +
                (x > 0
                    ? richSelection
                        .sublist(0, x)
                        .fold(0, (p, e) => p + e.text.length)
                    : 0) +
                (richSelection[x].text.contains(RegExp(r'</(style|widget)>'))
                    ? 1
                    : 0) >
            richSelection[x].start) {
          index = x;
        } else {
          break;
        }
      }

      return index < 0
          ? selection.start
          : selection.start +
              richSelection
                  .sublist(0, index + 1)
                  .fold<int>(0, (p, e) => p + e.text.length);
    }

    int end() {
      int index = -1;
      for (int x = 0; x < richSelection.length; x++) {
        if (selection.end +
                (x > 0
                    ? richSelection
                        .sublist(0, x)
                        .fold(0, (p, e) => p + e.text.length)
                    : 0) +
                (richSelection[x].text.contains(RegExp(r'</(style|widget)>'))
                    ? 1
                    : 0) >
            richSelection[x].start) {
          index = x;
        } else {
          break;
        }
      }

      return index < 0
          ? selection.end
          : selection.end +
              richSelection
                  .sublist(0, index + 1)
                  .fold<int>(0, (p, e) => p + e.text.length);
    }

    return (start() < 0 || end() < 0)
        ? const RichTrexSelection(start: 0, end: 0, text: "")
        : start() >= text.length + 1 || end() >= text.length + 1
            ? RichTrexSelection(start: text.length, end: text.length, text: "")
            : RichTrexSelection(
                start: start(),
                end: end(),
                text: text.substring(start(), end()));
  }

  static TextSelection toSelection(
      {required TextSelection selection, required String text}) {
    List<RichTrexSelection> richSelection =
        RegExp(r'<(style|widget)=".*?">|</(style|widget)>')
            .allMatches(text)
            .map((e) => RichTrexSelection(
                start: e.start,
                end: e.end,
                text: text.substring(e.start, e.end)))
            .toList();

    int start() {
      int index = -1;
      for (int x = 0; x < richSelection.length; x++) {
        if (selection.start > richSelection[x].start) {
          index = x;
        } else {
          break;
        }
      }

      return index < 0
          ? selection.start
          : (selection.start < richSelection[index].end
                  ? richSelection[index].end
                  : selection.start) -
              richSelection
                  .sublist(0, index + 1)
                  .fold<int>(0, (p, e) => p + e.text.length);
    }

    int end() {
      int index = -1;
      for (int x = 0; x < richSelection.length; x++) {
        if (selection.end +
                (richSelection[x].text.contains(RegExp(r'</(style|widget)>'))
                    ? 1
                    : 0) >
            richSelection[x].start) {
          index = x;
        } else {
          break;
        }
      }

      return index < 0
          ? selection.end
          : (selection.end < richSelection[index].end
                  ? richSelection[index].end
                  : selection.end) -
              richSelection
                  .sublist(0, index + 1)
                  .fold<int>(0, (p, e) => p + e.text.length);
    }

    return TextSelection(baseOffset: start(), extentOffset: end());
  }

  @override
  String toString() {
    return "RichTrexSelection(start: $start, end: $end, text: $text)";
  }
}
