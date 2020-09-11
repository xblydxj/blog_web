import 'package:flutter/material.dart';
import 'package:web/config/constants.dart';
import 'package:web/net/bean/article.dart';

class ArticleItem4 extends StatefulWidget {
  bool isCurrent;
  double progress;
  Article article;
  Color color;

  ArticleItem4({this.isCurrent, this.progress, this.article, this.color});

  @override
  _ArticleItem4State createState() => _ArticleItem4State();
}

class _ArticleItem4State extends State<ArticleItem4>
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

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 80,
      color: Colors.transparent,
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(top: 20),
              width: 200,
              height: 60,
              color: Colors.transparent,
              child: ClipPath(
                clipper: DiamondItem(widget.progress),
                child: Container(
                  color: Colors.white,
                    margin: EdgeInsets.only(left: widget.progress * 12 + 20),
                    child: Row(
                      children: [
                        Container(
                          width: 6,
                          margin:
                              EdgeInsets.symmetric(vertical: 3, horizontal: 5),
                          decoration: BoxDecoration(
                              color: widget.color,
                              boxShadow: [
                                BoxShadow(
                                    color: widget.color,
                                    blurRadius: 0,
                                    spreadRadius: 1)
                              ]),
                        ),
                        Text(
                          widget.article.title,
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        )
                      ],
                    )),
              )),
          Container(
            margin: EdgeInsets.only(left: 10),
            padding: EdgeInsets.all(widget.progress * 5),
            decoration: BoxDecoration(
                color: widget.color.withOpacity(widget.progress),
                boxShadow: [
                  BoxShadow(
                      color: widget.color.withOpacity(0.3),
                      blurRadius: 1,
                      spreadRadius: 1)
                ],
                borderRadius: BorderRadius.circular(widget.progress * 0.5)),
            child: Image.asset(seriesMap[widget.article.category],
                width: 16, height: 16),
          )
        ],
      ),
    );
  }
}

class DiamondItem extends CustomClipper<Path> {
  double progress;

  DiamondItem(this.progress);

  @override
  Path getClip(Size size) {
    var path = Path();
    path
      ..moveTo(progress * size.height / 3, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width - progress * size.height / 3, size.height)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(DiamondItem oldClipper) => oldClipper.progress != progress;
}
