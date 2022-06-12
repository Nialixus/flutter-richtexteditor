part of '/richtrex.dart';

class RichTrexCommand {
  final String code;
  final String name;
  final String value;

  RichTrexCommand({required this.name, required this.value})
      : code = "$name:$value;";

  @override
  String toString() =>
      'RichTrexCommand(name: $name, value: $value, code: "$code")';

  static RichTrexCommand bold({required FontWeight value}) {
    return RichTrexCommand(name: "font-color", value: '$value');
  }

  static RichTrexCommand color({required Color value}) {
    return RichTrexCommand(
        name: "font-color", value: '0x${value.value.toRadixString(16)}');
  }

  static RichTrexCommand viewsource({required bool value}) {
    return RichTrexCommand(name: "view-source", value: '$value');
  }
}

class RichTrexFormat extends TextSpan {
  const RichTrexFormat(
      {String? text,
      Locale? locale,
      bool? spellOut,
      TextStyle? style,
      String? semanticsLabel,
      MouseCursor? mouseCursor,
      List<InlineSpan>? children,
      GestureRecognizer? recognizer,
      void Function(PointerExitEvent)? onExit,
      void Function(PointerEnterEvent)? onEnter})
      : super(
            text: text,
            style: style,
            locale: locale,
            onExit: onExit,
            onEnter: onEnter,
            children: children,
            spellOut: spellOut,
            recognizer: recognizer,
            mouseCursor: mouseCursor,
            semanticsLabel: semanticsLabel);

  factory RichTrexFormat.decode(String text, {TextStyle? style}) {
    // Split text between Tagged Text and Plain Text.
    List<String> textlist = text.split(RegExp(
        r'(?=<(style|widget)=.*?</(style|widget)>)|(?<=<(style|widget)=.*?</(style|widget)>)'));

    // Clean Text from Tag.
    String newText(String text) {
      try {
        return text.replaceAll(
            RegExp(r'(<(style|widget)=".*?">)|(</(style|widget)>)'), "");
      } catch (e) {
        return text;
      }
    }

    // Get Color from Tag.
    Color? color(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-color:).*?(?=;)');
        String color = regex.stringMatch(text)!;
        return Color(int.parse(color));
      } catch (e) {
        return null;
      }
    }

    // Get FontWeight from Tag.
    FontWeight? fontWeight(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-weight:).*?(?=;)');
        String weight = regex.stringMatch(text)!;
        return FontWeight.values[int.parse(weight)];
      } catch (e) {
        return null;
      }
    }

    // Styled TextSpan from Tag.
    return RichTrexFormat(
        children: List.generate(textlist.length, (x) {
      return TextSpan(
          text: newText(textlist[x]),
          style: style?.copyWith(
              color: color(textlist[x]), fontWeight: fontWeight(textlist[x])));
    }));
  }
}
