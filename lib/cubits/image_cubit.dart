import 'package:bloc/bloc.dart';
import 'package:listme/services/remote_services.dart';

class ImageCubit extends Cubit<dynamic>{
  ImageCubit() : super(null);
  getImage(id) async {
    RemoteServices().fetchAlbumsDetail(id).then((value) {
      emit(value);
    });
    
  }
}