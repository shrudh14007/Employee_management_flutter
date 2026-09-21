import 'package:crud_flutter_todo/views/login/login.dart';
import 'package:crud_flutter_todo/views/pages/EmployeesPage.dart';
import 'package:crud_flutter_todo/views/pages/AddDelEmployees.dart';
import 'package:crud_flutter_todo/views/pages/AttendancePage.dart';
// import 'package:crud_flutter_todo/services/database_service.dart';
import 'package:crud_flutter_todo/views/widgets/HeatMap.dart';
import 'package:flutter/material.dart';
// import 'package:crud_flutter_todo/views/login/login.dart';



class Homepage extends StatefulWidget{
  const Homepage({super.key});
@override
State<Homepage> createState()=>_HomePageState();

}





class _HomePageState extends State<Homepage>{
  int pageIndex = 0;
  
  // final List<Widget> pages =[
  //   const AddDelEmployees(),
  //   const AttendancePage(),
  //   const EmployeesPage(),
  // ];


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,  
        
        title: const Text("EMPLOYEE MANAGMENT") , centerTitle: true,

      ),
      body: CustomScrollView(
        slivers: [
            SliverAppBar(
              expandedHeight: 500,
              pinned: true,
              backgroundColor: Colors.lightBlueAccent,
              foregroundColor: Colors.white,
              
              flexibleSpace: const FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(padding: 
                  EdgeInsets.only(left:20,right:20),
                  child: Align(
                    alignment: Alignment.center,
                    child:Text("Welcome User",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),)
                  ),
                    
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child:  Padding(
        padding: EdgeInsets.all(10.0),
        child:Align(
        alignment: Alignment.topLeft,  
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
              Text(
                'DASHBOARD',
                
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold
                  ),
              ),
              SizedBox(height: 20,),
               MyHeatMap(),
              SizedBox(height: 7),

              
              Text(
                'News',
                
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  ),
                 
                
              ),

              Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 247, 255),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5)),

              
              child:Center(
                child:Text(
                  'Announcement'
                )
              )
              ),
              SizedBox(height: 5),

              Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 247, 255),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5)),

              
              child:Center(
                child:Text(
                  'Announcement'
                )
              )
              ),

              SizedBox(height: 7),
              Container(
                width: 400,
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 247, 255),
                  border: Border.all(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5)),

              
              child:Center(
                child:Text(
                  'Announcement'
                )
              )
              ),
        ]
        ),
        ),
      ),
      )
        ],
      
      ),
      
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));
        },
        
        child: const Icon(Icons.add)),
        
    );

    
  }
 


  
}