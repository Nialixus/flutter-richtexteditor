part of '/richtrex.dart';

class RichTrexToolbar extends StatelessWidget {
  const RichTrexToolbar({Key? key, required this.controller}) : super(key: key);
  final RichTrexController controller;

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
