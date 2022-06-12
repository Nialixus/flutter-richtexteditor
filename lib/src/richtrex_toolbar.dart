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
    return Row(
      children: [
        for (int x = 0; x < 3; x++)
          MaterialButton(
            onPressed: () {
              widget.controller.onTap(
                  format: [
                RichTrexCommand.color(value: Colors.red),
                RichTrexCommand.bold(value: FontWeight.w900),
                RichTrexCommand.viewsource(value: widget.controller.viewSource),
              ][x]);
            },
            child: Icon(
              [
                Icons.color_lens,
                Icons.format_bold,
                widget.controller.viewSource ? Icons.code_off : Icons.code
              ][x],
            ),
          ),
      ],
    );
  }
}
