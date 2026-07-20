import 'package:crud_flutter_todo/user.dart';
import 'package:flutter/material.dart';

class Employeelistview extends StatelessWidget {
  const Employeelistview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.lightBlueAccent,
         foregroundColor: Colors.white,

        title: const Text('EMPLOYEE LIST'),centerTitle: true,),
      body: ListView.separated(
        
      itemBuilder: (BuildContext context,int index){
        return ListTile(
          title: Text(users[index].name),
          subtitle: Text(users[index].profession),
        );
      }, 
      separatorBuilder:(BuildContext context,int index){
        return const Divider(height: 1);
      } ,
       itemCount: users.length),
      );
  }
}