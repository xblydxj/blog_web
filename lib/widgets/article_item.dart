import 'package:flutter/material.dart';
import 'package:web/net/bean/article.dart';

var json = {
  "title": "title",
  "content": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "id": 1,
  "reads": 10,
  "comments": 20,
  "picture": [],
  "time": "2020-08-11",
  "type": 0
};

class ArticleItem1 extends StatelessWidget {
  Article article;

  ArticleItem1({this.article});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, left: 180),
          width: 300,
          height: 200,
          decoration: BoxDecoration(
              border: Border(),
            borderRadius:
          ),
        ),
        Image.network(
          article.picture.first,
          width: 200,
          height: 200,
        ),
      ],
    );
  }
}
