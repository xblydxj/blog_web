import 'dart:math';

import 'package:flutter/material.dart';

class WhaleLogo extends StatefulWidget {
  double minRadius = 10;
  Size size;

  WhaleLogo(Key key, {this.minRadius, this.size}) : super(key: key) {
    if (size != null) minRadius = size.width / 20;
  }

  @override
  WhaleLogoState createState() => WhaleLogoState();
}

class WhaleLogoState extends State<WhaleLogo> with TickerProviderStateMixin {
  AnimationController _controller1;
  AnimationController _controller2;
  AnimationController _controller3;
  AnimationController _controller4;

  double bubble1Radius = 3;
  double bubble2Radius = 2;
  double bubble3Radius = 5;
  double bubble4Radius = 4;

  @override
  void initState() {
    _controller1 = buildAnimation(duration: 3);
    _controller2 = buildAnimation(duration: 6);
    _controller3 = buildAnimation(duration: 5);
    _controller4 = buildAnimation(duration: 4);
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CustomPaint(painter: Whale(minRadius: widget.minRadius)),
        CustomPaint(
            painter: Bubble(_controller1, 15.0 * widget.minRadius,
                4.0 * widget.minRadius, bubble1Radius)),
        CustomPaint(
            painter: Bubble(_controller2, 15.5 * widget.minRadius,
                4.3 * widget.minRadius, bubble2Radius)),
        CustomPaint(
            painter: Bubble(_controller3, 16.0 * widget.minRadius,
                4.7 * widget.minRadius, bubble3Radius)),
        CustomPaint(
            painter: Bubble(_controller4, 15.5 * widget.minRadius,
                4.5 * widget.minRadius, bubble4Radius)),
      ],
    );
  }

  AnimationController buildAnimation({int duration}) {
    return AnimationController(
        vsync: this, duration: Duration(seconds: duration))
      ..repeat()
      ..addListener(() => setState(() {
            if (_controller1.value >= 0.99)
              bubble1Radius = (widget.minRadius / 5 +
                      Random().nextInt(widget.minRadius ~/ 3))
                  .toDouble();
            if (_controller2.value >= 0.99)
              bubble2Radius = (widget.minRadius / 5 +
                      Random().nextInt(widget.minRadius ~/ 3))
                  .toDouble();
            if (_controller3.value >= 0.99)
              bubble3Radius = (widget.minRadius / 5 +
                      Random().nextInt(widget.minRadius ~/ 3))
                  .toDouble();
            if (_controller4.value >= 0.99)
              bubble4Radius = (widget.minRadius / 5 +
                      Random().nextInt(widget.minRadius ~/ 3))
                  .toDouble();
          }));
  }
}

class Bubble extends CustomPainter {
  AnimationController _controller;
  Animation<double> _anim;
  double originX;
  double originY;
  double radius = 3;
  Paint _paint;

  Bubble(this._controller, this.originX, this.originY, this.radius) {
    _anim = Tween(begin: 0.0, end: 8.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));
    var opacity = 0.0;
    if (_anim.value >= 0.0 && _anim.value < 1.0)
      opacity = _anim.value;
    else if (_anim.value >= 1.0) opacity = (8 - _anim.value) / 8;
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.indigo.withOpacity(opacity);
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawCircle(Offset(originX + radius, originY - radius * _anim.value),
        radius, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class Whale extends CustomPainter {
  Whale({this.minRadius}) {
    _buildCircle();
    _buildCoordinate();
    mainPaint = Paint()
      ..color = Colors.indigo
      ..isAntiAlias = true
      ..style = PaintingStyle.fill;
  }

  //黄金分割的圆形，最小半径作为参数 默认20
  double minRadius = 25.0;

  Path tail1;
  Path tail2;
  Path tail3;
  Path body1;
  Path body2;
  Path body3;
  Path body4;
  Path body5;
  Path body6;
  Path body7;
  Path body8;
  Path body9;
  Path body10;

  Offset bodyCoordinate1;
  Offset bodyCoordinate2;
  Offset bodyCoordinate3;
  Offset bodyCoordinate4;
  Offset bodyCoordinate5;
  Offset bodyCoordinate6;
  Offset bodyCoordinate7;

  Paint mainPaint;

  @override
  void paint(Canvas canvas, Size size) {
    _tail(canvas);
    _body(canvas);
  }

  _body(Canvas canvas) {
    mainPaint.shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo, Colors.blue])
        .createShader(Offset(minRadius * 2, minRadius * 3) &
            Size(minRadius * 14, minRadius * 7));

    Path body = Path()
      ..moveTo(3.6 * minRadius, 6.1 * minRadius)
      ..arcToPoint(bodyCoordinate2, radius: Radius.circular(2 * minRadius))
      ..arcToPoint(bodyCoordinate3, radius: Radius.circular(3 * minRadius))
      ..arcToPoint(bodyCoordinate4,
          radius: Radius.circular(5 * minRadius), clockwise: false)
      ..arcToPoint(bodyCoordinate5,
          radius: Radius.circular(1.3 * minRadius), clockwise: false)
      ..arcToPoint(bodyCoordinate1,
          radius: Radius.circular(8 * minRadius), clockwise: false);
    canvas.drawPath(body, mainPaint);

    mainPaint.shader = LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.indigo, Colors.blue])
        .createShader(Offset(14.9 * minRadius, 4.7 * minRadius) &
            Size(minRadius * 3.1, minRadius * 6));

    Path head = Path()
      ..moveTo(14.9 * minRadius, 4.7 * minRadius)
      ..arcToPoint(bodyCoordinate5, radius: Radius.circular(8 * minRadius))
      ..arcToPoint(bodyCoordinate4, radius: Radius.circular(1.3 * minRadius))
      ..arcToPoint(Offset(15.2 * minRadius, 9 * minRadius),
          radius: Radius.circular(3 * minRadius), clockwise: false)
      ..arcToPoint(Offset(14.9 * minRadius, 4.7 * minRadius),
          radius: Radius.circular(3 * minRadius), clockwise: false);
    canvas.drawPath(head, mainPaint);

    mainPaint.shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.indigo, Colors.blue])
        .createShader(Offset(10.1 * minRadius, 7.7 * minRadius) &
            Size(minRadius * 5, minRadius * 4.2));

    Path abdomen = Path()
      ..moveTo(15.2 * minRadius, 9 * minRadius)
      ..arcToPoint(Offset(10.1 * minRadius, 7.7 * minRadius),
          radius: Radius.circular(3 * minRadius))
      ..arcToPoint(bodyCoordinate4,
          radius: Radius.circular(5 * minRadius), clockwise: false)
      ..arcToPoint(Offset(15.2 * minRadius, 9 * minRadius),
          radius: Radius.circular(3 * minRadius), clockwise: false);
    canvas.drawPath(abdomen, mainPaint);

