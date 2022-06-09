import 'package:richtrex/richtrex.dart';

RichTrexSelection compareString(String oldValue, String newValue) {
  int start() {
    int first = 0;
    for (int i = 0; i < newValue.length; i++) {
      if (newValue[i] == oldValue[i]) {
        first = i;
      } else {
        break;
      }
    }
    return first + 1;
  }

  int end() {
    var newLength = newValue.length;
    var oldLength = oldValue.length;
    int last = newLength - 1;
    for (int i = 0; i < newLength; i++) {
      if (newValue[(newLength - 1) - i] == oldValue[(oldLength - 1) - i]) {
        last = (newLength - 1) - i;
      } else {
        break;
      }
    }
    return last;
  }

  return RichTrexSelection(
      start: start(), end: end(), text: newValue.substring(start(), end()));
}

extension CompareString on String {
  RichTrexSelection compareWith(String newValue) =>
      compareString(this, newValue);
}
