import 'package:flutter/material.dart';
import '/values/app_color.dart';

class RPSCustomPainterTop extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path0 = Path();

    canvas.drawPath(path0, paint0);

    Paint paint1 = Paint()
      ..color = AppColor.colorYellow
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path1 = Path();
    path1.moveTo(size.width * -0.0651944, size.height * -0.1726667);
    path1.cubicTo(
        size.width * 0.0979167,
        size.height * -0.1726667,
        size.width * 0.3340000,
        size.height * -0.1056167,
        size.width * 0.3340000,
        size.height * 0.0668333);
    path1.cubicTo(
        size.width * 0.3340000,
        size.height * 0.1626167,
        size.width * 0.2142222,
        size.height * 0.3063500,
        size.width * -0.0651944,
        size.height * 0.3063500);
    path1.cubicTo(
        size.width * -0.2248333,
        size.height * 0.3063500,
        size.width * -0.4643611,
        size.height * 0.2344833,
        size.width * -0.4643611,
        size.height * 0.0668333);
    path1.cubicTo(
        size.width * -0.4643611,
        size.height * -0.0289500,
        size.width * -0.3409722,
        size.height * -0.1726667,
        size.width * -0.0651944,
        size.height * -0.1726667);
    path1.close();

    canvas.drawPath(path1, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
