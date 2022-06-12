import 'package:flutter/material.dart';
import 'package:richtrex/richtrex.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RichTrexController controller = RichTrexController(
      text:
          'lorem <style="font-weight:8;">ipsum</style> dolor <style="font-color:0xFFFF1212;">sit</style> amet');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: RichTrex(controller: controller)),
    );
  }
}
