import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:richtrex/richtrex.dart';

export 'richtrex_editor.dart' hide RichTrexEditor;

class RichTrexEditor extends StatelessWidget {
  const RichTrexEditor({Key? key, required this.controller}) : super(key: key);
  final RichTrexController controller;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: TextField(
        maxLines: null,
        controller: controller,
        style: const TextStyle(color: Colors.black),
        decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
