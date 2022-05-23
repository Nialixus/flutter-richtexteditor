import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:richtrex/src/widgetsize.dart';
import 'extension.dart';

import '../richtrex.dart';

export 'richtrex_editor.dart' hide RichTrexEditor;

class RichTrexEditor extends StatefulWidget {
  const RichTrexEditor({Key? key, required this.controller}) : super(key: key);
  final RichTrexController controller;

  @override
  State<RichTrexEditor> createState() => _RichTrexEditorState();
}

class _RichTrexEditorState extends State<RichTrexEditor> {
  double dy = 0;
  List<LineMetrics> metrics = [];

  void setMetrics({required TextPainter painter}) {
    print(painter.width);
    setState(() => metrics = painter.computeLineMetrics());
  }

  @override
  void initState() {
    widget.controller.addListener(() => setState(() => widget.controller));
    super.initState();
  }

  ScrollController scroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: kToolbarHeight,
          color: Colors.blue,
          child: Row(
            children: [
              Text(
                'RichTrex',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Icon(Icons.question_mark_rounded)
            ],
          ),
        ),
        Expanded(
          child: Scrollbar(
            child: DecoratedBox(
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Color(0xffD5D5D5))),
              child: TextField(
                maxLines: null,
                scrollController: scroll,
                controller: widget.controller,
                style: const TextStyle(height: 1.75, fontSize: 14),
                textAlignVertical: TextAlignVertical.center,
                textAlign: TextAlign.justify,
                scrollPadding: EdgeInsets.zero,
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
