// To parse this JSON data, do
//
//     final articleModel = articleModelFromJson(jsonString);

import 'dart:convert';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  String id;
  String title;
  String description;
  String content;
  bool isVisible;
  String urlImage;
  String urlArticle;

  ArticleModel({
    //id firebase
    this.id,
    this.title,
    this.description,
    this.content,
    this.isVisible,
    this.urlImage,
    this.urlArticle,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        content: json["content"],
        isVisible: json["isVisible"],
        urlImage: json["urlImage"],
        urlArticle: json["urlArticle"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "content": content,
        "isVisible": isVisible,
        "urlImage": urlImage,
        "urlArticle": urlArticle,
      };
}
