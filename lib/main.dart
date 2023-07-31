import 'package:flutter/material.dart';
import 'package:flutter_animations_education/screens/chained_screen.dart';
import 'package:flutter_animations_education/screens/effect_3d_screen.dart';
import 'package:flutter_animations_education/screens/transform_screen.dart';

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
      initialRoute: Effect3DScreen.id,
      routes: {
        TransformScreen.id: (context) => TransformScreen(),
        ChainedScreen.id: (context) => ChainedScreen(),
        Effect3DScreen.id: (context) => Effect3DScreen(),
      },
    );
  }
}
