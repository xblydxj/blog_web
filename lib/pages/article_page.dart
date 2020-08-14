import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/widgets/article_item.dart';

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
      body: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_directory(), Expanded(child: _article())],
      )),
    );
  }

  _article() => ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (_, index) => ArticleItem1(article: list[index]),
        scrollDirection: Axis.vertical,
      );

  _directory() {
    return Container(
      width: 120,
      child: ListView(
        children: list.map((e) => FlatButton.icon(onPressed: _directory,
            icon: Icon(Icons.ac_unit_rounded), label: null)).toList(),
      ),
    );
  }
}
