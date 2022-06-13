part of '/richtrex.dart';

/// Command to execute changing Plain Text into Rich Text.
class RichTrexCommand {
  /// End result of [map] which will be used in [RichTrexController].
  final String code;

  /// Input which will be converted into [code].
  final Map<String, String> map;

  /// Executing [code] from [map].
  RichTrexCommand({required this.map})
      : code =
            '$map'.replaceAll(RegExp(r'{|}|\s'), "").replaceAll(",", ";") + ';';

  /// Executing command to change Text Color.
  RichTrexCommand.fontColor({required Color value})
      : this(map: {'font-color': '0x${value.value.toRadixString(16)}'});

  /// Executing command to change Background Color.
  RichTrexCommand.backgroundColor({required Color value})
      : this(map: {'background-color': '0x${value.value.toRadixString(16)}'});

  /// Executing command to change Boldness of Text.
  RichTrexCommand.fontWeight({required FontWeight value})
      : this(map: {'font-weight': '${value.index}'});

  /// Executing command to change Text Height.
  RichTrexCommand.fontHeight({required double value})
      : this(map: {'font-height': '$value'});

  /// Executing command to change Font Family of Text.
  RichTrexCommand.fontFamily({required String value})
      : this(map: {"font-family": value});

  /// Executing command to change Text Size.
  RichTrexCommand.fontSize({required double value})
      : this(map: {"font-size": '$value'});

  /// Executing command to change Space between Letter.
  RichTrexCommand.fontSpace({required double value})
      : this(map: {'font-space': '$value'});

  /// Executing command to give shadow upon Text.
  RichTrexCommand.shadow({required Shadow value})
      : this(map: {
          "shadow-color": "0x${value.color.value.toRadixString(16)}",
          "shadow-x": "${value.offset.dx}",
          "shadow-y": "${value.offset.dy}",
          "shadow-blur": "${value.blurRadius}"
        });

  /// Executing command to make Text Skewed.
  RichTrexCommand.italic() : this(map: {"decoration": 'italic'});

  /// Executing command to give Line through Text
  RichTrexCommand.strikeThrough() : this(map: {"decoration": "strikethrough"});

  /// Executing command to give Line below Text
  RichTrexCommand.underline() : this(map: {"decoration": "underline"});

  /// Executing command to give Line above Text
  RichTrexCommand.overline() : this(map: {"decoration": "overline"});

  /// Executing command to view source code of Rich Text.
  RichTrexCommand.viewSource({required bool value})
      : this(map: {"view-source": '$value'});

  @override
  String toString() => 'RichTrexCommand(map: $map, code: "$code")';
}
