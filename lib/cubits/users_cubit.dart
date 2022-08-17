import 'package:bloc/bloc.dart';
import 'package:listme/services/remote_services.dart';

class UserCubit extends Cubit<dynamic> {
  UserCubit() : super(null);

  void getUsers() async {
    RemoteServices().fetchUsers().then((value) {
      emit(value);
    });
  }
}