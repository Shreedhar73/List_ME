// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);
import 'dart:convert';
import 'dart:isolate';

import 'package:hive/hive.dart';
   part 'post_model.g.dart';



List<PostModel> postModelFromJson(String str) => List<PostModel>.from(json.decode(str).map((x) => PostModel.fromJson(x)));

String postModelToJson(List<PostModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 0)
class PostModel {
    PostModel({
        this.userId,
        this.id,
        this.title,
        this.body,
    });
    @HiveField(0)
    int? userId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? title;
    @HiveField(3)
    String? body;

    void deserialize(List<dynamic> values){
      SendPort sendPort = values[0];
      String data = values[1];
      sendPort.send(postModelFromJson(data));
    }

    factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
    };
}
