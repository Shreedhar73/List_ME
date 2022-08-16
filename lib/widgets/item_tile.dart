import 'package:flutter/material.dart';

import '../commons/styles.dart';

Widget itemTile(title,body,usedID){
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    decoration: ShapeDecoration(
      color: grey.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text("User ID : "+usedID.toString(),style: jostLight(blue, 11),)
        ),
        const SizedBox(height: 5,),
        Text(title,style: gotu(black, 14,),maxLines: 1,overflow: TextOverflow.ellipsis,),
        Text("  "+body,style: jostRegular(grey, 14),),
        
        
      ],
    ),
  );
}