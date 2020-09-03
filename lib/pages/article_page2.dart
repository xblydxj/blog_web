import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/pages/article_page.dart';
import 'package:web/widgets/get_color_util.dart';
import 'package:web/widgets/loading_shimmer.dart';
import 'package:web/widgets/range_page_view.dart';

class ArticlePage2 extends StatefulWidget {
  @override
  _ArticlePage2State createState() => _ArticlePage2State();
}

class _ArticlePage2State extends State<ArticlePage2>
    with SingleTickerProviderStateMixin {
  RangePageController _controller;
  PageController _controller2;
  List<Article> list;

  var _currentIndex = 0.0;

  @override
  void initState() {
    _controller = RangePageController(viewportFraction: 0.3)
      ..addListener(() {
        setState(() {
          _currentIndex = _controller.page;
        });
      });
    _controller2 = PageController();
    super.initState();
    list = [
      Article.fromJson(json),
      Article.fromJson(json),
      Article.fromJson(json),
      Article.fromJson(json),
      Article.fromJson(json),
      Article.fromJson(json),
    ];
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            PageView(
              controller: _controller2,
              scrollDirection: Axis.vertical,
              children: list
                  .map((article) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(article.picture.first),
                            fit: BoxFit.fill),
                      ),
                      child: ClipRect(
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Container(
                                  padding: EdgeInsets.only(
                                      top: 50, left: 400, right: 30),
                                  child: Column(children: [
                                    desc(article),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        tab(_reads, "${article.time}",
                                            Icons.access_time, Colors.teal),
                                        tab(_reads, "${article.reads}",
                                            Icons.remove_red_eye, Colors.teal),
                                        tab(_reads, "${article.comments}",
                                            Icons.insert_comment, Colors.teal),
                                      ],
                                    ),
                                  ]))))))
                  .toList(),
            ),
            Container(
                width: 250,
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(left: 100),
                child: Transform.translate(
                  offset: Offset(0, -0),
                  child: RangePageView(
                    allowImplicitScrolling: true,
                    controller: _controller,
                    viewportFraction: 0.28,
                    onPageChanged: (index) {
                      print(index);
                      _controller2.animateToPage(index,
                          duration: Duration(milliseconds: 600),
                          curve: Curves.easeInCubic);
                    },
                    scrollDirection: Axis.vertical,
                    children: list.map((article) => _item(article)).toList(),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  desc(Article article) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 40,
                height: 45,
                child: Center(
                    child: Text(
                  "\＂",
                  style: TextStyle(
                      color: mainColor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                )),
              ),
              Expanded(
                  child: Text(
                article.title,
                style: GoogleFonts.nanumGothic(
                    textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87.withOpacity(0.8),
                        fontSize: 20)),
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
              )),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              article.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              softWrap: true,
              strutStyle: StrutStyle(height: 1.6),
              style: GoogleFonts.nanumGothic(
                  textStyle: TextStyle(
                      color: Colors.black87.withOpacity(0.8), fontSize: 14)),
            ),
          ),
        ],
      );

  tab(Function onPress, String text, IconData icon, Color iconColor) =>
      FlatButton.icon(
          onPressed: onPress,
          icon: Icon(
            icon,
            size: 14,
            color: iconColor,
          ),
          label: Text(text,
              style: GoogleFonts.nanumGothic(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.systemGrey,
                      fontSize: 12))));

  _reads() {}

  Widget _item(Article article) {
    var scale = 1.10 -
        ((_currentIndex - list.indexOf(article)).abs() >= 1
                ? 1
                : (_currentIndex - list.indexOf(article)).abs()) *
            0.10;
    var opacity = 1.0 -
        ((_currentIndex - list.indexOf(article)).abs() >= 1
                ? 1
                : (_currentIndex - list.indexOf(article)).abs()) *
            0.46;
    return Transform.scale(
        scale: scale,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          height: 200 * 0.618,
          decoration: BoxDecoration(
              color: Colors.white.withOpacity(opacity),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 1.0, spreadRadius: 1.0)
              ]),
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 40,
                        height: 45,
                        alignment: Alignment.topCenter,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              "\＂",
                              style: TextStyle(
                                  color: mainColor,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      Expanded(
                          child: Container(
                              margin: EdgeInsets.only(top: 10),
                              child: Text(
                                article.title,
                                maxLines: 2,
                                style: GoogleFonts.nanumGothic(
                                    textStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87.withOpacity(0.8),
                                        fontSize: 16)),
                                textAlign: TextAlign.justify,
                                overflow: TextOverflow.ellipsis,
                              ))),
                    ],
                  )),
                  Container(
                    alignment: Alignment.centerRight,
                    child: FlatButton.icon(
                        onPressed: _reads,
                        icon: Icon(Icons.arrow_forward,
                            color: Colors.teal, size: 16),
                        label: Text('read more',
                            style: TextStyle(color: mainColor, fontSize: 14))),
                  )
                ],
              )),
        ));
  }
}
