import 'package:crud_flutter_todo/views/widgets/EmployeeListView.dart';
import 'package:flutter/material.dart';

  class EmployeesPage extends StatelessWidget{
    const EmployeesPage({super.key});
    
    @override
    Widget build(BuildContext context) {
      return Center(
        // child: Text(

        //   "Page Number 1",
        //   style: TextStyle(
        //     color: Colors.blue,
        //     fontSize: 45
        //   ),
        // ),
        child: Employeelistview(),

        
      );
    }
  }