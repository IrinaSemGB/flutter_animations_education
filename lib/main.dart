import 'package:flutter/material.dart';
import 'package:flutter_animations_education/chained_screen.dart';
import 'package:flutter_animations_education/transform_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      initialRoute: ChainedScreen.id,
      routes: {
        TransformScreen.id: (context) => TransformScreen(),
        ChainedScreen.id: (context) => ChainedScreen(),
      },
    );
  }
}
