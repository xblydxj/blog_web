import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/net/net.dart';
import 'package:web/provider/article_provider.dart';
import 'package:web/widgets/animate_list_tile.dart';
import 'package:web/widgets/article_item4.dart';
import 'package:web/widgets/article_item5.dart';
import 'package:web/widgets/range_page_view.dart';

class ArticlePage3 extends StatefulWidget {
  @override
  _ArticlePage3State createState() => _ArticlePage3State();
}

class _ArticlePage3State extends State<ArticlePage3>
    with TickerProviderStateMixin {
  RangePageController _controller;
  int currentPage = 0;
  double currentProgress = 0.0;
  List<Article> list;
  ArticleProvider _articleProvider;

  @override
  void initState() {
    _controller = RangePageController(viewportFraction: 0.15)
      ..addListener(() => setState(() => currentProgress = _controller.page));
    _articleProvider = Provider.of<ArticleProvider>(context, listen: false);

    super.initState();

    Net.instance.build().post(
        path: 'article/list',
        params: {"pages": 1, "count": 10},
        needLoading: true,
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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [main(), filter()],
      ),
    );
  }

  Widget filter() {
    return Container(
        margin: EdgeInsets.only(top: 10, left: 70, right: 70),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 50),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(2),
            boxShadow: [
              BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 1)
            ]),
        child: Row(
          children: [
            Expanded(
                child: TextField(
              decoration: InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: 'key words',
                  hintStyle: GoogleFonts.juliusSansOne(
                      textStyle: TextStyle(
                          color: CupertinoColors.systemGrey, fontSize: 14)),
                  labelText: 'search by title',
                  labelStyle: GoogleFonts.juliusSansOne(
                      textStyle: TextStyle(
                          color: CupertinoColors.systemGrey, fontSize: 14))),
            )),
            RaisedButton.icon(
              color: Colors.teal,
              onPressed: () {},
              padding: EdgeInsets.symmetric(horizontal: 20),
              icon: Icon(
                Icons.search,
                size: 14,
                color: Colors.white,
              ),
              label: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'SEARCH',
                    style: GoogleFonts.juliusSansOne(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold)),
                  )),
            )
          ],
        ));
  }

  Widget main() {
    double opacity = 0;
    if (list != null) opacity = 1.0 - (currentProgress / 1.0);
    print(opacity);
    return Container(
        child: list == null
            ? SizedBox()
            : Stack(children: [
                AnimatedSwitcher(
                    switchInCurve: Curves.easeInCubic,
                    transitionBuilder: (child, animation) =>
                        FadeTransition(opacity: animation, child: child),
                    duration: Duration(milliseconds: 500),
                    child: Container(
                        key: ValueKey<int>(currentPage),
                        margin: EdgeInsets.only(
                            top: 55, left: 10, right: 10, bottom: 20),
                        padding: EdgeInsets.only(top: 30),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            image: DecorationImage(
                                image: NetworkImage(list[currentPage]
                                    .picture
                                    .replaceAll(".png", "_blur.png")),
                                fit: BoxFit.fill),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black26,
                                  offset: Offset(0, 1),
                                  blurRadius: 5,
                                  spreadRadius: 1)
                            ]),
                        child: Container(
                          child: Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 340),
                                padding: EdgeInsets.symmetric(
                                    vertical: 80, horizontal: 50),
                                child: Column(
                                  children: [
                                    _title(),
                                    _content(),
                                    _desc(),
                                    _tagsAndButton()
                                  ],
                                ),
                              ),

                              // Align(
                              //     alignment: Alignment.bottomCenter,
                              //     child: Container(
                              //       margin:
                              //           EdgeInsets.only(left: 390, right: 40),
                              //       padding:
                              //           EdgeInsets.only(left: 50, right: 50),
                              //       height: 50,
                              //       alignment: Alignment.centerLeft,
                              //       decoration: BoxDecoration(
                              //           color: Colors.white,
                              //           borderRadius: BorderRadius.vertical(
                              //               top: Radius.circular(50)),
                              //           boxShadow: [
                              //             BoxShadow(
                              //                 color: Colors.white,
                              //                 offset: Offset(0, -2),
                              //                 blurRadius: 1,
                              //                 spreadRadius: 1)
                              //           ]),
                              //       child: FlatButton.icon(
                              //           onPressed: () {},
                              //           icon: Icon(Icons.expand_less,
                              //               size: 18,
                              //               color: CupertinoColors.systemGrey),
                              //           label: Text(
                              //             'Read More',
                              //             style: TextStyle(
                              //                 fontSize: 16,
                              //                 color:
                              //                     CupertinoColors.systemGrey),
                              //           )),
                              //     )),
                            ],
                          ),
                        ))),
                Container(
                    width: 250,
                    margin: EdgeInsets.only(
                        top: 20, left: 80, right: 10, bottom: 20),
                    child: RangePageView(
                      controller: _controller,
                      scrollDirection: Axis.vertical,
                      reverse: false,
                      viewportFraction: 0.10,
                      onPageChanged: (index) {
                        print(index);
                        setState(() {
                          currentPage = index;
                        });
                      },
                      children: list
                          .map((article) =>
                              _item2(article, list.indexOf(article)))
                          .toList(),
                    )),
              ]));
  }

  tab(Function onPress, String text, IconData icon, Color iconColor) =>
      FlatButton.icon(
          onPressed: onPress,
          icon: Icon(
            icon,
            size: 13,
            color: Colors.white70,
          ),
          label: Text(text,
              style: GoogleFonts.rajdhani(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 13))));

  Widget _item2(Article article, int index) {
    bool isCurrent = currentProgress == index;
    double scale = 1.0 -
        ((currentProgress - index).abs() >= 1
            ? 1.0
            : (currentProgress - index).abs());
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        color: Colors.transparent,
        width: 160,
        child: ArticleItem5(
          isCurrent: isCurrent,
          progress: scale,
          article: article,
          color: seriesColorMap[article.category],
        ));
  }

  Widget _item(Article article, int index) {
    bool isCurrent = currentProgress == index;
    double scale = 1.0 -
        ((currentProgress - index).abs() >= 1
            ? 1.0
            : (currentProgress - index).abs());
    print(scale);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 13),
      height: 130,
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(left: 15, right: 22, top: 3, bottom: 3),
              height: 130,
              width: 240 + (scale * 40),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black38,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, blurRadius: 10, spreadRadius: 1)
                  ],
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular((scale * 15)),
                      bottomRight: Radius.circular((scale * 15)),
                      bottomLeft: Radius.circular(15))),
              child: Container(
                  padding: EdgeInsets.only(top: 5, left: 25, right: 2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.format_quote,
                          size: 16, color: Colors.tealAccent.withOpacity(0.8)),
                      SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          article.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
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
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(0.6),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ]),
                child: Center(
                    child: Image.asset(seriesMap[article.category],
                        width: 18, height: 18))),
          ),
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
                              color:
                                  CupertinoColors.systemGrey4.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12.5),
                              boxShadow: [
                                BoxShadow(
                                    color: CupertinoColors.systemGrey4
                                        .withOpacity(0.6),
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
                  padding:
                      EdgeInsets.only(bottom: 5, right: (50 - (scale * 50))),
                  child: Transform.scale(
                      scale: 0.6,
                      child: FloatingActionButton.extended(
                          onPressed: () {},
                          isExtended: isCurrent,
                          backgroundColor: mainColor,
                          label: !isCurrent
                              ? SizedBox()
                              : Text('Read More',
                                  style: TextStyle(fontSize: 18)),
                          icon: Icon(Icons.arrow_forward, size: 18)))))
        ],
      ),
    );
  }

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

  Widget _title() => Container(
      margin: EdgeInsets.only(left: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.format_quote,
                size: 20, color: Colors.tealAccent.withOpacity(0.6)),
            SizedBox(width: 6),
            Expanded(
                child: Text(list[currentPage].title,
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 20,
                        fontWeight: FontWeight.bold)))
          ]));

  Widget _content() => Container(
      // padding: EdgeInsets.symmetric(
      //     vertical: 20, horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.black12,
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 1.5, spreadRadius: 1.5)
          ],
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.only(top: 30),
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Text("     ${list[currentPage].content}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              strutStyle: StrutStyle(height: 1.5),
              style: GoogleFonts.rajdhani(
                  textStyle: TextStyle(
                      color: Colors.white.withOpacity(0.8), fontSize: 14)))));

  Widget _desc() => Container(
        margin: EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Row(
          children: [
            tab(_reads, "${list[currentPage].time}", Icons.access_time,
                Colors.white),
            tab(_reads, "${list[currentPage].comments}", Icons.insert_comment,
                Colors.white),
            tab(_reads, "${list[currentPage].reads}", Icons.remove_red_eye,
                Colors.white),
          ],
        ),
      );

  Widget _tagsAndButton() => Container(
        height: 50,
        margin: EdgeInsets.only(top: 20, right: 10),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              height: 25,
              width: 4,
              decoration: BoxDecoration(
                  color: seriesColorMap[list[currentPage].category],
                  boxShadow: [
                    BoxShadow(
                        color: seriesColorMap[list[currentPage].category]
                            .withOpacity(0.4),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
            ),
            Container(
              height: 30,
              margin: EdgeInsets.only(left: 10),
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: list[currentPage]
                    .tags
                    .map((e) => Container(
                        margin: EdgeInsets.all(3),
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                            color: CupertinoColors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(12.5),
                            boxShadow: [
                              BoxShadow(
                                  color: CupertinoColors.white.withOpacity(0.6),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5)
                            ]),
                        child: Center(
                            child: Image.asset(tagsMap[e],
                                width: 12, height: 12))))
                    .toList(),
              ),
            ),
            Spacer(),
            FlatButton.icon(
                onPressed: () {},
                icon: Icon(Icons.art_track, size: 16),
                label: Text('Read More',
                    style:
                        GoogleFonts.armata(textStyle: TextStyle(fontSize: 12))))
          ],
        ),
      );
}
