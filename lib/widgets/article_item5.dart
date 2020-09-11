import 'package:flutter/material.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem5 extends StatefulWidget {
  bool isCurrent;
  double progress;
  Article article;
  Color color;

  ArticleItem5(
      {Key key, this.isCurrent, this.progress, this.article, this.color})
      : super(key: key);

  @override
  _ArticleItem5State createState() => _ArticleItem5State();
}

class _ArticleItem5State extends State<ArticleItem5>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  fresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.2 + 0.6 * widget.progress),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 2 * widget.progress+1,
                spreadRadius: 1 * widget.progress+1)
          ],
          borderRadius: BorderRadius.circular(2),
        ),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 12, top: 11, bottom: 11, left: 8),
              width: 4,
              decoration: BoxDecoration(color: widget.color, boxShadow: [
                BoxShadow(
                    color: widget.color.withOpacity(0.4 * widget.progress),
                    blurRadius: 1,
                    spreadRadius: 1)
              ]),
            ),
            Container(
              padding: EdgeInsets.all(6 * widget.progress),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8 * widget.progress),
                  color: widget.color.withOpacity(widget.progress),
                  boxShadow: [
                    BoxShadow(
                        color: widget.color.withOpacity(0.4 * widget.progress),
                        blurRadius: 1,
                        spreadRadius: 1)
                  ]),
              child: Image.asset(
                seriesMap[widget.article.category],
                width: 18,
                height: 18,
              ),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.only(left: 12),
                    child: Text(widget.article.title,
                        maxLines: 1,
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 12))))
          ],
        ),
      ),
    );
  }
}
