import 'package:flutter/material.dart';
import 'format.dart';

export 'span.dart' hide RichTextSpan;

class RichTextSpan {
  /// Splitting [String] into [List] of String.
  List<String> split(String string) {
    List<String> newlist = string.split(RegExp(r'<style=|</style>'));
    return newlist;
  }

  /// Decode [Color] from [String].
  Color? color(String string) {
    try {
      RegExp regex = RegExp(r'(?<=font-color:).*?(?=;)');
      String color = regex.stringMatch(string)!;
      return Color(int.parse(color));
    } catch (e) {
      return null;
    }
  }

  /// Decode [FontWeight] from [String].
  FontWeight? fontWeight(String string) {
    try {
      RegExp regex = RegExp(r'(?<=font-weight:).');
      String weight = regex.stringMatch(string)!;
      return FontWeight.values[int.parse(weight)];
    } catch (e) {
      return null;
    }
  }

  /// Cleaning [String] from [RichTextFormat].
  String cleanText(String string) {
    try {
      return string.replaceAll(RegExp(r'".*">'), "");
    } catch (e) {
      return string;
    }
  }

  /// Wrapping every parameter into [InlineSpan].
  InlineSpan span(String string) {
    return TextSpan(
        text: cleanText(string),
        style: TextStyle(color: color(string), fontWeight: fontWeight(string)));
  }

  /// Encode [String] to [TextSpan].
  TextSpan toSpan(String string) => TextSpan(
      children: List.generate(
          split(string).length, (index) => span(split(string)[index])),
      style: const TextStyle(color: Colors.black));
}
