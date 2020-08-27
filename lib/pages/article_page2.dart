import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/pages/article_page.dart';

class ArticlePage2 extends StatefulWidget {
  @override
  _ArticlePage2State createState() => _ArticlePage2State();
}

class _ArticlePage2State extends State<ArticlePage2>
    with SingleTickerProviderStateMixin {
  ScrollController _controller;
  List<Article> list;

  @override
  void initState() {
    _controller = ScrollController();
    //   ..addListener(() {
    //     // print(_controller.position.pixels);
    //     print((_controller.position.pixels / 200 / 0.618));
    //     print(_controller.runtimeType);
    //     if (_controller.runtimeType is ScrollEndNotification)
    //       _controller.animateTo(
    //           (_controller.position.pixels / 200 / 0.618).round().toDouble(),
    //           duration: Duration(milliseconds: 500),
    //           curve: Curves.easeInOut);
    //   });
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
        decoration: BoxDecoration(),
        child: Stack(
          children: [
            PageView(
              children: list
                  .map((article) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(article.picture.first),
                            fit: BoxFit.fill),
                      ),
                      child: ClipRect(
                          child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                  padding: EdgeInsets.only(top: 50, left: 50),
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
            Align(
                alignment: Alignment.centerRight,
                child: Container(
                    width: 250,
                    margin: EdgeInsets.only(right: 100),
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification notification) {
                        print(notification.metrics.pixels / 200 / 0.618);
                        // print(_controller.position.pixels / 200 / 0.618);
                        print(notification.runtimeType);
                        if (notification.runtimeType is ScrollEndNotification) {
                          _controller.animateTo(
                              (notification.metrics.pixels / 200 / 0.618)
                                  .round()
                                  .toDouble(),
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeInOut);
                          // return true;
                        }
                        return false;
                      },
                      child: ListView(
                        controller: _controller,
                        scrollDirection: Axis.vertical,
                        children: list
                            .map((article) => Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 10),
                                  height: 230 * 0.618,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            NetworkImage(article.picture.first),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
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
                                          maxLines: 2,
                                          style: GoogleFonts.nanumGothic(
                                              textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87
                                                      .withOpacity(0.8),
                                                  fontSize: 20)),
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ],
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ))),
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
                      color: CupertinoColors.systemGrey, fontSize: 14)),
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
}
