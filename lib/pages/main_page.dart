import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String baseRoute = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  final tabs = ['文章', '收集', '时间线', '分类', '我的', '其他'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        vsync: this,
        length: tabs.length
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.purple,
      ),
      backgroundColor: Colors.white,
      body: Row(),
    ),);
  }
}
