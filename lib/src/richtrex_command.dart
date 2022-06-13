part of '/richtrex.dart';

class RichTrexCommand {
  final String code;
  final String name;
  final String value;

  RichTrexCommand({required this.name, required this.value})
      : code = "$name:$value;";

  RichTrexCommand.map({required Map<String, String> map})
      : name = "",
        value = "",
        code =
            '${List.generate(map.length, (x) => "${map.keys.toList()[x]}:${map.values.toList()[x]}").join(";")};';

  RichTrexCommand.fontColor({required Color value})
      : this(name: 'font-color', value: '0x${value.value.toRadixString(16)}');

  RichTrexCommand.backgroundColor({required Color value})
      : this(
            name: 'background-color',
            value: '0x${value.value.toRadixString(16)}');

  RichTrexCommand.fontWeight({required FontWeight value})
      : this(name: "font-weight", value: '${value.index}');

  RichTrexCommand.fontHeight({required double value})
      : this(name: 'font-height', value: '$value');

  RichTrexCommand.fontFamily({required String value})
      : this(name: "font-family", value: value);

  RichTrexCommand.fontSize({required double value})
      : this(name: "font-size", value: '$value');

  RichTrexCommand.fontSpace({required double value})
      : this(name: 'font-space', value: '$value');

  RichTrexCommand.shadow({required Shadow value})
      : this.map(map: {
          "shadow-color": "0x${value.color.value.toRadixString(16)}",
          "shadow-x": "${value.offset.dx}",
          "shadow-y": "${value.offset.dy}",
          "shadow-blur": "${value.blurRadius}"
        });

  RichTrexCommand.italic() : this(name: "decoration", value: 'italic');

  RichTrexCommand.strikeThrough()
      : this(name: "decoration", value: "strikethrough");

  RichTrexCommand.underline() : this(name: "decoration", value: "underline");

  RichTrexCommand.overline() : this(name: "decoration", value: "overline");

  RichTrexCommand.viewSource({required bool value})
      : this(name: "view-source", value: '$value');

  @override
  String toString() =>
      'RichTrexCommand(name: $name, value: $value, code: "$code")';
}
