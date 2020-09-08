import 'package:flutter/material.dart';

class ArticleProvider with ChangeNotifier {
  Map<String,bool> series = {
    "生活": true,
    "学习": true,
    "进阶": true,
    "基础": true,
    "探索": true,
    "灵感": true,
    "收集": true,
  };

  Map<String,bool> tags = {
    "android": true,
    "java": true,
    "flutter": true,
    "dart": true,
    "basic": true,
    "music": true,
    "video": true,
    "python": true,
    "cook": true,
    "travel": true,
    "game": true
  };

}

class Series {}
