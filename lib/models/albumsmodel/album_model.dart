// To parse this JSON data, do
//
//     final albumsModel = albumsModelFromJson(jsonString);

import 'dart:convert';
import 'dart:isolate';
import 'package:hive/hive.dart';
  part 'album_model.g.dart';

List<AlbumsModel> albumsModelFromJson(String str) => List<AlbumsModel>.from(json.decode(str).map((x) => AlbumsModel.fromJson(x)));

String albumsModelToJson(List<AlbumsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
@HiveType(typeId: 4)
class AlbumsModel {
    AlbumsModel({
        this.userId,
        this.id,
        this.title,
    });
    @HiveField(0)
    int? userId;
    @HiveField(1)
    int? id;
    @HiveField(2)
    String? title;

    factory AlbumsModel.fromJson(Map<String, dynamic> json) => AlbumsModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
    );
     void deserializeAlbum(List<dynamic> values){
      SendPort sendPort = values[0];
      String data = values[1];
      sendPort.send(albumsModelFromJson(data));
    }


    
    Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
    };
}
