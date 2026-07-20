import 'package:crud_flutter_todo/views/home/home_page.dart';
import 'package:crud_flutter_todo/views/pages/AddDelEmployees.dart';
import 'package:crud_flutter_todo/views/pages/AttendancePage.dart';
import 'package:crud_flutter_todo/views/pages/EmployeesPage.dart';
import 'package:flutter/material.dart';


class BottomNavigationPage extends StatefulWidget{
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {

  int myCurrentIndex = 0;
  List<Widget> pages = [
  const Homepage(),
  const EmployeesPage(),
  const AddDelEmployees(),
  const AttendancePage(),
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 25),  
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 30,
              offset: Offset(0, 20),

            )
          ]
        ),


        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: BottomNavigationBar(
            currentIndex: myCurrentIndex,
            backgroundColor: Colors.white,
            selectedItemColor: const Color.fromARGB(255, 19, 30, 237),
            unselectedItemColor: Colors.black,
            selectedFontSize: 12,
            showSelectedLabels: true,
            showUnselectedLabels: false,
          
            
            onTap:(index){
              setState(() {
                myCurrentIndex= index;
              });
            },
            
            items : const[
            BottomNavigationBarItem(icon:Icon(Icons.home_outlined),label:'Home'),
            BottomNavigationBarItem(icon:Icon(Icons.people),label:'Employees'),
            BottomNavigationBarItem(icon:Icon(Icons.person_add),label:'Add Employee'),
            BottomNavigationBarItem(icon:Icon(Icons.edit_calendar),label:'Attendance')
          
          ]),
        ),
      ),
      body: pages[myCurrentIndex]);
  }
}