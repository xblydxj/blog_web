// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article(
      {this.title,
      this.content,
      this.id,
      this.reads,
      this.comments,
      this.picture,
      this.link,
      this.time,
      this.type,
      this.tags,
      this.category});

  String title;
  String content;
  String link;
  int id;
  int reads;
  int comments;
  String picture;
  List<String> tags;
  String category;
  String time;
  int type;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
        title: json["title"],
        content: json["content"],
        id: json["id"],
        reads: json["reads"],
        link: json["link"],
        category: json["category"],
        comments: json["comments"],
        picture: json["pictures"],
        tags: (json["tags"] as String).split(','),
        time: json["time"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "content": content,
        "id": id,
        "category": category,
        "link": link,
        "reads": reads,
        "comments": comments,
        "picture": picture,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "time": time,
        "type": type,
      };
}
