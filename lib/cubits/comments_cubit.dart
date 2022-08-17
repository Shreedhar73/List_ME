
import 'package:bloc/bloc.dart';

import '../services/remote_services.dart';

class CommentsCubit extends Cubit<dynamic> {
  CommentsCubit() : super(null);

  void getComments(id) async {
    RemoteServices().fetchComments(id).then((value) {
      emit(value);
    });
  }

 
}