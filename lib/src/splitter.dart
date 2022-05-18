import 'package:flutter/material.dart';

class RichTextSpan {
  final String string;
  RichTextSpan(this.string);

  TextSpan get result => TextSpan(
      children: List.generate(
          split(string).length, (index) => span(split(string)[index])));

  List<String> split(String string) {
    List<String> splits = string.split("[@split]->");
    return splits;
  }

  /// Co
  Color? color(String string) {
    const String tag = "[@font-color:";
    String contentTag = "0xffffffff";
    try {
      return Color(int.parse(string.substring(string.indexOf(tag) + tag.length,
          string.indexOf(tag) + tag.length + contentTag.length)));
    } catch (e) {
      return null;
    }
  }

  String text(String string) {
    const String openTag = "[@";
    const String closeTag = "]->";
    try {
      return string.replaceRange(string.indexOf(openTag),
          string.lastIndexOf(closeTag) + closeTag.length, "");
    } catch (e) {
      return string;
    }
  }

  FontWeight? fontWeight(String string) {
    // weight length = 1;
    const String tag = "[@font-weight:";
    try {
      return FontWeight.values[int.parse(string.substring(
          string.indexOf(tag) + tag.length,
          string.indexOf(tag) + tag.length + 1))];
    } catch (e) {
      return FontWeight.normal;
    }
  }

  TextSpan span(String string) {
    return TextSpan(
        text: text(string),
        style: TextStyle(color: color(string), fontWeight: fontWeight(string)));
  }
}

extension RichTextEntension on String {
  TextSpan get span => RichTextSpan(this).result;
}
