import 'package:flutter/material.dart';
import 'package:richtrex/richtrex.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RichTrexController controller = RichTrexController(text: "simple");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: RichTrex(controller: controller)),
    );
  }
}
