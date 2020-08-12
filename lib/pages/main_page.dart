import 'package:flutter/material.dart';
import 'package:web/config/constants.dart';
import 'package:web/pages/timeline_page.dart';
import 'package:web/widgets/main_navigation_rail.dart';
import 'package:web/widgets/main_tab.dart';

import 'account_page.dart';
import 'article_page.dart';
import 'category_page.dart';
import 'collection_page.dart';
import 'other_page.dart';

class MainPage extends StatefulWidget {
  static const String baseRoute = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int _selectedIndex = 0;

  final tabsMap = {
    '文章': "tab/article.png",
    '收集': "tab/study.png",
    '时间线': "tab/collection.png",
    '分类': "tab/collection.png",
    '我的': "tab/account_selected.png",
    '其他': "tab/other.png",
  };
  final tabs = ['文章', '收集', '阅读', '学习', '其他'];

  final List<Widget> _mainList = [
    ArticlePage(),
    CollectionPage(),
    StudyPage(),
    ReadPage(),
    OtherPage()
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: Container(
        color: Colors.purple,
      ),
      backgroundColor: Colors.transparent,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.transparent,
            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _account(),
                Expanded(child: _buildTabBar()),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              children: _mainList,
              scrollDirection: Axis.vertical,
              reverse: false,
              onPageChanged: (position) {
                setState(() {
                  _selectedIndex = position;
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() => MainNavigationRail(
        trailing: Icon(
          Icons.ac_unit,
          color: Colors.black12,
        ),
        backgroundColor: Colors.transparent,
        unselectedLabelTextStyle: TextStyle(fontSize: 10, color: mainColor),
        selectedLabelTextStyle: TextStyle(fontSize: 10, color: Colors.white),
        destinations: [
          buildDestination("文章", 0, Icons.article_rounded),
          buildDestination("收集", 1, Icons.style_rounded),
          buildDestination("阅读", 2, Icons.menu_book),
          buildDestination("学习", 3, Icons.attach_file),
          buildDestination("其他", 4, Icons.dashboard_rounded),
        ],
        onDestinationSelected: (index) {
          setState(() {
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeInCubic);
          });
        },
        selectedIndex: _selectedIndex,
        labelType: MainNavigationRailLabelType.selected,
      );

  MainNavigationRailDestination buildDestination(
      String text, int railNum, IconData icon) {
    return MainNavigationRailDestination(
      icon: Icon(icon, size: 18, color: mainColor),
      selectedIcon: Icon(icon, size: 18, color: Colors.white),
      label: Padding(
          padding: EdgeInsets.only(top: 5),
          child: Text(text, textAlign: TextAlign.center)),
    );
  }

  Widget _account() {
    return Container(
      width: 100,
      height: 200,
    );
  }
}
