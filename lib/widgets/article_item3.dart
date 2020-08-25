import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem3 extends StatelessWidget {
  Article article;

  ArticleItem3({this.article});

  @override
  Widget build(BuildContext context) {
    return  Container(
          padding: EdgeInsets.only(top: 10),
      child: Stack(
        children: [
          Container(
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 40),
                        height: 210,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(article.picture.first),
                              fit: BoxFit.fill),
                        ),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 210, right: 10, top: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title,
                                    maxLines: 2,
                                    style: GoogleFonts.nanumGothic(
                                        textStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Colors.white,
                                            fontSize: 20)),
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    child:  Text(
                                      article.content,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.justify,
                                      softWrap: true,
                                      strutStyle: StrutStyle(height: 4),
                                      style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )),
                    Row(
                      children: [
                        tab(_reads, "${article.reads}", Icons.remove_red_eye,
                            Colors.teal),
                        tab(_reads, "${article.comments}", Icons.insert_comment,
                            Colors.teal),
                        Padding(padding: EdgeInsets.only(left: 40)),
                        tab(_reads, "${article.time}", Icons.access_time,
                            Colors.teal),
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.only(top: 225,right: 20),
                      child: RaisedButton.icon(
                    color: mainColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward, size: 18),
                    label: Text('Read More'),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  )),
                )
              ],
            ),
          ),
          Container(
            width: 160,
            height: 220,
            margin: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                image: DecorationImage(
                    image: NetworkImage(article.picture.first),
                    fit: BoxFit.fill),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 5, spreadRadius: 4)
                ]),
          ),
        ],
      ),
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
                      color: CupertinoColors.systemGrey,
                      fontSize: 12))));

  _reads() {}
}
