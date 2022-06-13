import 'package:flutter/material.dart';
import 'package:richtrex/richtrex.dart';

export 'richtrex_toolbar.dart' hide RichTrexToolbar;

class RichTrexToolbar extends StatefulWidget {
  const RichTrexToolbar({Key? key, required this.controller}) : super(key: key);
  final RichTrexController controller;

  @override
  State<RichTrexToolbar> createState() => _RichTrexToolbarState();
}

class _RichTrexToolbarState extends State<RichTrexToolbar> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() => widget.controller));
  }

  @override
  Widget build(BuildContext context) {
    List<RichTrexCommand> format = [
      RichTrexCommand.underline(),
      RichTrexCommand.overline(),
      RichTrexCommand.strikeThrough(),
      RichTrexCommand.viewSource(value: widget.controller.viewSource),
      RichTrexCommand.italic(),
      RichTrexCommand.shadow(
          value: const Shadow(color: Colors.red, blurRadius: 10.0)),
      RichTrexCommand.fontColor(value: Colors.red),
      RichTrexCommand.fontSpace(value: 100.0),
      RichTrexCommand.fontSize(value: 30.0),
      RichTrexCommand.fontHeight(value: 10.0),
      RichTrexCommand.fontWeight(value: FontWeight.w900),
      RichTrexCommand.fontFamily(value: "Times New Roman"),
    ];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (int x = 0; x < format.length; x++)
            MaterialButton(
                onPressed: () {
                  widget.controller.onTap(format: format[x]);
                },
                child: Text(x.toString())),
        ],
      ),
    );
  }
}
