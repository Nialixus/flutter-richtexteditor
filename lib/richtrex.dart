library richtrex;

import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'src/richtrex_toolbar.dart';
import 'src/richtrex_editor.dart';

part 'src/richtrex_controller.dart';
part 'src/richtrex_selection.dart';
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

  static TextSpan decode(RichTrexController controller, String string) =>
      RichTrexFormat._decode(string, formats: controller.formats);
}

extension RichTrexWidgetSpan on WidgetSpan {
  WidgetSpan copyWith(
          {Widget? child,
          PlaceholderAlignment? alignment,
          TextBaseline? baseline,
          TextStyle? style}) =>
      WidgetSpan(
          child: child ?? this.child,
          alignment: alignment ?? this.alignment,
          baseline: baseline ?? this.baseline,
          style: style ?? this.style);
}

extension RichTrexTextSpan on TextSpan {
  TextSpan copyWith(
          {List<InlineSpan>? children,
          Locale? locale,
          MouseCursor? mouseCursor,
          void Function(PointerEnterEvent)? onEnter,
          void Function(PointerExitEvent)? onExit,
          GestureRecognizer? recognizer,
          String? semanticsLabel,
          bool? spellOut,
          String? text,
          TextStyle? style}) =>
      TextSpan(
          children: children ?? this.children,
          locale: locale ?? this.locale,
          mouseCursor: mouseCursor ?? this.mouseCursor,
          onEnter: onEnter ?? this.onEnter,
          onExit: onExit ?? this.onExit,
          recognizer: recognizer ?? this.recognizer,
          semanticsLabel: semanticsLabel ?? this.semanticsLabel,
          spellOut: spellOut ?? this.spellOut,
          text: text ?? this.text,
          style: style ?? this.style);

  TextSpan merge(TextSpan? other) => copyWith(
      children: other?.children ?? children,
      locale: other?.locale ?? locale,
      mouseCursor: other?.mouseCursor ?? mouseCursor,
      onEnter: other?.onEnter ?? onEnter,
      onExit: other?.onExit ?? onExit,
      recognizer: other?.recognizer ?? recognizer,
      semanticsLabel: other?.semanticsLabel ?? semanticsLabel,
      spellOut: other?.spellOut ?? spellOut,
      text: other?.text ?? text,
      style: other?.style ?? style);
}
