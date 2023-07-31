import 'dart:math' show pi;
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;
import '../constants/app_color.dart';

class Effect3DScreen extends StatefulWidget {
  const Effect3DScreen({Key? key}) : super(key: key);
  static const String id = 'effect_3D_screen';

  @override
  State<Effect3DScreen> createState() => _Effect3DScreenState();
}

class _Effect3DScreenState extends State<Effect3DScreen> with TickerProviderStateMixin {


  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  final double widthAndHeight = 100.0;

  @override
  void initState() {
    super.initState();

    _xController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );

    _yController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );

    _zController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 40),
    );

    _animation = Tween(begin: 0, end: pi * 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    _xController..reset()..repeat();
    _yController..reset()..repeat();
    _zController..reset()..repeat();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _xController, _yController, _xController,
            ]),
            builder: (BuildContext context, Widget? child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(_animation.evaluate(_xController))
                  ..rotateY(_animation.evaluate(_yController))
                  ..rotateZ(_animation.evaluate(_zController)),
                child: Stack(
                  children: [
                    // back
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..translate(Vector3(0, 0, -widthAndHeight)),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: AppColors.violet,
                      ),
                    ),

                    // left
                    Transform(
                      alignment: Alignment.centerLeft,
                      transform: Matrix4.identity()..rotateY(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: AppColors.pink,
                      ),
                    ),

                    // right
                    Transform(
                      alignment: Alignment.centerRight,
                      transform: Matrix4.identity()..rotateY(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: AppColors.blue,
                      ),
                    ),

                    // front
                    Container(
                      width: widthAndHeight,
                      height: widthAndHeight,
                      color: AppColors.green,
                    ),

                    // top
                    Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.identity()..rotateX(-pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: AppColors.orange,
                      ),
                    ),

                    // bottom
                    Transform(
                      alignment: Alignment.bottomCenter,
                      transform: Matrix4.identity()..rotateX(pi / 2),
                      child: Container(
                        width: widthAndHeight,
                        height: widthAndHeight,
                        color: AppColors.yellow,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
