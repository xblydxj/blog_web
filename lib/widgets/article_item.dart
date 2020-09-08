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
    return Stack(
      children: [
        Container(
            height: 190,
            margin: EdgeInsets.only(bottom: 40, left: 30, right: 30),
            child: Row(
              children: [
                Container(
                  height: 190,
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(),
                    boxShadow: [
                      BoxShadow(
                          color: CupertinoColors.systemGrey,
                          blurRadius: 2,
                          spreadRadius: 1)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                        image: NetworkImage(article.picture),
                        fit: BoxFit.fill),
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 30),
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
                              strutStyle: StrutStyle(height: 1.6),
                              style: GoogleFonts.nanumGothic(
                                  textStyle: TextStyle(
                                      color: CupertinoColors.systemGrey,
                                      fontSize: 14)),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tab(_reads, "${article.time}", Icons.access_time,
                              Colors.teal),
                          tab(_reads, "${article.reads}", Icons.remove_red_eye,
                              Colors.teal),
                          tab(_reads, "${article.comments}",
                              Icons.insert_comment, Colors.teal),

                        ],
                      )
                    ],
                  ),
                )),
              ],
            )),
        Padding(
            padding: EdgeInsets.only(top: 150, right: 10),
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                  onPressed: _goDescription,
                  backgroundColor: Colors.teal,
                  mini: true,
                  elevation: 3,
                  child:
                      Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                )))
      ],
    );
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
                      color: CupertinoColors.systemGrey, fontSize: 12))));

  _reads() {}

  _goDescription() {}
}
