import 'package:flutter/material.dart';
import 'package:flutter_richtexteditor/flutter_richtexteditor.dart';

void main() {
  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final RichTextController controller = RichTextController(
      text:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras gravida convallis ante, ut iaculis nisi placerat id. Mauris vel justo sagittis elit porttitor fermentum. Etiam aliquet nibh augue, a facilisis diam rutrum nec. Cras ut bibendum lectus. In hac habitasse platea dictumst. Curabitur odio odio, consectetur eget erat vitae, consectetur ullamcorper elit. Vivamus ipsum arcu, tempus vitae vehicula sit amet, vulputate non augue. Cras sit amet sapien id urna vestibulum condimentum. Integer bibendum posuere elit, non luctus felis laoreet sed. Suspendisse at eros neque. Nullam vitae justo velit. Vivamus sagittis ut turpis a finibus. Aenean et ex viverra, semper odio ac, ultricies orci.");
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
