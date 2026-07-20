import 'package:crud_flutter_todo/views/widgets/EmployeeDoB.dart';
import 'package:crud_flutter_todo/views/widgets/EmployeeDropdownMenu.dart';
import 'package:crud_flutter_todo/views/widgets/EmployeeFormTextField.dart';
import 'package:flutter/material.dart';

class AddDelEmployees extends StatefulWidget{
  const AddDelEmployees({super.key});

  @override
  State<AddDelEmployees> createState() => _AddDelEmployeesState();
  
}

class _AddDelEmployeesState extends State<AddDelEmployees> {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final salaryController = TextEditingController();
  String? selectedGender;
  String? selectedCompany;
  String? selectedDepartment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
        title:  const Text("ADD EMPLOYEE") ,centerTitle: true ,
      
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child:Column(
        children: [
          EmployeeFormTextField(controller: nameController, hint: "Enter name", keyboardType: TextInputType.text,labelText:"Name",),
          SizedBox(height: 20,),
         EmployeeFormTextField(controller: emailController,hint: "Enter Email", keyboardType: TextInputType.emailAddress, labelText: "Email",),
         SizedBox(height: 20,),
         EmployeeFormTextField(controller: phoneController,hint: "Enter Phone", keyboardType: TextInputType.phone, labelText: "Phone",),
        SizedBox(height: 20,),
        
        
        Row(
         children: [
          Expanded(child:
         EmployeeDropdownMenu(label: "Gender", items: ['Male','Female','Other'], onChanged:(value){setState((){selectedGender=value;});}, value:selectedGender),
          ),
          
          Expanded(child: 
          EmployeeDoB()
          )
         ]
         
        ),

      SizedBox(height: 20,),
        Row(
         children: [
          Expanded(child:
         EmployeeDropdownMenu(label: "Company", items: ['Sony','Samsung'], onChanged:(value){setState(() {selectedCompany=value;});} , value: selectedCompany),
          ),
          SizedBox(width: 20,),
          Expanded(child: 
           EmployeeDropdownMenu(label: "Department", items: ['HR','IT','Sales'], onChanged: (value){setState(() {selectedDepartment=value;});}, value: selectedDepartment),
          )
         ]
         
        ), 
        SizedBox(height: 20),
        EmployeeFormTextField(controller: salaryController, hint: "Enter Salary", keyboardType: TextInputType.number, labelText: "Salary"),
        SizedBox(height: 20,),
        ElevatedButton(onPressed: (){print("Submit passed");}, child: Text("Submit")),
        
      ])
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    nameController.dispose();
    super.dispose();
  }
}