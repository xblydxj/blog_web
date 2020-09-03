import 'package:flutter/material.dart';
import 'package:web/config/constants.dart';
import 'package:web/widgets/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  final Widget child;
  final bool crossFade;
  final Color baseColor;
  final Color highlightColor;
  final Widget loadingChild;

  LoadingShimmer(
      {this.child,
        this.crossFade,
        this.loadingChild,
        this.baseColor = Colors.white,
        this.highlightColor = mainColor});

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
        firstChild: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: loadingChild ?? child,
        ),
        secondChild: child,
        crossFadeState:
        crossFade ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: Duration(milliseconds: 500));
  }
}
