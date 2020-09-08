import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem2 extends StatelessWidget {
  Article article;

  ArticleItem2({this.article});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        margin: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: CupertinoColors.systemGrey3,
                blurRadius: 2,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.all(Radius.circular(1.0)),
        ),
      ),
      Container(
          height: 230,
          margin: EdgeInsets.only(top: 2, bottom: 40, right: 2, left: 1),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(1.0)),
            image: DecorationImage(
                image: NetworkImage(article.picture),
                fit: BoxFit.fill),
          ),
          child: Container(
              color: Colors.grey.shade200.withOpacity(0.2),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Column(
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
                                  color: Colors.white,
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
                            textStyle:
                                TextStyle(color: Colors.white, fontSize: 14)),
                      ),
                    )
                  ]))),
      Container(
          margin: EdgeInsets.only(top: 160),
          child: ListView(
            padding: EdgeInsets.only(bottom: 70),
            scrollDirection: Axis.horizontal,
            children: article.tags
                .map((e) => OutlineButton(
                    highlightedBorderColor: Colors.white.withOpacity(0.4),
                    padding: EdgeInsets.symmetric(vertical: 0),
                    color: Colors.teal,
                    onPressed: () {},
                    child: Text(
                      e,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    )))
                .toList(),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20)),
      Container(
        height: 100,
        margin: EdgeInsets.only(top: 200, left: 10),
        child: Row(
          children: [
            tab(_reads, "${article.time}", Icons.access_time, Colors.teal),
            tab(_reads, "${article.reads}", Icons.remove_red_eye, Colors.teal),
            tab(_reads, "${article.comments}", Icons.insert_comment,
                Colors.teal),
          ],
        ),
      ),
      Container(
          height: 100,
          margin: EdgeInsets.only(top: 200, left: 10, right: 5),
          child: Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Read More'),
                  Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(Icons.arrow_forward,
                          size: 14, color: Colors.teal))
                ],
              ),
              onPressed: () {},
              textColor: Colors.teal,
            ),
          )),
    ]);
  }

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

  _goDescription() {}
}
