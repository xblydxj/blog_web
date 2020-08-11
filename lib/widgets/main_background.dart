import 'package:flutter/material.dart';

class MainBackground extends CustomPainter {
  double top = 50;
  double radius = 2;

  MainBackground({this.top, this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(radius, 0)
      ..arcToPoint(Offset(0, radius),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, top / 2)
      ..arcToPoint(Offset(top / 3, top - 3),
          radius: Radius.circular(top / 2), clockwise: false)
      ..arcToPoint(Offset(top / 2, top * 5 / 4 - 4),
          radius: Radius.circular(top / 4))
      ..lineTo(top / 2, size.height - radius)
      ..arcToPoint(Offset(top / 2 + radius, size.height),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(size.width - radius, size.height)
      ..arcToPoint(Offset(size.width, size.height - radius),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(size.width, radius)
      ..arcToPoint(Offset(size.width - radius, 0),
          radius: Radius.circular(radius), clockwise: false)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
