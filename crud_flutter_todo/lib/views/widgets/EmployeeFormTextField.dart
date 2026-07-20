import 'package:flutter/material.dart';
import 'package:material_text_fields/material_text_fields.dart';
import 'package:material_text_fields/theme/material_text_field_theme.dart';

class EmployeeFormTextField extends StatelessWidget {
  const EmployeeFormTextField({
    super.key,
   required this.controller,
   required this.hint,
   required this.keyboardType,
   required this.labelText,
    });

final TextEditingController controller;
final String hint;
final TextInputType keyboardType;
final String labelText;
// final TextInputAction textInputAction;
// final bool obscureText;
// final String? Function(String?)? validator;
  @override

  Widget build(BuildContext context) {
    return MaterialTextField(
      controller: controller,
      hint: hint,
      keyboardType: keyboardType,
      labelText: labelText,

      theme: FilledOrOutlinedTextTheme(
  radius: 8,
  contentPadding: const EdgeInsets.symmetric(
    horizontal: 4,
    vertical: 4,
  ),
  errorStyle: const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
  ),
  fillColor: Colors.transparent,
  prefixIconColor: Colors.blue,
  enabledColor: Colors.grey,
  focusedColor: Colors.blue,
  floatingLabelStyle: const TextStyle(
    color: Colors.blue,
  ),
  width: 1.5,
  labelStyle: const TextStyle(
    fontSize: 16,
    color: Colors.black,
  ),
),
  
    );
}
}