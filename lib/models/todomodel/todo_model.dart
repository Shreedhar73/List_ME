// To parse this JSON data, do
//
//     final todoModel = todoModelFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';
   part 'todo_model.g.dart';

List<TodoModel> todoModelFromJson(String str) => List<TodoModel>.from(json.decode(str).map((x) => TodoModel.fromJson(x)));

String todoModelToJson(List<TodoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 4)
class TodoModel {
    TodoModel({
        this.userId,
        this.id,
        this.title,
        this.completed,
    });
    @HiveField(0)
    int? userId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? title;
    @HiveField(3)
    bool? completed;

    factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
    };
}
