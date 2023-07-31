import 'dart:math' show pi;
import 'package:flutter/material.dart';

enum CircleSide {left, right}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    var path = Path();

    late Offset offset;
    late bool clockwise; // по часовой стрелке

    switch (this) {

      case CircleSide.left:
        path.moveTo(size.width, 0.0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        path.moveTo(0.0, 0.0);
        offset = Offset(0.0, size.height);
        clockwise = true;
        break;
    }
    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.height / 2),
      clockwise: clockwise,
    );
    path.close();

    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {

  final CircleSide side;
  HalfCircleClipper({required this.side});

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}


class ChainedScreen extends StatefulWidget {
  const ChainedScreen({Key? key}) : super(key: key);
  static const String id = 'chained_screen';

  @override
  State<ChainedScreen> createState() => _ChainedScreenState();
}

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class _ChainedScreenState extends State<ChainedScreen> with TickerProviderStateMixin {

  late AnimationController _clockwiseAnimationController;
  late Animation<double> _clockwiseAnimation;

  late AnimationController _flipAnimationController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    _clockwiseAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _clockwiseAnimation = Tween<double>(begin: 0.0, end: -(pi / 2)).animate(
      CurvedAnimation(
        parent: _clockwiseAnimationController,
        curve: Curves.bounceOut,
      ),
    );

    _flipAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _flipAnimation = Tween<double>(begin: 0.0, end: pi).animate(
      CurvedAnimation(parent: _flipAnimationController, curve: Curves.bounceOut),
    );

    _clockwiseAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _flipAnimation = Tween<double>(begin: _flipAnimation.value, end: _flipAnimation.value + pi).animate(
          CurvedAnimation(parent: _flipAnimationController, curve: Curves.bounceOut),
        );
        _flipAnimationController..reset()..forward();
      }
    });

    _flipAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _clockwiseAnimation = Tween<double>(
          begin: _clockwiseAnimation.value,
          end: _clockwiseAnimation.value + -(pi / 2),
        ).animate(
          CurvedAnimation(
            parent: _clockwiseAnimationController,
            curve: Curves.bounceOut,
          ),
        );
        _clockwiseAnimationController..reset()..forward();
      }
    });
  }

  @override
  void dispose() {
    _clockwiseAnimationController.dispose();
    _flipAnimationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    _clockwiseAnimationController..reset()..forward.delayed(Duration(milliseconds: 1000));

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _clockwiseAnimationController,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()..rotateZ(_clockwiseAnimation.value),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: HalfCircleClipper(side: CircleSide.left),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            color: Color(0xFF1D7874),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipAnimationController,
                    builder: (BuildContext context, Widget? child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: HalfCircleClipper(side: CircleSide.right),
                          child: Container(
                            width: 100.0,
                            height: 100.0,
                            color: Color(0xFFD4AF37),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
