library richtrex;

import 'dart:developer';
import 'package:flutter/material.dart';

export 'richtrex.dart'
    hide
        RichTextSelection,
        RichTrexFormat,
        RichTrexToolbar,
        RichTrexEditor,
        RichTrexController;

part 'src/richtrex_controller.dart';
part 'src/richtrex_toolbar.dart';
part 'src/richtrex_format.dart';
part 'src/richtrex_editor.dart';

class RichTrex extends StatelessWidget {
  const RichTrex.editor({Key? key, required this.controller})
      : _id = 0,
        super(key: key);
  const RichTrex.toolbar({Key? key, required this.controller})
      : _id = 1,
        super(key: key);

  final int _id;
  final RichTrexController controller;

  @override
  Widget build(BuildContext context) {
    return [
      RichTrexEditor(controller: controller),
      RichTrexToolbar(controller: controller)
    ][_id];
  }

  static TextSpan decode(String string) => RichTrexFormat._decode(string);
}
