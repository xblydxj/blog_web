import 'package:flutter/cupertino.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/widgets/article_item.dart';

var json = {
  "title": "title",
  "content": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "id": 1,
  "reads": 10,
  "comments": 20,
  "picture":
      ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597341974363&di=8c623cfdb910733fffdd07b41e70f749&imgtype=0&src=http%3A%2F%2Ff.hiphotos.baidu.com%2Fzhidao%2Fpic%2Fitem%2Fd8f9d72a6059252dc1b214f7349b033b5ab5b99f.jpg"],
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
    return Container(
      child: ListView(
        children: list.map((e) => ArticleItem1(article: e)).toList(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
