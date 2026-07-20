import 'package:flutter/material.dart';

class EmployeeSubmitButton extends StatelessWidget {
  const EmployeeSubmitButton({
    super.key,
    required this.label,
    required this.onPressed
    });

    final String label;
    final VoidCallback onPressed;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}