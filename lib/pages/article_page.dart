import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:web/net/bean/article.dart';
import 'package:web/widgets/article_item.dart';
import 'package:web/widgets/article_item2.dart';
import 'package:web/widgets/article_item3.dart';

var json1 = {
  "title": "C++反射思路及dart的反射实现",
  "content": "C++同为（dart:mirror被禁用）没有反射api的语言，依旧另辟蹊径实现反射的方式, "
      "但也不算是反射，使用了注解的方式在编译前创建了对应的map，之后的反射也是在map中进行对照来获取对应的对象。",
  "id": 0,
  "reads": 10,
  "comments": 20,
  "tags": ["flutter", "dart"],
  "pictures": [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597387733850&di=663058166e9f9400775b62e68ff3290f&imgtype=0&src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20181218%2Fdc4e2785878841108bb58cf088aa3201.jpeg"
  ],
  "time": "2020-08-11",
  "type": 0,
  "link":
      "http://xblydxj-blog.oss-cn-hangzhou.aliyuncs.com/article/%E8%BF%9F%E5%88%B0%E7%9A%84MVP.md",
  "category": "学习"
};

var json2 = {
  "id": 1,
  "title": "迟到的mvp",
  "content":
      "去年第一次使用mvp做了个 小应用 ，也是[干货集中营](gank.io)的安卓客户端，Material的风格，MVP的架构，也使用了rxjava和retrofit，不过这期间没有去做过关于mvp的这样的总结，现在补上这篇",
  "reads": 1,
  "comments": 0,
  "pictures": [
    "http://xblydxj-blog.oss-cn-hangzhou.aliyuncs.com/article_pictures/0_main.png"
  ],
  "time": "2017-07-16",
  "link":
      "http://xblydxj-blog.oss-cn-hangzhou.aliyuncs.com/article/%E8%BF%9F%E5%88%B0%E7%9A%84MVP.md",
  "tags": ["android", "java"],
  "category": "学习"
};

var json3 = {
  "id": 2,
  "title": "崇明岛",
  "content":
      "当时的温度高达36摄氏度，很后悔，晚了一礼拜，前一个礼拜还有春意，现在就是大夏天了，回来之后皮肤也发红了。\n 整天待在家里，就知道宅，出去玩了一趟发现确实还是宅好。\n 计划了好几个礼拜，作为上海一个较为出名的自然景观，呆着一些憧憬前往的，然鹅",
  "reads": 1,
  "comments": 1,
  "pictures": [
    "http://xblydxj-blog.oss-cn-hangzhou.aliyuncs.com/article_pictures/1_main.png"
  ],
  "time": "2017-07-14",
  "link":
      "http://xblydxj-blog.oss-cn-hangzhou.aliyuncs.com/article/%E5%B4%87%E6%98%8E%E5%B2%9B.md",
  "tags": ["travel"],
  "category": "生活"
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
      Article.fromJson(json1),
      Article.fromJson(json2),
      Article.fromJson(json3),
      Article.fromJson(json2),
      Article.fromJson(json1),
      Article.fromJson(json3),
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
      drawer: Container(),
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.only(top: 30, right: 10, left: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: [
                BoxShadow(color: Colors.black12, blurRadius: 2, spreadRadius: 2)
              ]),
          margin: EdgeInsets.only(top: 2, right: 2, left: 2, bottom: 52),
          child: Container(
              width: 1400,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Expanded(child: _article())],
              ))),
    );
  }

  _article() => Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 50,
            crossAxisSpacing: 50,
            childAspectRatio: 1 / 0.48),
        shrinkWrap: false,
        itemCount: list.length,
        itemBuilder: (_, index) => ArticleItem3(article: list[index]),
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
        child: Container());
  }
}
