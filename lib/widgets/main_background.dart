import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainBackground extends CustomPainter {
  double top = 50;
  double radius = 2;

  MainBackground({this.top, this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = CupertinoColors.white
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
    Path path = Path()
      ..moveTo(radius, 0)
      ..arcToPoint(Offset(0, radius),
          radius: Radius.circular(radius), clockwise: false)
      ..lineTo(0, top)
      ..arcToPoint(Offset(radius, top + radius),
          radius: Radius.circular(radius), clockwise: false)
      ..arcToPoint(Offset(top + radius, top * 2 + radius),
          radius: Radius.circular(top))
      ..lineTo(top + radius, size.height - radius)
      ..arcToPoint(Offset(top + radius + radius, size.height),
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
