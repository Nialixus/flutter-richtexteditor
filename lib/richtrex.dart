library richtrex;

import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';

import 'src/extension.dart';
import 'src/format.dart';
import 'src/richtrex_editor.dart';

export 'richtrex.dart' show RichTrexToolbar, RichTrexController;

part 'src/richtrex_controller.dart';
part 'src/richtrex_notifier.dart';
part 'src/richtrex_toolbar.dart';

class RichTrex {
  static RichTrexController controller({String? text}) =>
      RichTrexController(text: text);

  static Widget editor({required RichTrexController controller}) =>
      RichTrexEditor(controller: controller);

  static Widget toolbar({required RichTrexController controller}) => Row(
        children: [
          for (int x = 0; x < 4; x++)
            IconButton(
              onPressed: () {},
              icon: Icon([
                Icons.format_bold,
                Icons.format_italic,
                Icons.format_underline,
                Icons.format_strikethrough
              ][x]),
            )
        ],
      );
}
