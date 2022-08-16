import 'package:flutter/material.dart';
import 'package:listme/widgets/comment_widget.dart';

import '../../services/remote_services.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({ Key? key }) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final rm = RemoteServices();
  @override
  void initState() {
    rm.fetchPosts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rm.fetchPosts(),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List posts = snapshot.data as List;
          return ListView.separated(
            itemCount: posts.length,
            separatorBuilder: (ctx,index)=>  Divider(thickness: 2,height: 20,color: Colors.amber.shade100,),
            itemBuilder: (context,index){
              final post = posts[index];
              return InkWell(
                onTap: (){
                  commentPopUpWidget(post.id,context);
                  
                },
                child: ListTile(
                  // hoverColor: Colors.red,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              );
            },
          );

        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }
}