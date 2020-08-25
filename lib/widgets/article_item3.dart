import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem3 extends StatelessWidget {
  Article article;

  ArticleItem3({this.article});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, blurRadius: 1, spreadRadius: 1)
                ]),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                        margin: EdgeInsets.only( top: 40),
                        height: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(article.picture.first),
                              fit: BoxFit.fill),
                        ),
                        child: ClipRect(
//                            child: BackdropFilter(
//                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.transparent,
//                          ),
                        ))),
                    Row(
                      children: [
                        tab(_reads, "${article.time}", Icons.access_time,
                            Colors.teal),
                        tab(_reads, "${article.reads}", Icons.remove_red_eye,
                            Colors.teal),
                        tab(_reads, "${article.comments}", Icons.insert_comment,
                            Colors.teal),
                      ],
                    )
                  ],
                ),
                Positioned(
                  top: 230,
                  left: 350,
                  child: RaisedButton.icon(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward,size: 18),
                    label: Text('read more'),
                    padding: EdgeInsets.symmetric(vertical: 12,horizontal: 20),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 160,
            height: 220,
            margin: EdgeInsets.only(left: 50),
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
    ));
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
