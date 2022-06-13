library richtrex;

import 'dart:developer';

import 'package:flutter/material.dart';

import 'src/richtrex_toolbar.dart';
import 'src/richtrex_editor.dart';

part 'src/richtrex_controller.dart';
part 'src/richtrex_selection.dart';
part 'src/richtrex_format.dart';
part 'src/richtrex_command.dart';

class RichTrex extends StatelessWidget {
  const RichTrex({Key? key, this.controller}) : super(key: key);
  final RichTrexController? controller;

  @override
  Widget build(BuildContext context) {
    RichTrexController defaultController = controller ?? RichTrexController();
    return Column(children: [
      Expanded(child: editor(controller: defaultController)),
      toolbar(controller: defaultController)
    ]);
  }

  static StatelessWidget editor({required RichTrexController controller}) =>
      RichTrexEditor(controller: controller);

  static StatefulWidget toolbar({required RichTrexController controller}) =>
      RichTrexToolbar(controller: controller);

  static TextSpan decode(String string) => RichTrexFormat().decode(string);
}
