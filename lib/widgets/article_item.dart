import 'package:flutter/material.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem1 extends StatelessWidget {
  Article article;

  ArticleItem1({this.article});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 40),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, left: 350),
              width: 600,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(4, 4),
                        blurRadius: 3.0)
                  ]),
            ),
            Container(
              width: 400,
              height: 300,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        offset: Offset(-4, -4),
                        blurRadius: 5.0)
                  ]),
              child: CircleAvatar(
                  child: Image.network(
                    article.picture.first,
                    fit: BoxFit.fitHeight,
                    width: 400,
                    height: 300,
                  ),
                  radius: 5.0),
            )
          ],
        ));
  }
}
