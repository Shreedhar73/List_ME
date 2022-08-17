// ignore_for_file: non_constant_identifier_names
import 'dart:isolate';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:listme/models/commentsmodel/comments_model.dart';
import 'package:listme/models/postmodels/post_model.dart';
import 'package:listme/models/usermodel/users_model.dart';
import 'package:listme/widgets/show_toastmssg.dart';
import 'package:path_provider/path_provider.dart';

class RemoteServices{
  Box? box;
  final postsModel = PostModel();
  final commentsModel = CommentsModel();
  final usersModel = UserModel();
  

  Future openBox() async {
    var dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox('data');
    return;
  }

  static var client = http.Client();
  //
//add quotes
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
  //quotes based on userid
  Future<List<PostModel>> fetchPostsID(id) async {
    await openBox();
    try {
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users/$id/posts"));

      final isolate = await Isolate.spawn<List<dynamic>>(postsModel.deserialize,[port.sendPort,response.body]);
      final data = await port.first ;
      // await box!.clear();
      // await box!.add(response.body);
      isolate.kill(priority: Isolate.immediate);

      return data;
    } catch (SocketException) {
      var data = box!.get(0);
      return postModelFromJson(data);
    }
  }

  fetchComments(id) async{
    await openBox();
    try{
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/comments?postId=$id"));
      final isolate = await Isolate.spawn<List<dynamic>>(commentsModel.deserializeComment, [port.sendPort,response.body]);
      final data = await port.first;
      await box!.add(response.body);
      isolate.kill(priority: Isolate.immediate);
      return [true,data];

    }catch(SocketException){
      var data = box!.get(1);
       return data == null ? [false,false] :[true,commentsModelFromJson(data)];
    }

  }

   postComment(id,text) async{
    try{
      var response = await client.post(Uri.parse("https://jsonplaceholder.typicode.com/comments?postId=$id",),
      body: {
        "title": "asas",
        "body": text,
        "userId": "1",
        "postId": "12",
        "id": id.toString()
        }
      );
      if(response.statusCode == 201){
       showToastMessage("Comment Posted Successfully");
      }
    }catch(e){
      showToastMessage(e.toString());
    }

  }

   Future <List<UserModel>> fetchUsers() async{
    await openBox();
    try{
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      final isolate = await Isolate.spawn<List<dynamic>>(usersModel.deserializeUser, [port.sendPort,response.body]);
      final data = await port.first;
      await box!.add(response.body);
      isolate.kill(priority: Isolate.immediate);
      return data;

    }catch(SocketException){
      var data = box!.get(2);
      return userModelFromJson(data);
    }

  }

  
}