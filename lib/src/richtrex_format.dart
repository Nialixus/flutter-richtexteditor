part of '/richtrex.dart';

class RichTrexFormat {
  /*
  final String code;
  final String name;
  final InlineSpan builder;
  final String input;
  final String type;
  final Value? output;

  RichTrexFormat(
      {required this.name,
      required this.input,
      required this.builder,
      required Value? Function(String? value) output})
      : type = builder is WidgetSpan ? "widget" : "style",
        code = "$name:$input;",
        output = output(RegExp('''(?<=$name:).*?;''').stringMatch(input));

  @override
  String toString() =>
      'RichTrexFormat(name: $name, type: $type, input: $input, output: $output, code: "$code", span: $builder)';
*/
  final InlineSpan span;
  RichTrexFormat({required this.span});

  static RichTrexFormat bold({required FontWeight value}) {
    return RichTrexFormat(
        span: const TextSpan(style: TextStyle(fontWeight: FontWeight.bold)));
    /*
    return RichTrexFormat<TextSpan, FontWeight>(
        name: "font-weight",
        input: '${value.index}',
        builder: TextSpan(style: TextStyle(fontWeight: FontWeight.bold)),
        output: (value) {
          return value != null ? FontWeight.values[int.parse(value)] : null;
        });*/
  } /* 

  static RichTrexFormat image({required String value}) {
    return RichTrexFormat<WidgetSpan, Image>(
        name: "image",
        value: value,
        builder: (span, value) {
          var newSpan = span.copyWith(child: Image.network(value!));
          return newSpan;
        });
  }

  static RichTrexFormat color({required Color value}) {
    return RichTrexFormat<String>(
        name: "font-color", value: '0x${value.value.toRadixString(16)}');
  }
*/
/*
  static RichTrexFormat viewsource({required bool value}) {
    return RichTrexFormat<InlineSpan, bool>(
        name: "view-source",
        value: '$value',
        builder: (span, value) {
          return span;
        });
  }*/

  /// Splitting [String] into [List] of String.
  static List<String> _split(String string) {
    List<String> newlist = string.split(RegExp(
        r'(?=<(style|widget)=.*?</(style|widget)>)|(?<=<(style|widget)=.*?</(style|widget)>)'));
    return newlist;
  }

  /// Decode [Color] from [String].
  static Color? _color(String string) {
    try {
      RegExp regex = RegExp(r'(?<=font-color:).*?(?=;)');
      String color = regex.stringMatch(string)!;
      return Color(int.parse(color));
    } catch (e) {
      return null;
    }
  }

  /// Decode [FontWeight] from [String].
  static FontWeight? _fontWeight(String string) {
    try {
      RegExp regex = RegExp(r'(?<=font-weight:).');
      String weight = regex.stringMatch(string)!;
      return FontWeight.values[int.parse(weight)];
    } catch (e) {
      return null;
    }
  }

  /// Cleaning [String] from [RichTextFormat].
  static String _text(String string) {
    try {
      return string.replaceAll(
          RegExp(r'(<(style|widget)=".*?">)|(</(style|widget)>)'), "");
    } catch (e) {
      return string;
    }
  }

  /// Wrapping every parameter into [InlineSpan].
  static InlineSpan _span(String string) {
    if (string.contains(RegExp(r'<style=.*?>|</style>'))) {
      return TextSpan(
          text: _text(string),
          style: TextStyle(
              color: _color(string), fontWeight: _fontWeight(string)));
    } else if (string.contains(RegExp(r'<widget=.*?>|</widget>'))) {
      return const WidgetSpan(child: SizedBox());
    } else {
      return TextSpan(text: string);
    }
  }

  /// Decode [String] to [TextSpan].
  static TextSpan _decode(String string,
      {TextStyle style = const TextStyle(color: Colors.black),
      required List<RichTrexFormat> formats}) {
    var split = _split(string);
    log(formats[0].builder.toString());
    return TextSpan(
        children: List.generate(split.length, (index) {
          if (string.contains(RegExp(r'<widget=.*?>|</widget>'))) {
            return const WidgetSpan(child: SizedBox());
          } else {
            return TextSpan(text: split[index], style: style.copyWith());
          }
        }),
        style: style);
  }
}
