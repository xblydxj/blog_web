
import 'package:flutter/cupertino.dart';
import 'package:web/config/constants.dart';

import 'gradient_double_color_background.dart';
import 'gradient_single_color_background.dart';

enum BackgroundModel{
  SingleColorGradient,
  DoubleColorGradient,
  Bubble,
}

class Background extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    switch (currentBackgroundModel) {
      case BackgroundModel.DoubleColorGradient:
        return GradientDoubleColorBackground();
      case BackgroundModel.SingleColorGradient:
        return GradientSingleColorBackground();
      case BackgroundModel.Bubble:
      default:
        return GradientDoubleColorBackground();
    }
  }
}


