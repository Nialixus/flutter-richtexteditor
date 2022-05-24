import 'package:flutter/material.dart';
import 'package:richtrex/richtrex.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RichTrexController controller =
      RichTrexController(text: "lorem ipsum dolor sit amet");

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("RichTrex"), elevation: 0.0),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: RichTrex.editor(controller: controller)),
            RichTrex.toolbar(controller: controller)
          ],
        ),
      ),
    );
  }
}
