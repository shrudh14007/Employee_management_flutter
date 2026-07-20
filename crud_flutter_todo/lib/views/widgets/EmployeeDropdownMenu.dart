import 'package:flutter/material.dart';



class EmployeeDropdownMenu extends StatelessWidget {
  const EmployeeDropdownMenu({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    required this.value

    });

  final String label;
  final List<String>items;
  final ValueChanged<String?>onChanged;
  final String? value;


  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      label: Text(label),
      inputDecorationTheme:  InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8), 
      ),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      contentPadding: const EdgeInsets.symmetric(
    horizontal: 12,
    vertical: 14,
  ),
    ),
    

      initialSelection: value,
      onSelected: onChanged,
      dropdownMenuEntries: items.map((item)=> DropdownMenuEntry(value: item, label: item)).toList(),
      
      
      );
  }
}

