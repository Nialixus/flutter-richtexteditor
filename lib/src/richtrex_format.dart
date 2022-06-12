part of '/richtrex.dart';

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
        String value = regex.stringMatch(text)!;
        return Color(int.parse(value));
      } catch (e) {
        return null;
      }
    }

    // Get Background-Color from Tag.
    Color? backgroundColor(String text) {
      try {
        RegExp regex = RegExp(r'(?<=background-color:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return Color(int.parse(value));
      } catch (e) {
        return null;
      }
    }

    // Get Font-Weight from Tag.
    FontWeight? fontWeight(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-weight:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return FontWeight.values[int.parse(value)];
      } catch (e) {
        return null;
      }
    }

    // Get Font-Height from Tag.
    double? fontHeight(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-height:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    // Get Font-Family from Tag.
    String? fontFamily(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-family:).*?(?=;)');
        return regex.stringMatch(text)!;
      } catch (e) {
        return null;
      }
    }

    // Get Font-Size from Tag.
    double? fontSize(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-size:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    // Get Font-Height from Tag.
    double? fontSpace(String text) {
      try {
        RegExp regex = RegExp(r'(?<=font-space:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return double.parse(value);
      } catch (e) {
        return null;
      }
    }

    // Get Font-Shadow from Tag.
    Shadow fontShadow(String text) {
      try {
        /*
        RegExp regex = RegExp(r'(?<=font-space:).*?(?=;)');
        String value = regex.stringMatch(text)!;*/
        return const Shadow();
      } catch (e) {
        return const Shadow(
            blurRadius: 0.0, color: Colors.transparent, offset: Offset(0, 0));
      }
    }

    // Get Italic from Tag.
    FontStyle? italic(String text) {
      try {
        RegExp regex = RegExp(r'(?<=decoration-italic:).*?(?=;)');
        String value = regex.stringMatch(text)!;
        return FontStyle.values[int.parse(value)];
      } catch (e) {
        return null;
      }
    }

    // Get Strikethrough from Tag.
    TextDecoration strikeThrough(String text) {
      RegExp regex = RegExp(r'(?<=decoration-strikethrough:).*?(?=;)');
      if (text.contains(regex) == true) {
        return TextDecoration.lineThrough;
      } else {
        return TextDecoration.none;
      }
    }

    // Get Underline from Tag.
    TextDecoration underline(String text) {
      RegExp regex = RegExp(r'(?<=decoration-underline:).*?(?=;)');
      if (text.contains(regex) == true) {
        return TextDecoration.underline;
      } else {
        return TextDecoration.none;
      }
    }

    // Get Overline from Tag.
    TextDecoration overline(String text) {
      RegExp regex = RegExp(r'(?<=decoration-overline:).*?(?=;)');
      if (text.contains(regex) == true) {
        return TextDecoration.overline;
      } else {
        return TextDecoration.none;
      }
    }

    // Styled TextSpan from Tag.
    return RichTrexFormat(
        children: List.generate(textlist.length, (x) {
      return TextSpan(
          text: newText(textlist[x]),
          style: style?.copyWith(
              color: color(textlist[x]),
              fontStyle: italic(textlist[x]),
              height: fontHeight(textlist[x]),
              fontSize: fontSize(textlist[x]),
              shadows: [fontShadow(textlist[x])],
              fontWeight: fontWeight(textlist[x]),
              fontFamily: fontFamily(textlist[x]),
              letterSpacing: fontSpace(textlist[x]),
              backgroundColor: backgroundColor(textlist[x]),
              decoration: TextDecoration.combine([
                overline(textlist[x]),
                underline(textlist[x]),
                strikeThrough(textlist[x])
              ])));
    }));
  }
}
