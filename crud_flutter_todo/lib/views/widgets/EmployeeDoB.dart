import 'package:flutter/material.dart';


class EmployeeDoB extends StatefulWidget {
  const EmployeeDoB({
    super.key,

    });

  @override
  State<EmployeeDoB> createState() => _EmployeeDoBState();
}
 


class _EmployeeDoBState extends State<EmployeeDoB> {
   TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Padding(
        
        padding: EdgeInsetsGeometry.all(0),
        child: TextField(
          controller: _dateController,
          decoration: InputDecoration(
            labelText: 'Date Of Birth',
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(Icons.calendar_today),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.grey),

            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: Colors.lightBlue),

            )
          ),
          readOnly: true,
          onTap: (){
            _selectDate();
          },
        ),
      
    );
    
  }

  Future<void> _selectDate() async{
   DateTime? _picked = await showDatePicker(
     context:context ,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),

    builder: (context, child) {
      return Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.lightBlue, // Header & selected date
            onPrimary: Colors.white,   // Header text
            surface: Colors.white,     // Calendar background
            onSurface: Colors.black,   // Calendar text
          ),
        ),
        child: child!,
      );
    },
    );

  if(_picked != null){
    setState(() {
      _dateController.text = _picked.toString().split(" ")[0];
    });
  }

  }

}