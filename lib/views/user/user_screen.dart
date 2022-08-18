import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:listme/commons/cached_network_image.dart';
import 'package:listme/cubits/users_cubit.dart';
import 'package:listme/views/user/user_detail.dart';

import '../../commons/styles.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({ Key? key }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserCubit userCubit = UserCubit();
  @override
  void initState() {
    userCubit.getUsers();
    super.initState();
  }

  @override
  void dispose() {
    userCubit.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  LiquidPullToRefresh(
      onRefresh: userCubit.handleRefresh,
      backgroundColor: white,
      color: black.withOpacity(0.5),
      showChildOpacityTransition: false,
      child: StreamBuilder(
        stream: userCubit.stream,
        builder: (context,snapshot){
          if(snapshot.hasData){
            List users = snapshot.data as List;
            return ListView.builder(
              itemCount: users.length,
              padding: EdgeInsets.zero,
              itemBuilder: (contetx,index){
                final user = users[index];
                return userTile(user);
              },
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

  Widget userTile(data){
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> UserDetail(data: data,)));
      },
      child: Container(
        height: MediaQuery.of(context).size.height*0.1,
        padding: const EdgeInsets.only(top: 20,left: 20),
        decoration: ShapeDecoration(
          color: grey.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
            borderRadius: BorderRadius.circular(50),
              child: const CachedNetworkimage(
              imageUrl: "x",
              height: 60,
              width: 60,
                      ),
            ),
            const SizedBox(width: 10,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.7,
                  // height: MediaQuery.of(context).size.height*0.2,
                  child: Text(data.name ?? '',style: gotu(black, 15),maxLines: 1,overflow: TextOverflow.ellipsis,)),
                Text(data.email ?? '',style: gotu(black87, 14),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}