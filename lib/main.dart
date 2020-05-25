import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:web/config/constants.dart';
import 'package:web/config/model_binding.dart';
import 'package:web/pages/main_page.dart';
import 'package:web/route.dart';

import 'config/options.dart';
import 'config/theme_data.dart';
import 'pages/base_page.dart';

void main() {
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  const BlogApp({
    Key key,
    this.initialRoute,
    this.isTestMode = true,
  }) : super(key: key);

  final bool isTestMode;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return ModelBinding(
      initialModel: Options(
        themeMode: ThemeMode.system,
        textScaleFactor: systemTextScaleFactorOption,
        timeDilation: timeDilation,
        isTestMode: isTestMode,
      ),
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Xblydxj\'Blog',
            debugShowCheckedModeBanner: false,
            themeMode: Options.of(context)
                .themeMode,
            theme: CThemeData.lightThemeData,
            darkTheme: CThemeData.darkThemeData,
            initialRoute: initialRoute,
            onGenerateRoute: RouteConfiguration.onGenerateRoute,
          );
        },
      ),
    );
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BasePage(key: key, child: MainPage());
  }
}
