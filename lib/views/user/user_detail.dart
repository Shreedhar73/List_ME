// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:listme/commons/styles.dart';
import 'package:listme/views/user/user_albums_screen.dart';
import 'package:listme/views/user/user_post_screen.dart';
import 'package:listme/widgets/bottomnav_widget.dart';

import '../../commons/cached_network_image.dart';

class UserDetail extends StatefulWidget {
  const UserDetail({ Key? key, this.data}) : super(key: key);
  final data;

  @override
  State<UserDetail> createState() => _UserDetailState();
}

class _UserDetailState extends State<UserDetail> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var data = widget.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("User Detail",style: gotuRegular,),
        centerTitle: true,
      ),
      bottomNavigationBar: const BottomNavigation(xCurrentIndex: 1,),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(width*0.3),
                  child:  const CachedNetworkimage(
                    imageUrl: ".png",
                    height: 80,
                    width: 80,
                    
                    ),
                ),
              ),
              const SizedBox(height: 20,),
              dataTile("Name",data.name ),
              const SizedBox(height: 20,),
              dataTile("Email",data.email ),
              const SizedBox(height: 20,),
              dataTile("Address",data.address.street ?? ""  ),
              const SizedBox(height: 20,),
              dataTile("Phone",data.phone ),
              const SizedBox(height: 20,),
              dataTile("Website",data.website ),
              const SizedBox(height: 20,),
              albumPostsTile(),


            
            ],
          ),
        ),
      )
    );
  }

  Widget titleField(title){
    return Text(title ?? '',style: gotu(black,17),);
  }
  Widget subtitleField(subtitle){
    return Text(subtitle ?? '',style: jostRegular(grey, 14));
  }

  Widget dataTile(title,subtitle){
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: ShapeDecoration(
        color: grey.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleField(title),
          subtitleField(subtitle),
        ],
      ));
    
  }

  Widget albumPostsTile(){
    return SizedBox(
      height: kToolbarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  AlbumsListScreen(userId: widget.data.id,)));
            },
            child: SizedBox(
              width: 100,
              child: Card(
                child: Center(child: Text("Albums",style: gotuRegular,)),
              ),
            ),
          ),
          const SizedBox(width: 20,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  UserPosts(userID: widget.data.id,))); 
            },
            child: SizedBox(
              width: 100,
              child: Card(
                child: Center(child: Text("Posts",style: gotuRegular,)),
              ),
            ),
          ),

        ],
      ),
    );

  }
}