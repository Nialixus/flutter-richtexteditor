part of '/flutter_richtexteditor.dart';

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
    var wicked = SelectableText.rich(
      widget.controller.text.span,
      cursorColor: Colors.red,
      onSelectionChanged: (selection, cause) => setState(() {
        widget.controller.updateTextSelection(selection);
      }),
    );

/*
    print("text : " +
        widget.controller.text +
        '\n' +
        'span : ' +
        widget.controller.text.span.origin);
*/
    return ConstrainedBox(
        constraints: const BoxConstraints.expand(), child: wicked);
  }
}
