import 'package:flutter/material.dart';
import 'package:richexpression/richtrex.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RichTrexController controller = RichTrex.controller(
      text:
          """Lorem<style="font-color:0xff000fff;font-weight:6;"> ipsum do</style>lor s<style="font-weight:6;font-color:0xffff0000;">it am</style>et""");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
          Expanded(child: RichTrex.editor(controller: controller)),
          RichTrex.toolbar(controller: controller)
        ])));
  }
}
