// To parse this JSON data, do
//
//     final commentsModel = commentsModelFromJson(jsonString);
import 'dart:isolate';
import 'dart:convert';

import 'package:hive/hive.dart';
  part 'comments_model.g.dart';



List<CommentsModel> commentsModelFromJson(String str) => List<CommentsModel>.from(json.decode(str).map((x) => CommentsModel.fromJson(x)));

String commentsModelToJson(List<CommentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 1)
class CommentsModel {
    CommentsModel({
        this.postId,
        this.id,
        this.name,
        this.email,
        this.body,
    });
    @HiveField(0)
    int? postId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? name;
    @HiveField(3)
    String? email;
    @HiveField(4)
    String? body;

    void deserializeComment(List<dynamic> values){
      SendPort sendPort = values[0];
      String data = values[1];
      sendPort.send(commentsModelFromJson(data));
    }

    factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        postId: json["postId"],
        id: json["id"],
        name: json["name"],
        email: json["email"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "postId": postId,
        "id": id,
        "name": name,
        "email": email,
        "body": body,
    };
}
