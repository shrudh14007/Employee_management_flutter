import 'package:crud_flutter_todo/views/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child:const MyApp()));
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  
  Widget build(BuildContext context){
    return MaterialApp(
      title:'Flutter Demo',
      
      
      
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,



        ),
        useMaterial3: true,

      ),
      
      home: Login(),
    );
  }
}
