

import 'package:flutter/widgets.dart';

class Global{
  static BuildContext globalContext;
  static MediaQueryData media;

  static bool isLogin(){
    return false;
  }

  static Future init(BuildContext context) async{
    media = MediaQuery.of(context);
  }
}