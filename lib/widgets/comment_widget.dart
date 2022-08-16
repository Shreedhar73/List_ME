
import 'package:flutter/material.dart';
import 'package:listme/commons/check_internet.dart';
import 'package:listme/commons/styles.dart';
import 'package:listme/widgets/show_toastmssg.dart';

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
  var status = false;
  var commentText = TextEditingController();
  @override
  void initState() {
    rm.fetchComments(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height*0.8,
        decoration: ShapeDecoration(
          color: grey.withOpacity(0.5),
          shape:  const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
        ),
        
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            Text(
              'Comments',
              style: gotuRegular,
            ),
            Expanded(
              child: FutureBuilder(
                future: rm.fetchComments(widget.id),
                builder: (context,snapshot){
                  if(snapshot.hasData){
                    var comments = snapshot.data as List;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height*0.65,
                          child: ListView.builder(
                            // shrinkWrap: true,
                            itemCount: comments.length,
                            itemBuilder: (ctx,index)=>
                            ListTile(
                              style: ListTileStyle.list,
                              minLeadingWidth: 2,
                              minVerticalPadding: 5.0,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                              title: Text(comments[index].email,maxLines: 1,style: gotu(black,15),),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(left:15,top: 10),
                                child: Text(comments[index].body?? '',style: jostMedium(black, 14),)),
                            ),
                          ),
                        ),
                        commentBox()
                       
                      ]
                    );
                    
                  }else{
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ),
          ],
        ),
        
      ),
    );
  }

  Widget commentBox(){
    return SizedBox(
      // height: kToolbarHeight,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.8,
            child: TextFormField(
              controller: commentText,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.only(left: 10,right: 5,top: 10,bottom:10),
                filled: true,
                fillColor: white,
                hintText: 'Make a Comment',
                hintStyle: gotu(black,11),
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: transparent,
                    width: 1.0
                  )
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: grey,
                    width: 1.0
                  )
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: const BorderSide(
                    color: grey,
                    width: 1.0
                  )
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )
            ),
            )
          ),
          Expanded(
            child: IconButton(onPressed: () async{
              // rm.postComment(widget.id);
              
              await checkInternetConnection().then((bool x){
                setState(() {
                  status = x;
                });
              });
              commentText.text != ''
                 ? status ? rm.postComment(widget.id,commentText.text) 
                        : showToastMessage('No Internet Connection')
                  : showToastMessage('Please Enter Comment');
              },
              icon: const Icon(Icons.send,color: blue,),
            ),
          )
        ],
      ),
    );
  }
}