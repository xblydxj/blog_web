import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem1 extends StatelessWidget {
  Article article;

  ArticleItem1({this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
//        decoration: BoxDecoration(
//            color: CupertinoColors.systemGrey6,
//            border: Border(),
//            borderRadius: BorderRadius.all(Radius.circular(10.0)),
//            boxShadow: [
//              BoxShadow(
//                  color: CupertinoColors.systemGrey4,
//                  offset: Offset(0, 0),
//                  spreadRadius: 1.0,
//                  blurRadius: 4.0)
//            ]
//        ),
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Row(
          children: [
            Container(
              height: 300,
              width: 450,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(),
                boxShadow: [
                  BoxShadow(
                      color: CupertinoColors.systemGrey4,
                      offset: Offset(0, 0),
                      spreadRadius: 1.0,
                      blurRadius: 5.0)
                ],
                borderRadius:
                    BorderRadius.all(Radius.circular(5.0)),
                image: DecorationImage(
                    image: NetworkImage(article.picture.first),
                    fit: BoxFit.fill),
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
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
                          style: GoogleFonts.nanumGothic(
                              textStyle: TextStyle(
                                  color: CupertinoColors.systemGrey,
                                  fontSize: 14)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(article.time),
                    ],
                  )
                ],
              ),
            )),
          ],
        ));
  }
}
