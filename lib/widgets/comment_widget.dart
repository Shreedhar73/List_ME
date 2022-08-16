import 'package:flutter/material.dart';

import '../services/remote_services.dart';

commentPopUpWidget(id,BuildContext context){
  return showModalBottomSheet(
    context: context, 
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    builder: ((ctx,)=>

    CommentWidget(id:id)
   
    )    
 );
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({ Key? key, this.id }) : super(key: key);
  final int? id;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  final rm = RemoteServices();
  @override
  void initState() {
    rm.fetchComments(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.7,
      decoration:  ShapeDecoration(
        color: Colors.amber.shade100,
        shape:  const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ),
      
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      child: FutureBuilder(
        future: rm.fetchComments(widget.id),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var comments = snapshot.data as List;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (ctx,index)=>
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                title: Text(comments[index].name),
                subtitle: Text(comments[index].body),
              ),
            );
            
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      
    );
  }
}