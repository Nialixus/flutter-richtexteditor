import 'package:flutter/material.dart';
import 'package:richtrex/richtrex.dart';
import 'package:richtrex/src/addons/richtrex_colorpicker.dart';

export 'richtrex_toolbar.dart' hide RichTrexToolbar;

class RichTrexToolbar extends StatefulWidget {
  const RichTrexToolbar(
      {Key? key,
      required this.controller,
      this.bold = true,
      this.italic = true,
      this.underline = true,
      this.strikethrough = true,
      this.overline = true,
      this.fontColor = true,
      this.backgroundColor = true,
      this.shadow = true,
      this.fontSize = true,
      this.fontHeight = true,
      this.fontFamily = true,
      this.fontSpace = true,
      this.viewSource = true,
      this.fontColorValue = Colors.blue,
      this.backgroundColorValue = Colors.blue,
      this.shadowValue = const Shadow(color: Colors.blue, blurRadius: 2.0)})
      : super(key: key);
  final RichTrexController controller;

  final bool bold;
  final bool italic;
  final bool underline;
  final bool strikethrough;
  final bool overline;
  final bool fontColor;
  final bool backgroundColor;
  final bool shadow;
  final bool fontSize;
  final bool fontHeight;
  final bool fontFamily;
  final bool fontSpace;
  final bool viewSource;

  final Color fontColorValue;
  final Color backgroundColorValue;
  final Shadow shadowValue;

  @override
  State<RichTrexToolbar> createState() => _RichTrexToolbarState();
}

class _RichTrexToolbarState extends State<RichTrexToolbar> {
  /// asasd
  static Widget _button(
          {required Widget icon,
          required String message,
          required void Function() onTap,
          Size? size}) =>
      Tooltip(
          preferBelow: false,
          message: message,
          child: Material(
              child: InkWell(
                  onTap: onTap,
                  child: SizedBox(
                    width: size?.width ?? 45.0,
                    height: size?.height ?? 45.0,
                    child: icon,
                  ))));
  Widget get bold => widget.bold
      ? _button(
          icon: const Icon(Icons.format_bold, size: 20.0),
          message: "Bold",
          onTap: () => widget.controller.onTap(command: RichTrexCommand.bold()),
        )
      : const SizedBox();

  Widget get italic => widget.italic
      ? _button(
          icon: const Icon(Icons.format_italic, size: 20.0),
          message: "Italic",
          onTap: () =>
              widget.controller.onTap(command: RichTrexCommand.italic()),
        )
      : const SizedBox();

  Widget get underline => widget.underline
      ? _button(
          icon: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "U",
                style: TextStyle(
                    height: 0.75, fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              Container(
                height: 2,
                width: 15.0,
                color: Colors.black,
              )
            ],
          ),
          message: "Underline",
          onTap: () =>
              widget.controller.onTap(command: RichTrexCommand.underline()),
        )
      : const SizedBox();

  Widget get strikethrough => widget.strikethrough
      ? _button(
          icon: const Icon(Icons.strikethrough_s, size: 20.0),
          message: "Strikethrough",
          onTap: () =>
              widget.controller.onTap(command: RichTrexCommand.strikeThrough()),
        )
      : const SizedBox();

  Widget get overline => widget.overline
      ? _button(
          icon: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 2,
                width: 12.5,
                color: Colors.black,
              ),
              const Text(
                "o",
                style: TextStyle(
                    height: 0.9, fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
          message: "Overline",
          onTap: () =>
              widget.controller.onTap(command: RichTrexCommand.overline()),
        )
      : const SizedBox();

  Widget get fontColor => widget.fontColor
      ? _button(
          size: const Size(50.0, 45.0),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "A",
                    style: TextStyle(
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Container(
                    height: 3.5,
                    width: 17.0,
                    color: Colors.red,
                  )
                ],
              ),
              InkWell(
                  onTap: () => const RichTrexColorPicker().open(context),
                  child: const Icon(Icons.arrow_drop_down_sharp))
            ],
          ),
          message: "Font Color",
          onTap: () => widget.controller
              .onTap(command: RichTrexCommand.fontColor(value: Colors.red)),
        )
      : const SizedBox();

  Widget get backgroundColor => widget.backgroundColor
      ? _button(
          size: const Size(50.0, 45.0),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.format_color_fill,
                    size: 20.0,
                  ),
                  SizedBox(
                    height: 20,
                    width: 20.0,
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                            width: 17.0, height: 3.5, color: Colors.red)),
                  )
                ],
              ),
              InkWell(
                  onTap: () {}, child: const Icon(Icons.arrow_drop_down_sharp))
            ],
          ),
          message: "Background Color",
          onTap: () => widget.controller.onTap(
              command: RichTrexCommand.backgroundColor(value: Colors.red)),
        )
      : const SizedBox();

  Widget get shadow => widget.shadow
      ? _button(
          size: const Size(50.0, 45.0),
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "A",
                    style: TextStyle(
                        shadows: [
                          Shadow(color: Colors.black, offset: Offset(3.0, 0)),
                          Shadow(color: Colors.white, offset: Offset(1.5, 0)),
                        ],
                        height: 1.0,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                  Container(
                    height: 3.5,
                    width: 17.0,
                    color: Colors.red,
                  )
                ],
              ),
              InkWell(
                  onTap: () {}, child: const Icon(Icons.arrow_drop_down_sharp))
            ],
          ),
          message: "Shadow",
          onTap: () => widget.controller.onTap(
              command: RichTrexCommand.shadow(
                  value: const Shadow(color: Colors.red, blurRadius: 2.0))),
        )
      : const SizedBox();

  Widget get fontSize => widget.fontSize
      ? _button(
          icon: const Icon(Icons.format_size, size: 20.0),
          message: "Font Size",
          onTap: () => widget.controller
              .onTap(command: RichTrexCommand.fontSize(value: 30.0)),
        )
      : const SizedBox();

  Widget get fontHeight => widget.fontHeight
      ? _button(
          icon: const Icon(Icons.text_rotate_vertical, size: 20.0),
          message: "Font Height",
          onTap: () => widget.controller
              .onTap(command: RichTrexCommand.fontHeight(value: 10.0)),
        )
      : const SizedBox();

  Widget get fontFamily => widget.fontFamily
      ? _button(
          icon: const Icon(Icons.font_download_sharp, size: 20.0),
          message: "Font Family",
          onTap: () => widget.controller.onTap(
              command: RichTrexCommand.fontFamily(value: "Times New Roman")),
        )
      : const SizedBox();

  Widget get fontSpace => widget.fontSpace
      ? _button(
          icon: const Icon(Icons.text_rotation_none_sharp, size: 20.0),
          message: "Font Space",
          onTap: () => widget.controller
              .onTap(command: RichTrexCommand.fontSpace(value: 10.0)),
        )
      : const SizedBox();

  Widget get viewSource => widget.viewSource
      ? _button(
          icon: Icon(widget.controller.viewSource ? Icons.code_off : Icons.code,
              size: 20.0),
          message: "View Source",
          onTap: () => widget.controller
              .onTap(command: RichTrexCommand.viewSource(value: true)),
        )
      : const SizedBox();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() => setState(() => widget.controller));
  }

  @override
  Widget build(BuildContext context) {
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
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 25)]),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            bold,
            italic,
            underline,
            strikethrough,
            overline,
            divider,
            fontColor,
            backgroundColor,
            shadow,
            divider,
            fontSize,
            fontFamily,
            fontHeight,
            fontSpace,
            divider,
            viewSource
          ],
        ),
      ),
    );
  }
}
