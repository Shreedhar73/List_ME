import 'package:flutter/material.dart';
import 'package:listme/commons/styles.dart';
import 'package:listme/widgets/comment_widget.dart';
import 'package:listme/widgets/item_tile.dart';

import '../../services/remote_services.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({ Key? key,this.userID }) : super(key: key);
  final userID;

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> with TickerProviderStateMixin{
  var bannerVisible = true;
  //Animation Start
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0,-1),
    end: const Offset(0,0),
  ).animate(
    CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
  ));

  void repeatOnce() async {
    await _controller.forward();
    await _controller.reverse();
  }
  //Animation End
  final rm = RemoteServices();

  @override
  void initState() {
    widget.userID == null 
    ? rm.fetchPosts() 
    : rm.fetchPostsID(widget.userID) ;
    repeatOnce();
    super.initState();
  }
  @override
  void dispose() {

    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.userID == null ? rm.fetchPosts() : rm.fetchPostsID(widget.userID),
      builder: (context,snapshot){
        if(snapshot.hasData){
          List posts = snapshot.data as List;
          return Stack(
            children: [
              ListView.separated(
                itemCount: posts.length,
                padding: const EdgeInsets.all(15),
                separatorBuilder: (ctx,idx)=> const SizedBox(height: 15),
                itemBuilder: (context,index){
                  final post = posts[index];
                  return InkWell(
                    onTap: (){
                      commentPopUpWidget(post.id,context);
                    },
                    child: itemTile(post.title, post.body, post.userId)
                  );
                },
              ),
              bannerVisible
              ?SlideTransition(
                position: _offsetAnimation,
                child: topBanner(),
              )
              :const SizedBox(),
            ],
          );

        }else{
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  topBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: black.withOpacity(0.6),
          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        ),
        child: ListTile(
          title: Text(
            'Tap Individual Items Cards.',
            textAlign: TextAlign.left,
            style: jostMedium(white, 13.0)
          ),
          subtitle: Text(
            'To See the Comments.',
            textAlign: TextAlign.left,
            style: jostLight(white, 13.0)
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.arrow_forward,
              color: Colors.white
            ),
            onPressed: () { 
              setState(() {
                bannerVisible = false;
              });
            },
          ),
        ),
      ),
    );
  }

}