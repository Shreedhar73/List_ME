import 'package:flutter/material.dart';
import 'package:listme/commons/styles.dart';

import '../../cubits/todos_cubit.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({ Key? key }) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final todoCubit = TodoCubit();
  final txtCon = TextEditingController();
  @override
  void initState() {
    todoCubit.fetchTodos();
    super.initState();
  }
  @override
  void dispose() {
    todoCubit.close();
    txtCon.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder ( 
      stream: todoCubit.stream,
      builder: (context,snapshot){
        if(snapshot.hasData){
          var data = snapshot.data as List;
          return data[0] ? ListView.builder(
            itemCount: data[1].length,
            itemBuilder: (context,index){
              var todo = data[1][index];
              return todoTile(todo);
            },
          )
          : Center(
            child : Text("No Data",style: gotuRegular)
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
   
  }
   Widget todoTile(todo){
      return InkWell(
        onTap: (){
         showModalBottomSheet(
          context: context,
          isScrollControlled: false, 
          builder: (context){
            return Container(
              height: MediaQuery.of(context).size.height*0.5,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: Text("Edit",style: gotuRegular,),),
                  TextFormField(
                    controller: txtCon,
                  ),
                  Center(
                    child: IconButton(
                      onPressed: () async{
                        // RemoteServices().addTodo(txtCon.text);
                    }, 
                    icon: const Icon(Icons.add_box)),
                  )
                ],
              ),
            );
          } 
          );
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: black.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(todo.id.toString()),
              Text(todo.title),
              Text(todo.completed ? "Completed" : "Pending"),
            ],
          ),
        ),
      );
    }
}