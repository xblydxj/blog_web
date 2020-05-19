import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientSingleColorBackground extends StatefulWidget {
  @override
  _GradientSingleColorBackgroundState createState() =>
      _GradientSingleColorBackgroundState();
}

class _GradientSingleColorBackgroundState
    extends State<GradientSingleColorBackground>
    with SingleTickerProviderStateMixin {
  Animation _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 10), vsync: this)
          ..repeat(reverse: true, period: Duration(seconds: 10))
          ..addListener(() {
            setState(() {});
          })
          ..addStatusListener((status) {
            print(status);
            switch (status) {
              case AnimationStatus.completed:
                _controller.reverse();
                break;
              case AnimationStatus.reverse:
                break;
              case AnimationStatus.forward:
                break;
              case AnimationStatus.dismissed:
                _controller.forward();
                break;
              default:
                break;
            }
          });
    _animation = ColorTween(
            begin: Colors.teal.withOpacity(0.7),
            end: Colors.pinkAccent.withOpacity(0.7))
        .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(color: _animation.value,);
  }
}
