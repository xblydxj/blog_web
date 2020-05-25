import 'package:flutter/material.dart';
import 'package:web/widgets/main_tab.dart';

class MainPage extends StatefulWidget {
  static const String baseRoute = '/main';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentTab = 0;

  final tabsMap = {
    '文章': "tab/article_selected.png",
    '收集': "tab/collection_selected.png",
    '时间线': "tab/timeline_selected.png",
    '分类': "tab/category_selected.png",
    '我的': "tab/account_selected.png",
    '其他': "tab/other_selected.png",
  };
  final tabs = ['文章', '收集', '时间线', '分类', '我的', '其他'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        color: Colors.purple,
      ),
      backgroundColor: Colors.white,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _account(),
              Expanded(child: _buildTabBar()),
            ],
          ),
          Expanded(
            child: _buildTableBarView(),
          )
        ],
      ),
    );
  }

  Widget _buildTabBar() => MainTabBar(
        onTap: (tab) => {
          setState(() {
            _currentTab = tab;
          })
        },
        labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        unselectedLabelStyle: TextStyle(fontSize: 14),
        isScrollable: true,
        controller: _tabController,
        labelColor: Colors.grey,
        unselectedLabelColor: Colors.grey,
        indicatorColor: Colors.transparent,
        tabs: [
          buildTab(0, '文章', "tab/article_selected.png",
              "tab/article_unselected.png"),
          buildTab(1, '收集', "tab/collection_selected.png",
              "tab/collection_unselected.png"),
          buildTab(2, '时间线', "tab/timeline_selected.png",
              "tab/timeline_unselected.png"),
          buildTab(3, '分类', "tab/category_selected.png",
              "tab/category_unselected.png"),
          buildTab(4, '我的', "tab/account_selected.png",
              "tab/account_unselected.png"),
          buildTab(
              5, '其他', "tab/other_selected.png", "tab/other_unselected.png"),
        ],
      );

  Widget _buildTableBarView() => MainTabBarView(
      controller: _tabController,
      children: tabs.map((e) => Center(child: _account())).toList());

  MainTab buildTab(
      int index, String text, String selectedAsset, String unselectedAsset) {
    bool selected = _currentTab == index;
    return MainTab(
        child: Card(
      elevation: selected ? 0 : 0,
      color: selected ? Colors.tealAccent.withOpacity(0.6) : Colors.transparent,
      child: Container(
        width: 140,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 15, 0),
              child: Image.asset(
                selected ? selectedAsset : unselectedAsset,
                width: 40,
                height: 20,
              ),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: selected ? Colors.black45 : Colors.grey,
                  fontWeight: selected ? FontWeight.bold : FontWeight.normal),
            )
          ],
        ),
      ),
    ));
  }

  Widget _account() {
    return Container(
      padding: EdgeInsets.only(top: 40),
      width: 180,
      height: 120,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: AssetImage(
            "avatar/avatar_male_30.png",
          ),
        ),
        onTap: () => {},
        title: Text(
          'xblydxjxxxxxxxxxxxxxxxx',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.black54, fontSize: 14),
        ),
      ),
    );
  }
}
