import 'dart:ui';

import 'package:flutter/material.dart';
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
  @override
  void initState() {
    widget.controller.addListener(() => setState(() => widget.controller));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraint) {
      const EdgeInsetsGeometry padding = EdgeInsets.symmetric(horizontal: 8.0);

      TextPainter rightBox = TextPainter(
          textDirection: TextDirection.ltr, text: widget.controller.text.span)
        ..layout(maxWidth: constraint.maxWidth, minWidth: constraint.minWidth);

      List<LineMetrics> line = rightBox.computeLineMetrics();

      TextPainter leftBox = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(children: [
            for (int x = 0; x < line.length; x++)
              TextSpan(text: '${line[x].lineNumber + 1}\n')
          ]))
        ..layout(maxWidth: constraint.maxWidth, minWidth: constraint.minWidth);

      print(line);

      return Scrollbar(
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: IntrinsicHeight(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                          color: const Color(0xffF2F1F0),
                          constraints: BoxConstraints(
                              minHeight: constraint.maxHeight,
                              maxWidth: 10,
                              minWidth: 10),
                          padding: padding,
                          child: Column(
                            children: [
                              for (int x = 0; x < line.length; x++)
                                ConstrainedBox(
                                  constraints:
                                      BoxConstraints(minHeight: line[x].height),
                                  child: Text(
                                    '${line[x].lineNumber}',
                                    style: const TextStyle(
                                        height: 1.75,
                                        fontSize: 14,
                                        color: Colors.black54),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          )),
                      Expanded(
                        child: TextField(
                          maxLines: null,
                          controller: widget.controller,
                          style: const TextStyle(height: 1.75, fontSize: 14),
                          textAlignVertical: TextAlignVertical.center,
                          scrollPadding: EdgeInsets.zero,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: padding,
                            border: InputBorder.none,
                          ),
                        ),
                      )
                    ]),
              )));
    });
  }
}
