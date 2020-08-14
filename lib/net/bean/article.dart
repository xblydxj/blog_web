// To parse this JSON data, do
//
//     final article = articleFromJson(jsonString);

import 'dart:convert';

Article articleFromJson(String str) => Article.fromJson(json.decode(str));

String articleToJson(Article data) => json.encode(data.toJson());

class Article {
  Article({
    this.title,
    this.content,
    this.id,
    this.reads,
    this.comments,
    this.picture,
    this.time,
    this.type,
    this.tags,
  });

  String title;
  String content;
  int id;
  int reads;
  int comments;
  List<String> picture;
  List<String> tags;
  String time;
  int type;

  factory Article.fromJson(Map<String, dynamic> json) => Article(
    title: json["title"],
    content: json["content"],
    id: json["id"],
    reads: json["reads"],
    comments: json["comments"],
    picture: List<String>.from(json["picture"].map((x) => x)),
    tags: List<String>.from(json["tags"].map((x) => x)),
    time: json["time"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "content": content,
    "id": id,
    "reads": reads,
    "comments": comments,
    "picture": List<dynamic>.from(picture.map((x) => x)),
    "tags": List<dynamic>.from(tags.map((x) => x)),
    "time": time,
    "type": type,
  };
}
