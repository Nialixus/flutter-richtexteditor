library flutter_richtexteditor;

import "package:flutter/material.dart";

import 'package:flutter_richtexteditor/src/splitter.dart';

class RichTextController extends ChangeNotifier {
  RichTextController({required this.text});
  String text;
  TextSelection textSelection = const TextSelection.collapsed(offset: 0);

  void updateText(String newText) {
    text = newText;
    notifyListeners();
  }

  void updateTextSelection(TextSelection newTextSelection) {
    textSelection = newTextSelection;
    notifyListeners();
  }
}

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key, required this.controller}) : super(key: key);
  final RichTextController controller;

  @override
  RichTextState createState() => RichTextState();
}

class RichTextState extends State<RichTextEditor> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        widget.controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: SelectableText.rich(
          widget.controller.text.span,
          cursorColor: Colors.red,
          onSelectionChanged: (selection, cause) =>
              print("selection : $selection, cause : $cause"),
        ));
  }
}

class RichTextToolbar extends StatelessWidget {
  const RichTextToolbar({Key? key, required this.controller}) : super(key: key);
  final RichTextController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        controller.updateText("Colors.blue");
      },
      child: const Icon(
        Icons.format_bold,
        color: Colors.blue,
      ),
    );
  }
}
