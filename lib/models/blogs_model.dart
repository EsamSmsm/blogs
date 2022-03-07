// To parse this JSON data, do
//
//     final blogsModel = blogsModelFromJson(jsonString);

import 'dart:convert';

BlogsModel blogsModelFromJson(String str) => BlogsModel.fromJson(json.decode(str));

String blogsModelToJson(BlogsModel data) => json.encode(data.toJson());

class BlogsModel {
  BlogsModel({
    this.id,
    this.date,
    this.title,
    this.content,
  });

  int id;
  String date;
  Title title;
  Content content;

  factory BlogsModel.fromJson(Map<String, dynamic> json) => BlogsModel(
    id: json["id"],
    date: json["date"],
    title: Title.fromJson(json["title"]),
    content: Content.fromJson(json["content"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": date,
    "title": title.toJson(),
    "content": content.toJson(),
  };
}

class Content {
  Content({
    this.rendered,
    this.protected,
  });

  String rendered;
  bool protected;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}

class Title {
  Title({
    this.rendered,
  });

  String rendered;

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}
