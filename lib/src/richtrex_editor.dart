import 'package:flutter/material.dart';
import 'package:richtrex/richtrex.dart';

export 'richtrex_editor.dart' hide RichTrexEditor;

class RichTrexEditor extends StatelessWidget {
  const RichTrexEditor({Key? key, required this.controller}) : super(key: key);
  final RichTrexController controller;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: DecoratedBox(
        decoration: BoxDecoration(
            border: Border.all(width: 1, color: const Color(0xffD5D5D5))),
        child: TextField(
          maxLines: null,
          controller: controller,
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
    );
  }
}
