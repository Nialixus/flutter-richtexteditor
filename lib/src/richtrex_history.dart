part of '/richtrex.dart';

class RichTrexHistory {
  final int index;
  final List<String> history;

  RichTrexHistory({required this.index, required this.history});

  @override
  String toString() {
    return "RichTrexHistory(index: $index, history: $history)";
  }
}
