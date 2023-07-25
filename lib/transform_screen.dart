import 'dart:math';
import 'package:flutter/material.dart';

class TransformScreen extends StatefulWidget {
  const TransformScreen({Key? key}) : super(key: key);
  static const String id = 'transform_screen';

  @override
  State<TransformScreen> createState() => _TransformScreenState();
}

class _TransformScreenState extends State<TransformScreen> with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    );
    _animation = Tween<double>(begin: 0.0, end: 2 * pi).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget? child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateY(_animation.value),
              child: Container(
                width: 100.0,
                height: 100.0,
                decoration: BoxDecoration(
                  color: Color(0xFFb57edc),
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 5.0,
                      blurRadius: 7.0,
                      offset: Offset(0.0, 0.3),
                    ),
                  ],
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                  margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 70.0, bottom: 70.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
