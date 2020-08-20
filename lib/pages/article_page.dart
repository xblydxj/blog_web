import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/widgets/article_item.dart';
import 'package:web/widgets/article_item2.dart';

var json = {
  "title": "C++反射思路及dart的反射实现",
  "content": "C++同为（dart:mirror被禁用）没有反射api的语言，依旧另辟蹊径实现反射的方式, "
      "但也不算是反射，使用了注解的方式在编译前创建了对应的map，之后的反射也是在map中进行对照来获取对应的对象。",
  "id": 1,
  "reads": 10,
  "comments": 20,
  "tags": ["flutter", "dart"],
  "picture": [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597387733850&di=663058166e9f9400775b62e68ff3290f&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20181218%2Fdc4e2785878841108bb58cf088aa3201.jpeg"
  ],
  "time": "2020-08-11",
  "type": 0
};

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  List<Article> list;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
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
      backgroundColor: Colors.transparent,
      drawer: Container(),
      body: Container(
          margin: EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Expanded(child: _article())],
          )),
    );
  }

  _article() => Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 30,
            crossAxisSpacing: 25,
            childAspectRatio: 1 / 0.560),
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (_, index) => ArticleItem2(article: list[index]),
        scrollDirection: Axis.vertical,
      ));

  _directory() {
    return Container(
      margin: EdgeInsets.only(left: 2, right: 3, bottom: 20),
      width: 230,
      decoration: BoxDecoration(
          color: Colors.teal,
          boxShadow: [
            BoxShadow(
                color: Colors.teal.withOpacity(0.5),
                blurRadius: 2,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: ListView(
        children: list
            .map((e) => Container(
                margin: EdgeInsets.only(top: 3, bottom: 3, left: 5),
                child: FlatButton.icon(
                    onPressed: _directory,
                    icon: Icon(Icons.circle, size: 12),
                    label: Container(
                        width: 177,
                        child: Text(e.title,
                            textAlign: TextAlign.justify,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.nanumGothic(
                              textStyle: TextStyle(fontSize: 12),
                            ))))))
            .toList(),
      ),
    );
  }
}
