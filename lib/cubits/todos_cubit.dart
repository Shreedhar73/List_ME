import 'package:bloc/bloc.dart';
import 'package:listme/services/remote_services.dart';

class TodoCubit extends Cubit<dynamic>{
  TodoCubit() : super(null);

  void fetchTodos()async{
    RemoteServices().fetchTodos().then((value){
      emit(value);
    });
  }
}