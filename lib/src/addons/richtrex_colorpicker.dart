import 'dart:ui';

import 'package:flutter/material.dart';

class RichTrexColorPicker extends StatelessWidget {
  const RichTrexColorPicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> colors = [
      Colors.pink,
      Colors.pinkAccent,
      Colors.red,
      Colors.redAccent,
      Colors.deepOrange,
      Colors.deepOrangeAccent,
      Colors.orange,
      Colors.orangeAccent,
      Colors.amber,
      Colors.amberAccent,
      Colors.yellow,
      Colors.yellowAccent,
      Colors.lime,
      Colors.limeAccent,
      Colors.lightGreen,
      Colors.lightGreenAccent,
      Colors.green,
      Colors.greenAccent,
      Colors.teal,
      Colors.tealAccent,
      Colors.cyan,
      Colors.cyanAccent,
      Colors.lightBlue,
      Colors.lightBlueAccent,
      Colors.blue,
      Colors.blueAccent,
      Colors.indigo,
      Colors.indigoAccent,
      Colors.purple,
      Colors.purpleAccent,
      Colors.deepPurple,
      Colors.deepPurpleAccent,
      Colors.blueGrey,
      Colors.brown,
      Colors.grey,
      Colors.black,
      Colors.white,
    ];
    return CustomPaint(
      painter: Baloon(),
      child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
          child: Column(
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Basic Color
                    Scrollbar(
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 30 * 5),
                          child: Wrap(
                            children:
                                List.from(colors.map((color) => DecoratedBox(
                                      position: DecorationPosition.foreground,
                                      decoration: BoxDecoration(
                                          border: color == Colors.white
                                              ? Border.all(
                                                  color: Colors.black26,
                                                  width: 1)
                                              : null),
                                      child: Material(
                                        color: color,
                                        child: InkWell(
                                          onTap: () {},
                                          child: const SizedBox(
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                      ),
                                    ))),
                          ),
                        ),
                      ),
                    ),

                    // Opacity
                    Container(
                      margin: const EdgeInsets.only(left: 15.0),
                      width: 30,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent])),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(width: 3, color: Colors.black))),
                      margin: const EdgeInsets.only(right: 15.0),
                      height: 35,
                      child: const TextField(
                        decoration: InputDecoration(
                            isDense: true, labelText: "#012AAF"),
                      ),
                    )),
                    Container(
                      height: 35,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      color: Colors.black,
                      child: const Text(
                        "DONE",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}

extension ShowColorPicker on RichTrexColorPicker {
  Future open(BuildContext context) => showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      constraints: const BoxConstraints(
          maxWidth: (30 * 6) + (15 * 3), maxHeight: (30 * 6) + (15 * 3) + 35),
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (_) => GestureDetector(
          onTap: () => Navigator.pop(_),
          child: Container(
              color: Colors.transparent,
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.only(bottom: 45.0),
              child: this)));
}

class Baloon extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height - 10.0)
      ..lineTo(size.width / 2 + 5, size.height - 10)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(size.width / 2 - 5, size.height - 10)
      ..lineTo(0, size.height - 10)
      ..close();

    Paint paint = Paint()..color = Colors.white;
    Paint shadow = Paint()
      ..color = Colors.black12
      ..imageFilter =
          ImageFilter.blur(sigmaX: 10, sigmaY: 10, tileMode: TileMode.decal);

    canvas.drawPath(path, shadow);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate != this;
}
