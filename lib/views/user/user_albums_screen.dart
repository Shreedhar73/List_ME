// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:listme/cubits/album_cubit.dart';

import '../../commons/styles.dart';
import '../../widgets/bottomnav_widget.dart';

class AlbumsListScreen extends StatefulWidget {
  const AlbumsListScreen({ Key? key ,this.userId}) : super(key: key);
  final userId;

  @override
  State<AlbumsListScreen> createState() => _AlbumsListScreenState();
}

class _AlbumsListScreenState extends State<AlbumsListScreen> {
  AlbumCubit albumCubit = AlbumCubit();
   @override
  void initState() {
    albumCubit.getAlbums();
    super.initState();
  }
  @override
  void dispose() {
    albumCubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Text("User Albums",style: gotu(white, 15),),
        centerTitle: true,
      ),
      // body : PostScreen(userID: widget.userID,),
      bottomNavigationBar: const BottomNavigation(xCurrentIndex: 1,),
      body: StreamBuilder(
        stream: albumCubit.stream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            var albums = snapshot.data as List;
            var albumsList = [];
            if(albums[0]){albums[1].forEach((album){
              if(album.userId == widget.userId){
                albumsList.add(album);
              }
            });}
            return !albums[0] 
              ? Center(child: Text("No Data, connect to internet",style: gotuRegular,))
              : ListView.builder(
                itemCount: albumsList.length,
                itemBuilder: (ctx,idx) {
                  var album = albumsList[idx];
                   return ListTile(
                    title: Text(album.title,style: gotu(black,14),),
                );}
              );


          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
      
    );
  }
}