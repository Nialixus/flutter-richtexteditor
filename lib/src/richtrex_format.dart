part of '/richtrex.dart';

class RichTrexFormat {
  TextSpan decode(String text, [TextStyle? style]) {
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
    //
    // Removed due vertical align is not centered.
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

    // Get Shadow from Tag.
    Shadow shadow(String text) {
      try {
        String blurRadius =
            RegExp(r'(?<=shadow-blur:).*?(?=;)').stringMatch(text)!;
        String x = RegExp(r'(?<=shadow-x:).*?(?=;)').stringMatch(text)!;
        String y = RegExp(r'(?<=shadow-y:).*?(?=;)').stringMatch(text)!;
        String color = RegExp(r'(?<=shadow-color:).*?(?=;)').stringMatch(text)!;
        return Shadow(
            color: Color(int.parse(color)),
            blurRadius: double.parse(blurRadius),
            offset: Offset(double.parse(x), double.parse(y)));
      } catch (e) {
        return const Shadow(
            blurRadius: 0.0, color: Colors.transparent, offset: Offset(0, 0));
      }
    }

    // Get Italic from Tag.
    FontStyle? italic(String text) {
      try {
        bool value = text.contains('decoration:italic;');
        return value == true ? FontStyle.italic : null;
      } catch (e) {
        return null;
      }
    }

    // Get Strikethrough from Tag.
    TextDecoration strikeThrough(String text) {
      try {
        bool value = text.contains('decoration:strikethrough;');
        return value == true ? TextDecoration.lineThrough : TextDecoration.none;
      } catch (e) {
        return TextDecoration.none;
      }
    }

    // Get Underline from Tag.
    TextDecoration underline(String text) {
      try {
        bool value = text.contains('decoration:underline;');
        return value == true ? TextDecoration.underline : TextDecoration.none;
      } catch (e) {
        return TextDecoration.none;
      }
    }

    // Get Overline from Tag.
    TextDecoration overline(String text) {
      try {
        bool value = text.contains('decoration:overline;');
        return value == true ? TextDecoration.overline : TextDecoration.none;
      } catch (e) {
        return TextDecoration.none;
      }
    }

    // Styled TextSpan from Tag.
    return TextSpan(
        children: List.generate(textlist.length, (x) {
      return TextSpan(
          text: newText(textlist[x]),
          style: style?.copyWith(
              leadingDistribution: TextLeadingDistribution.even,
              color: color(textlist[x]),
              fontStyle: italic(textlist[x]),
              height: fontHeight(textlist[x]),
              fontSize: fontSize(textlist[x]),
              shadows: [shadow(textlist[x])],
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
