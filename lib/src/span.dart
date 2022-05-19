import 'package:flutter/material.dart';
import 'format.dart';
import 'extension.dart';

export 'span.dart' hide RichTextSpan;

class RichTextSpan {
  /// Splitting [String] into [List] of String.
  List<String> split(String string) {
    return string.multiSplit(["<style=", "</style>"]);
  }

  /// Decode [Color] from [String].
  Color? color(String string) {
    // Color's tag.
    String tag = "font-color:";
    // Content tag sample.
    String contentTag = "0xffffffff";

    if (string.contains(tag)) {
      String colorString = string.substring(string.indexOf(tag) + tag.length,
          string.indexOf(tag) + tag.length + contentTag.length);
      return Color(int.parse(colorString));
    } else {
      return null;
    }
  }

  /// Decode [FontWeight] from [String].
  FontWeight? fontWeight(String string) {
    // FontWeight's tag.
    String tag = "font-weight:";

    if (string.contains(tag)) {
      String weightString = string.substring(string.indexOf(tag) + tag.length,
          string.indexOf(tag) + tag.length + 1);
      return FontWeight.values[int.parse(weightString)];
    } else {
      return null;
    }
  }

  /// Cleaning [String] from [RichTextFormat].
  String cleanText(String string) {
    // Text before format "
    const String openTag = '''"''';

    // Text after format ">
    const String closeTag = '''">''';

    try {
      return string.replaceRange(string.indexOf(openTag),
          string.indexOf(closeTag) + closeTag.length, "");
    } catch (e) {
      return string;
    }
  }

  /// Wrapping every parameter into [TextSpan].
  TextSpan span(String string) {
    return TextSpan(
        text: cleanText(string),
        style: TextStyle(color: color(string), fontWeight: fontWeight(string)));
  }

  /// Decode [TextSpan] to plain [String].
  String toOrigin(TextSpan span) {
    List<InlineSpan> children = span.children ?? [];
    List<String> listOrigin = List.generate(children.length, (index) {
      InlineSpan childSpan = children[index];
      if (childSpan.style?.color != null ||
          childSpan.style?.fontWeight != null) {
        String colorString() {
          return childSpan.style?.color == null
              ? ""
              : "font-color:0x${childSpan.style!.color!.value.toRadixString(16)};";
        }

        String weightString() {
          return childSpan.style?.fontWeight == null
              ? ""
              : "font-weight:${childSpan.style!.fontWeight!.index};";
        }

        return """<style="${colorString()}${weightString()}">${childSpan.toPlainText()}</style>""";
      } else {
        return childSpan.toPlainText();
      }
    });

    return listOrigin.join("");
  }

  /// Encode [String] to [TextSpan].
  TextSpan toSpan(String string) => TextSpan(
      children: List.generate(
          split(string).length, (index) => span(split(string)[index])));
}
