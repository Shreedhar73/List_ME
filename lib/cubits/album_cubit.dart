import 'package:bloc/bloc.dart';

import '../services/remote_services.dart';

class AlbumCubit extends Cubit<dynamic>{
  AlbumCubit(): super(null);

  void getAlbums() async {
    RemoteServices().fetchAlbums().then((value) {
      emit(value);
    });
  }
}