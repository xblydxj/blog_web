import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/net/net.dart';
import 'package:web/provider/article_provider.dart';
import 'package:web/widgets/animate_list_tile.dart';
import 'package:web/widgets/range_page_view.dart';
import 'dart:math' as math;

import 'article_page.dart';

class ArticlePage3 extends StatefulWidget {
  @override
  _ArticlePage3State createState() => _ArticlePage3State();
}

class _ArticlePage3State extends State<ArticlePage3>
    with SingleTickerProviderStateMixin {
  ScrollController _controller;
  var currentPage = 0;
  List<Article> list;

  ArticleProvider _articleProvider;

  @override
  void initState() {
    _controller = ScrollController()
      ..addListener(() {
        print(_controller.position);
      });
    super.initState();

    _articleProvider = Provider.of<ArticleProvider>(context, listen: false);
    Net.instance.build().post(
        path: 'article/list',
        params: {"pages": currentPage, "count": 10},
        onSuccess: (data) => setState(() => list =
            (data["list"] as List<dynamic>)
                .map((e) => Article.fromJson(e))
                .toList()));
  }

  @override
  void dispose() {
    _controller.dispose();
    _articleProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [filter(), main()],
      ),
    );
  }

  Widget filter() {
    return Container(
        child: Row(
      children: [
        //系列
        // _series(),
        // _tags(),
      ],
    ));
  }

  Widget main() => Container(
      child: list == null
          ? SizedBox()
          : Container(
              margin:
                  EdgeInsets.only(top: 100, left: 10, right: 10, bottom: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 2,
                      spreadRadius: 1)
                ],
                image: DecorationImage(
                    image: NetworkImage(list[currentPage]
                        .picture
                        .replaceAll(".png", "_blur.png")),
                    fit: BoxFit.fill),
              ),
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 340),
                      padding:
                          EdgeInsets.symmetric(vertical: 80, horizontal: 50),
                      child: Column(
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.format_quote,
                                        size: 20,
                                        color:
                                            Colors.tealAccent.withOpacity(0.6)),
                                    SizedBox(width: 6),
                                    Expanded(
                                        child: Text(list[currentPage].title,
                                            style: GoogleFonts.josefinSans(
                                                textStyle: TextStyle(
                                                    color: Colors.white
                                                        .withOpacity(0.9),
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold))))
                                  ])),
                          Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 1.5,
                                        spreadRadius: 1.5)
                                  ],
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.only(top: 20),
                              child: Text("       ${list[currentPage].content}",
                                  strutStyle: StrutStyle(height: 1.5),
                                  style: GoogleFonts.josefinSans(
                                      textStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.8),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)))),
                          Container(
                            margin:
                                EdgeInsets.only(top: 10, left: 10, right: 10),
                            child: Row(
                              children: [
                                tab(_reads, "${list[currentPage].comments}",
                                    Icons.insert_comment, Colors.white),
                                tab(_reads, "${list[currentPage].reads}",
                                    Icons.remove_red_eye, Colors.white),
                                Expanded(
                                    child: Align(
                                        alignment: Alignment.centerRight,
                                        child: tab(
                                            _reads,
                                            "${list[currentPage].time}",
                                            Icons.access_time,
                                            Colors.white))),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: EdgeInsets.only(left: 390, right: 40),
                          padding: EdgeInsets.only(left: 50, right: 50),
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(50)),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(0, -2),
                                    blurRadius: 1,
                                    spreadRadius: 1)
                              ]),
                          child: FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.expand_less,
                                  size: 18, color: CupertinoColors.systemGrey),
                              label: Text(
                                'Read More',
                                style: GoogleFonts.josefinSans(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: CupertinoColors.systemGrey)),
                              )),
                        )),
                    Container(
                      width: 270,
                      margin: EdgeInsets.only(left: 70),
                      child: ListView(
                        controller: _controller,
                        physics: _ForceImplicitScrollPhysics(
                            allowImplicitScrolling: true,
                            parent: RangePageScrollPhysics().applyTo(null)),
                        padding: EdgeInsets.only(top: 10),
                        children: list.map((e) => _item(e)).toList(),
                        shrinkWrap: true,
                      ),
                    ),
                  ],
                ),
              )));

  tab(Function onPress, String text, IconData icon, Color iconColor) =>
      FlatButton.icon(
          onPressed: onPress,
          icon: Icon(
            icon,
            size: 16,
            color: Colors.white70,
          ),
          label: Text(text,
              style: GoogleFonts.josefinSans(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 13))));

  Widget _item(Article article) => Container(
        margin: EdgeInsets.symmetric(vertical: 13),
        height: 130,
        child: Stack(
          children: [
            Container(
                margin: EdgeInsets.only(left: 15, right: 22, top: 3, bottom: 3),
                height: 130,
                width: 240,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.black38,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54, blurRadius: 1, spreadRadius: 1)
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(0))),
                child: Container(
                    padding: EdgeInsets.only(top: 5, left: 25, right: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.format_quote,
                            size: 16, color: Colors.white.withOpacity(0.6)),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            article.title,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.w300),
                          ),
                        )
                      ],
                    ))),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                  margin: EdgeInsets.only(top: 12),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.red.withOpacity(0.4),
                            blurRadius: 1,
                            spreadRadius: 1)
                      ]),
                  child: Center(
                      child: Image.asset(seriesMap[article.category],
                          width: 18, height: 18))),
            ),
            Padding(
                padding: EdgeInsets.only(bottom: 55, left: 32, right: 45),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Divider(height: 1, color: Colors.white24),
                )),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: 30,
                  margin: EdgeInsets.only(left: 30, bottom: 15),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: article.tags
                        .map((e) => Container(
                            margin: EdgeInsets.all(3),
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: CupertinoColors.systemGrey4
                                    .withOpacity(0.6),
                                borderRadius: BorderRadius.circular(12.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: CupertinoColors.systemGrey4
                                          .withOpacity(0.4),
                                      blurRadius: 1,
                                      spreadRadius: 1)
                                ]),
                            child: Center(
                                child: Image.asset(tagsMap[e],
                                    width: 12, height: 12))))
                        .toList(),
                  ),
                )),
            Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: Transform.scale(
                        scale: 0.8,
                        child: FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: mainColor,
                            mini: true,
                            child: Icon(Icons.arrow_forward, size: 18)))))
          ],
        ),
      );

  Widget _series() => Expanded(
      child: Container(
          // width: 200,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: AnimateListTile(
            title: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Series',
                        style: TextStyle(color: Colors.teal, fontSize: 14)),
                    Transform.translate(
                        offset: Offset(20, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.tealAccent.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                  child: Image.asset(seriesMap.values.first,
                                      width: 15, height: 15)),
                            ),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.yellow.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                          spreadRadius: 1)
                                    ]),
                                child: Center(
                                    child: Image.asset(
                                        seriesMap.values.elementAt(1),
                                        width: 15,
                                        height: 15)),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(-20, 0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                          spreadRadius: 1)
                                    ]),
                                child: Center(
                                    child: Image.asset(
                                        seriesMap.values.elementAt(2),
                                        width: 15,
                                        height: 15)),
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
            expandedTitle: Container(
              // width: 200,
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text('Series',
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            list: Container(
              height: 400,
              child: ListView(
                children: seriesList
                    .map((e) => Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CheckboxListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              activeColor: mainColor,
                              secondary: Image.asset(seriesMap[e],
                                  width: 22, height: 22),
                              title: Text(e,
                                  style: TextStyle(
                                      color: CupertinoColors.systemGrey)),
                              value: _articleProvider.series[e],
                              onChanged: (v) => setState(() => _articleProvider
                                  .series[e] = !_articleProvider.series[e])),
                        )))
                    .toList(),
              ),
            ),
          )));

  Widget _tags() => Expanded(
      child: Container(
          // width: 200,
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          child: AnimateListTile(
            title: Container(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tags',
                        style: TextStyle(color: Colors.teal, fontSize: 14)),
                    Transform.translate(
                        offset: Offset(16, 0),
                        child: Row(
                          children: [
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: Colors.tealAccent.withOpacity(0.5),
                                  borderRadius: BorderRadius.circular(4),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                        spreadRadius: 1)
                                  ]),
                              child: Center(
                                  child: Image.asset(tagsMap.values.first,
                                      width: 15, height: 15)),
                            ),
                            Transform.translate(
                              offset: Offset(-8, 0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.yellow.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                          spreadRadius: 1)
                                    ]),
                                child: Center(
                                    child: Image.asset(
                                        tagsMap.values.elementAt(1),
                                        width: 15,
                                        height: 15)),
                              ),
                            ),
                            Transform.translate(
                              offset: Offset(-16, 0),
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 2,
                                          spreadRadius: 1)
                                    ]),
                                child: Center(
                                    child: Image.asset(
                                        tagsMap.values.elementAt(2),
                                        width: 15,
                                        height: 15)),
                              ),
                            ),
                          ],
                        ))
                  ],
                )),
            expandedTitle: Container(
              // width: 200,
              height: 50,
              alignment: Alignment.centerLeft,
              child: Text('Tags',
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ),
            list: Container(
              height: 400,
              child: ListView(
                children: tagsList
                    .map((e) => Expanded(
                            child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: CheckboxListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              activeColor: mainColor,
                              secondary: Image.asset(tagsMap[e],
                                  width: 22, height: 22),
                              title: Text(e,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      color: CupertinoColors.systemGrey)),
                              value: _articleProvider.tags[e],
                              onChanged: (v) => setState(() => _articleProvider
                                  .tags[e] = !_articleProvider.tags[e])),
                        )))
                    .toList(),
              ),
            ),
          )));

  _reads() {}
}

class _ForceImplicitScrollPhysics extends ScrollPhysics {
  const _ForceImplicitScrollPhysics({
    @required this.allowImplicitScrolling,
    ScrollPhysics parent,
  })  : assert(allowImplicitScrolling != null),
        super(parent: parent);

  @override
  _ForceImplicitScrollPhysics applyTo(ScrollPhysics ancestor) {
    return _ForceImplicitScrollPhysics(
      allowImplicitScrolling: allowImplicitScrolling,
      parent: buildParent(ancestor),
    );
  }

  @override
  final bool allowImplicitScrolling;
}