//    Path fins1 = Path()
//      ..moveTo(9.8 * minRadius, 6.6 * minRadius)
//      ..arcToPoint(Offset(7.6 * minRadius, 8.4 * minRadius),
//          radius: Radius.circular(2 * minRadius))
//      ..arcToPoint(Offset(10.4 * minRadius, 8.5 * minRadius),
//          radius: Radius.circular(2 * minRadius), clockwise: false)
//      ..arcToPoint(Offset(9.8 * minRadius, 6.6 * minRadius),
//          radius: Radius.circular(3 * minRadius), clockwise: false);
//    canvas.drawPath(fins1, mainPaint);

//    Path fins2 = Path()
//      ..moveTo(11.6 * minRadius, 10.2 * minRadius)
//      ..arcToPoint(Offset(9.2 * minRadius, 10.8 * minRadius),
//          radius: Radius.circular(2 * minRadius))
//      ..arcToPoint(Offset(12.8 * minRadius, 11 * minRadius),
//          radius: Radius.circular(2 * minRadius), clockwise: false)
//      ..arcToPoint(Offset(11.6 * minRadius, 10.2 * minRadius),
//          radius: Radius.circular(5 * minRadius), clockwise: false);
//    canvas.drawPath(fins2, mainPaint);
  }

  _buildCircle() {
    body1 = Path()
      ..addOval(Rect.fromCircle(center: Offset(10 * minRadius, 11 * minRadius), radius: minRadius * 8));
    body2 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(15 * minRadius, 6.5 * minRadius),
          radius: minRadius * 5));
    body3 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(7.1 * minRadius, 8 * minRadius),
          radius: minRadius * 3));
    body4 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(7 * minRadius, 5.5 * minRadius),
          radius: minRadius * 3));
    body5 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(13 * minRadius, 7 * minRadius),
          radius: minRadius * 3));
    body6 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(12 * minRadius, 15 * minRadius),
          radius: minRadius * 3));
    body7 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(11 * minRadius, 10 * minRadius),
          radius: minRadius * 2));
    body8 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(10 * minRadius, 9 * minRadius),
          radius: minRadius * 2));
    body9 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(9 * minRadius, 7 * minRadius), radius: minRadius * 2));
    body10 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(10 * minRadius, 4.4 * minRadius),
          radius: minRadius * 3));
    tail1 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(minRadius * 2, minRadius * 6), radius: minRadius * 2));
    //30,80
    tail2 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(minRadius * 3, minRadius * 8), radius: minRadius * 2));
    //50,80
    tail3 = Path()
      ..addOval(Rect.fromCircle(
          center: Offset(minRadius * 5, minRadius * 8), radius: minRadius * 2));
  }

  _tail(Canvas canvas) {
    //20,60
    Path combine1 = Path.combine(PathOperation.intersect, tail1, tail2);
    Path combine2 = Path.combine(PathOperation.intersect, tail3, tail2);
    mainPaint.shader = LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [Colors.indigo, Colors.blue])
        .createShader(
            Offset(0, minRadius * 6) & Size(minRadius * 4, minRadius * 2));
    canvas.drawPath(combine1, mainPaint);
    mainPaint.shader = null;
    canvas.drawPath(combine2, mainPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  _buildCoordinate() {
    bodyCoordinate1 = Offset(3.6 * minRadius, 6.1 * minRadius);
    bodyCoordinate2 = Offset(4.4 * minRadius, 6.6 * minRadius);
    bodyCoordinate3 = Offset(10 * minRadius, 7.2 * minRadius);
    bodyCoordinate4 = Offset(17.4 * minRadius, 10.8 * minRadius);
    bodyCoordinate5 = Offset(17.9 * minRadius, 9.8 * minRadius);

    bodyCoordinate6 = Offset(9.77 * minRadius, 6.64 * minRadius);
    bodyCoordinate7 = Offset(9.77 * minRadius, 6.64 * minRadius);
  }
}
