import 'package:flutter/material.dart';
import 'package:listme/commons/styles.dart';
import 'package:listme/views/posts/posts_screen.dart';

import '../../widgets/bottomnav_widget.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({ Key? key,this.userID }) : super(key: key);
  final userID;

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black,
        title: Text("User Posts",style: gotu(white, 15),),
        centerTitle: true,
      ),
      body : PostScreen(userID: widget.userID,),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}