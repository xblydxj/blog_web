import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:web/widgets/background/background.dart';

import 'constants.dart';
import 'model_binding.dart';

class Options {
  const Options(
      {this.themeMode,
      double textScaleFactor,
      this.timeDilation,
      this.isTestMode})
      : _textScaleFactor = textScaleFactor;

  //包含夜间主题日间主题等，之后可能会出大背景颜色修改的类型
  final ThemeMode themeMode;

  //文本缩放因子，自定义或者跟随系统
  final double _textScaleFactor;

  //时间延缓
  final double timeDilation;



  //是否是测试模式
  final bool isTestMode;

  //文本缩放因子
  double textScaleFactor(BuildContext context, {bool useSentinel = false}) {
    if (_textScaleFactor == systemTextScaleFactorOption) {
      return useSentinel
          ? systemTextScaleFactorOption
          : MediaQuery.of(context).textScaleFactor;
    } else
      return _textScaleFactor;
  }

  SystemUiOverlayStyle resolvedSystemUiOverlayStyle() {
    Brightness brightness;
    switch (themeMode) {
      case ThemeMode.light:
        brightness = Brightness.light;
        break;
      case ThemeMode.dark:
        brightness = Brightness.dark;
        break;
      default:
        brightness = WidgetsBinding.instance.window.platformBrightness;
    }

    final overlayStyle = brightness == Brightness.dark
        ? SystemUiOverlayStyle.light
        : SystemUiOverlayStyle.dark;

    return overlayStyle;
  }

  static Options of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ModelBindingScope>();
    return scope.modelBindingState.currentOption;
  }

  static void update(BuildContext context, Options newModel) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ModelBindingScope>();
    scope.modelBindingState.updateModel(newModel);
  }

  Options copyWith(
      {ThemeMode themeMode,
      double textScaleFactor,
      double timeDilation,
      bool isTestMode}) {
    return Options(
      themeMode: themeMode ?? this.themeMode,
      textScaleFactor: textScaleFactor ?? _textScaleFactor,
      timeDilation: timeDilation ?? this.timeDilation,
      isTestMode: isTestMode ?? this.isTestMode,
    );
  }
}
