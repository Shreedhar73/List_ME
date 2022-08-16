// To parse this JSON data, do
//
//     final commentPostModel = commentPostModelFromJson(jsonString);

import 'dart:convert';

CommentPostModel commentPostModelFromJson(String str) => CommentPostModel.fromJson(json.decode(str));

String commentPostModelToJson(CommentPostModel data) => json.encode(data.toJson());

class CommentPostModel {
    CommentPostModel({
        this.title,
        this.body,
        this.userId,
        this.postId,
        this.id,
    });

    String? title;
    String? body;
    String? userId;
    String? postId;
    int? id;

    factory CommentPostModel.fromJson(Map<String, dynamic> json) => CommentPostModel(
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
        postId: json["postId"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "userId": userId,
        "postId": postId,
        "id": id,
    };
}
