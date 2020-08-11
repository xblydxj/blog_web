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
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
        backgroundColor: Colors.transparent,
        unselectedLabelTextStyle: TextStyle(fontSize: 10, color: Colors.grey),
        selectedLabelTextStyle: TextStyle(fontSize: 10, color: mainColor),
        destinations: [
          buildDestination("文章", 0, _articleSelected, _articleUnselected),
          buildDestination("收集", 1, _collectionSelected, _collectionUnselected),
          buildDestination("阅读", 2, _readSelected, _readUnselected),
          buildDestination("学习", 3, _studySelected, _studyUnselected),
          buildDestination("其他", 4, _collection, _collection),
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
      String text, int railNum, String selectedAsset, String unselectedAsset) {
    return MainNavigationRailDestination(
      icon: Image.asset(
        unselectedAsset,
        width: 25,
        height: 25,
      ),
      selectedIcon: Image.asset(
        selectedAsset,
        width: 25,
        height: 25,
      ),
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

const _article = "assets/tab/article.png";
const _study = "assets/tab/study.png";
const _other = "assets/tab/other.png";
const _read = "assets/tab/read.png";
const _collection = "assets/tab/collection.png";

const _articleSelected = "assets/main_tab/article_selected.png";
const _articleUnselected = "assets/main_tab/article_unselected.png";
const _collectionSelected = "assets/main_tab/collection_selected.png";
const _collectionUnselected = "assets/main_tab/collection_unselected.png";
const _readSelected = "assets/main_tab/read_selected.png";
const _readUnselected = "assets/main_tab/read_unselected.png";
const _studySelected = "assets/main_tab/study_selected.png";
const _studyUnselected = "assets/main_tab/study_unselected.png";
