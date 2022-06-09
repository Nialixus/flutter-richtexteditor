library richtrex;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:richtrex/src/richtrex_extension.dart';

import 'src/richtrex_toolbar.dart';
import 'src/richtrex_editor.dart';

part 'src/richtrex_controller.dart';
part 'src/richtrex_selection.dart';
part 'src/richtrex_history.dart';
part 'src/richtrex_format.dart';

class RichTrex extends StatelessWidget {
  const RichTrex({Key? key, this.controller})
      : _id = 0,
        super(key: key);
  const RichTrex.editor({Key? key, required this.controller})
      : _id = 1,
        assert(controller != null),
        super(key: key);
  const RichTrex.toolbar({Key? key, required this.controller})
      : _id = 2,
        assert(controller != null),
        super(key: key);

  final int _id;
  final RichTrexController? controller;

  @override
  Widget build(BuildContext context) {
    if (_id == 0) {
      RichTrexController defaultController = controller ?? RichTrexController();
      return Column(children: [
        Expanded(child: RichTrexEditor(controller: defaultController)),
        RichTrexToolbar(controller: defaultController)
      ]);
    }
    return [
      RichTrexEditor(controller: controller!),
      RichTrexToolbar(controller: controller!)
    ][_id - 1];
  }

  static TextSpan decode(String string) => RichTrexFormat._decode(string);
}
