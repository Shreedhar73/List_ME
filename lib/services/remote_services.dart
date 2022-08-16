// ignore_for_file: non_constant_identifier_names
import 'dart:isolate';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:listme/models/commentsmodel/comments_model.dart';
import 'package:listme/models/postmodels/post_model.dart';
import 'package:path_provider/path_provider.dart';

class RemoteServices {
  Box? box;
  final postsModel = PostModel();
  final commentsModel = CommentsModel();

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  static var client = http.Client();
  //

  Future<List<PostModel>> fetchPosts() async {
    await openBox();
    try {
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

      final isolate = await Isolate.spawn<List<dynamic>>(postsModel.deserialize,[port.sendPort,response.body]);
      final data = await port.first ;
      await box!.clear();
      await box!.add(response.body);
      isolate.kill(priority: Isolate.immediate);

      return data;
    } catch (SocketException) {
      var data = box!.get(0);
      return postModelFromJson(data);
    }
  }

  Future <List<CommentsModel>> fetchComments(id) async{
    await openBox();
    try{
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/comments?postId=$id"));
      final isolate = await Isolate.spawn<List<dynamic>>(commentsModel.deserializeComment, [port.sendPort,response.body]);
      final data = await port.first;
      await box!.add(response.body);
      isolate.kill(priority: Isolate.immediate);
      return data;

    }catch(SocketException){
      var data = box!.get(1);
      return commentsModelFromJson(data);
    }

  }
}