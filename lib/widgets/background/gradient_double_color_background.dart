import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class GradientDoubleColorBackground extends StatefulWidget {
  @override
  _GradientDoubleColorBackgroundState createState() =>
      _GradientDoubleColorBackgroundState();
}

class _GradientDoubleColorBackgroundState
    extends State<GradientDoubleColorBackground>
    with SingleTickerProviderStateMixin {
  Color pink = Colors.pinkAccent.withOpacity(0.7);
  Color teal = Colors.teal.withOpacity(0.9);
  Color purple = Colors.purple.withOpacity(0.9);
  Color orange = Colors.deepOrange.withOpacity(0.9);

  MultiTween tween;

  @override
  void initState() {
    tween = MultiTween()
      ..add("color1", teal.tweenTo(purple), 6.seconds)
      ..add("color2", pink.tweenTo(orange), 6.seconds);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation(
        tween: tween,
        duration: tween.duration,
        builder: (context, child, value) {
          return Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [value.get("color1"), value.get("color2")],
          )));
        });
  }
}
