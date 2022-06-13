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
      // Basic WYISWYG
      RichTrexCommand.fontWeight(value: FontWeight.w900),
      RichTrexCommand.italic(),
      RichTrexCommand.underline(),
      RichTrexCommand.strikeThrough(),
      RichTrexCommand.overline(),

      // Colors
      RichTrexCommand.fontColor(value: Colors.red),
      RichTrexCommand.backgroundColor(value: Colors.red),
      RichTrexCommand.shadow(
          value: const Shadow(color: Colors.red, blurRadius: 10.0)),

      // Fonts
      RichTrexCommand.fontSize(value: 30.0),
      RichTrexCommand.fontHeight(value: 10.0),
      RichTrexCommand.fontFamily(value: "Times New Roman"),
      RichTrexCommand.fontSpace(value: 100.0),

      // Misc
      RichTrexCommand.viewSource(value: widget.controller.viewSource),
    ];

    Widget divider = Container(
      width: 1,
      height: 45,
      color: Colors.black12,
    );

    return Container(
      height: 45.0,
      constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width),
      decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 2.5)]),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int x = 0; x < format.length; x++)
              Tooltip(
                preferBelow: false,
                message: [
                  // Basic
                  "Bold",
                  "Italic",
                  "Underline",
                  "Strike Through",
                  "Overline",

                  // Colors
                  "Color",
                  "Background Color",
                  "Shadow",

                  // Fonts
                  "Font Size",
                  "Height",
                  "Font Family",
                  "Space",

                  // Misc
                  "View Source"
                ][x],
                child: Material(
                  child: InkWell(
                      onTap: () => widget.controller.onTap(format: format[x]),
                      child: SizedBox(
                        width: 45.0,
                        height: 45.0,
                        child: Icon([
                          // Basic
                          Icons.format_bold,
                          Icons.format_italic,
                          Icons.format_underline,
                          Icons.format_strikethrough,
                          Icons.format_overline,

                          // Colors
                          Icons.format_color_text,
                          Icons.format_color_fill,
                          Icons.fiber_smart_record_outlined,

                          // Fonts
                          Icons.format_size,
                          Icons.height,
                          Icons.font_download,
                          Icons.space_bar,

                          // Misc
                          widget.controller.viewSource
                              ? Icons.code_off
                              : Icons.code
                        ][x]),
                      )),
                ),
              )
          ]
            ..insert(5, divider)
            ..insert(9, divider)
            ..insert(14, divider),
        ),
      ),
    );
  }
}
