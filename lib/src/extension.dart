import 'package:flutter/material.dart';

import 'format.dart';
import 'span.dart';

export 'extension.dart' hide RichTextStringEntension;

extension RichTextStringEntension on String {
  TextSpan get span => RichTextSpan().toSpan(this);

  List<String> multiSplit(Iterable<String> delimeters) => delimeters.isEmpty
      ? [this]
      : split(RegExp(delimeters.map(RegExp.escape).join('|')));

  TextSelection selection(int start, int end) {
    if (isformatted(end)) {
      return TextSelection(
          baseOffset: start + RichTextFormatCodes.list.length,
          extentOffset: end + RichTextFormatCodes.list.length);
    } else {
      return TextSelection(baseOffset: start, extentOffset: end);
    }
  }

  bool isformatted(int end) {
    if (substring(0, end).contains("<")) {
      try {
        if (substring(0, end + '''style="'''.length).contains('''<style="''')) {
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }
}

extension RichTextSpanExtension on TextSpan {
  String get origin => RichTextSpan().toOrigin(this);
}
