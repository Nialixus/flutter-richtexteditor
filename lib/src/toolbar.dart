part of '/flutter_richtexteditor.dart';

class RichTextToolbar extends StatelessWidget {
  const RichTextToolbar({Key? key, required this.controller}) : super(key: key);
  final RichTextController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int x = 0; x < 2; x++)
          MaterialButton(
            onPressed: () {
              controller.onTap(
                  format: [
                RichTextFormat.color(value: "0xff345aaa"),
                RichTextFormat.bold()
              ][x]);
            },
            child: Icon(
              [Icons.color_lens, Icons.format_bold][x],
              color: Colors.blue,
            ),
          ),
      ],
    );
  }
}
