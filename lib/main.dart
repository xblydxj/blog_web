import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:web/config/constants.dart';
import 'package:web/config/model_binding.dart';
import 'package:web/pages/main_page.dart';
import 'package:web/provider/article_provider.dart';
import 'package:web/route.dart';

import 'config/error_report.dart';
import 'config/options.dart';
import 'config/theme_data.dart';
import 'pages/base_page.dart';

void main() {
  // runZonedGuarded<Future<Null>>(() async {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ArticleProvider())
      ],
      child: BlogApp(),
    ));
  // }, (error, stackTrace) async {
  //   await _reportError(error, stackTrace);
  // });
  //
  // FlutterError.onError = (FlutterErrorDetails details) {
  //   if (isTest) FlutterError.dumpErrorToConsole(details);
  //   Zone.current.handleUncaughtError(details.exception, details.stack);
  // };
}

_reportError(Object error, StackTrace stackTrace) {
  print('error:$error,\nstackTrace:$stackTrace');
  // ReportError.decorate(error, stackTrace.toString()).report();
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
            title: 'Sibre',
            debugShowCheckedModeBanner: false,
            themeMode: Options.of(context).themeMode,
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
  RootPage({
    Key key,
  }) : super(key: key) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(key: key, child: MainPage());
  }
}
