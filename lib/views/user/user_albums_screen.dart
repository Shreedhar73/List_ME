// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:listme/cubits/album_cubit.dart';
import 'package:listme/views/user/user_image_list.dart';

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
              : GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20
                ),
                
                itemCount: albumsList.length,
                itemBuilder: (ctx,idx) {
                  var album = albumsList[idx];
                  return albumTile(album);
                }
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
  Widget albumTile(album){
    return InkWell(
      onTap :(){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ImageListScreen(data: album,)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.2,
        width: MediaQuery.of(context).size.width*0.3,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: ShapeDecoration(
          color: black.withOpacity(0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(album.id.toString(),style: gotu(tappedColor, 20),),
            const SizedBox(height: 10),
            Text(album.title,style: gotu(black, 15),maxLines: 2,overflow: TextOverflow.ellipsis,),
          ],
        ),
      
      ),
    );
  }
}