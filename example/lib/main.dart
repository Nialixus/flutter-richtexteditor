import 'package:flutter/material.dart';
import 'package:flutter_richtexteditor/flutter_richtexteditor.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RichTextController controller = RichTextController(
      text:
          """<Lorem<style="font-color:0xff000456;font-weight:6;"> ipsum do</style>lor s<style="font-weight:6;font-color:0xffbbb456;">it am</style>et""");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          Expanded(
            child: RichTextEditor(controller: controller),
          ),
          RichTextToolbar(controller: controller)
        ])));
  }
}
