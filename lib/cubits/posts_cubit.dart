import 'package:bloc/bloc.dart';
import 'package:listme/services/remote_services.dart';

class PostCubit extends Cubit<dynamic> {
  PostCubit() : super(null);

  void getPosts() async {
    RemoteServices().fetchPosts().then((value) {
      emit(value);
    });
  }

  void getPostsID(id) async {
    RemoteServices().fetchPostsID(id).then((value) {
      emit(value);
    });
  }
}