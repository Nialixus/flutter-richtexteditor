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
    return RichTrexCommand(name: "font-weight", value: '$value');
  }

  static RichTrexCommand color({required Color value}) {
    return RichTrexCommand(
        name: "font-color", value: '0x${value.value.toRadixString(16)}');
  }

  static RichTrexCommand viewsource({required bool value}) {
    return RichTrexCommand(name: "view-source", value: '$value');
  }
}
