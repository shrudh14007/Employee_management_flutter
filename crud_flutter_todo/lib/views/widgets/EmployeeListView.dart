// import 'package:crud_flutter_todo/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crud_flutter_todo/providers/user_provider.dart';

class Employeelistview extends ConsumerWidget {
  const Employeelistview({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final userList = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.lightBlueAccent,
         foregroundColor: Colors.white,

        title: const Text('EMPLOYEE LIST'),centerTitle: true,),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          ref.read(usersProvider.notifier).addUser('Alice','Designer');
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        
      itemBuilder: (BuildContext context,int index){
        return ListTile(
          title: Text(userList[index].name),
          subtitle: Text(userList[index].profession),
        );
      }, 
      separatorBuilder:(BuildContext context,int index){
        return const Divider(height: 1);
      } ,
       itemCount: userList.length),
      );
  }
}