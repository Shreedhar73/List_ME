// ignore_for_file: non_constant_identifier_names
import 'dart:isolate';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:listme/models/albumsmodel/album_model.dart';
import 'package:listme/models/commentsmodel/comments_model.dart';
import 'package:listme/models/imagemodel/image_model.dart';
import 'package:listme/models/postmodels/post_model.dart';
import 'package:listme/models/todomodel/todo_model.dart';
import 'package:listme/models/usermodel/users_model.dart';
import 'package:listme/widgets/show_toastmssg.dart';
import 'package:path_provider/path_provider.dart';

class RemoteServices{
  Box? box;
  final postsModel = PostModel();
  final commentsModel = CommentsModel();
  final usersModel = UserModel();
  final albumModel = AlbumsModel();
  final todoModel = TodoModel();
  final imageModel = ImageModel();
  

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
      var commentResponse = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/comments"));
      await box!.put(2,commentResponse.body);

      final isolate = await Isolate.spawn<List<dynamic>>(postsModel.deserialize,[port.sendPort,response.body]);
      final data = await port.first ;
      await box!.put(0,response.body);
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
      //  await box!.put(2,response.body);
      isolate.kill(priority: Isolate.immediate);
      return [true,data];

    }catch(SocketException){
       var data = box!.get(2);
        return data == null ? [false,false] :[true,commentsModelFromJson(data)];
      // return [false,false];
    }

  }
  
  //post a comment
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
  // function to fetch users data from API
   fetchUsers() async{
    await openBox();
    try{
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
      final isolate = await Isolate.spawn<List<dynamic>>(usersModel.deserializeUser, [port.sendPort,response.body]);
      final data = await port.first;
      await box!.put(1, response.body);
      isolate.kill(priority: Isolate.immediate);
      return data;

    }catch(SocketException){
      var data = box!.get(1);
       return userModelFromJson(data);
    }

  }

  //fetchAlbums
  fetchAlbums() async {
    await openBox();
    try{
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/albums"));
      final isolate = await Isolate.spawn<List<dynamic>>(albumModel.deserializeAlbum, [port.sendPort,response.body]);
      final data = await port.first;
      await box!.put(3, response.body);
      isolate.kill(priority: Isolate.immediate);
      return [true,data];

    }catch(e){
      var data = box!.get(3);
      return data == null ? [false,false] :[true,albumsModelFromJson(data)];
    }
  }
  //fetch albums detail  data
  fetchAlbumsDetail(id) async {
    await openBox();
    try{
      ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/albums/$id/photos"));
      final isolate = await Isolate.spawn<List<dynamic>>(imageModel.deserializeImage, [port.sendPort,response.body]);
      final data = await port.first;
      isolate.kill(priority: Isolate.immediate);
      return data;
    }catch(e){
      null;
    }
  }

  //fetch todos data
  fetchTodos() async {
    await openBox();
    try{
      // ReceivePort port = ReceivePort();
      var response = await client.get(Uri.parse("https://jsonplaceholder.typicode.com/users/1/todos"));
      await box!.put(4, response.body);
       var storedData = box!.get(4);
      return storedData == null ? [false,false] : [true,todoModelFromJson(storedData)];

    }catch(e){
      var data = box!.get(4);
      return data == null ? [false,false] : [true,todoModelFromJson(data)];
    }
  }

//add to todos
  addTodo(string)async{
    await openBox();
    var data = box!.get(4);
    await box!.put(4, data.addAll ({
      "userID": 1,
      "id" : 150,
      "title": string,
      "completed": false
    }));
      await fetchTodos();
  }

  
}