import 'dart:math' as math;
import 'package:flutter/material.dart';

class BackgroundGradient extends StatelessWidget {
  const BackgroundGradient({Key? key, this.white = false}) : super(key: key);

  final bool white;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(),
        Positioned(
          right: 100,
          child: GradientRect(white: white),
        ),
        Positioned(
          top: 150,
          right: 100,
          child: GradientRect(white: white),
        ),
        Positioned(
          bottom: 0,
          left: -50,
          child: GradientRectReversed(white: white),
        ),
        Positioned(
          bottom: -150,
          left: -50,
          child: GradientRectReversed(white: white),
        ),
      ],
    );
  }
}

class GradientRect extends StatelessWidget {
  const GradientRect({Key? key, required this.white}) : super(key: key);

  final bool white;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationZ(
        -math.pi / 4,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 49.37,
        height: 254.32,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          const Color(0xffffffff).withOpacity(0),
          (white ? const Color(0xffffffff) : Theme.of(context).focusColor)
              .withOpacity(0.1)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ),
    );
  }
}

class GradientRectReversed extends StatelessWidget {
  const GradientRectReversed({Key? key, required this.white}) : super(key: key);
  final bool white;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.rotationZ(
        -math.pi / 4,
      ),
      child: Container(
        clipBehavior: Clip.hardEdge,
        width: 49.37,
        height: 254.32,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          (white ? const Color(0xffffffff) : Theme.of(context).focusColor)
              .withOpacity(0.1),
          const Color(0xffffffff).withOpacity(0),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      ),
    );
  }
}
