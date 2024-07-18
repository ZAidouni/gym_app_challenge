import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  // Add `validator` parameter to support form validation
  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final FormFieldValidator<String>? validator;

  CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    required this.keyboardType,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white), // Input text color
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: const Color(0xFF1D1E33), // Input background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // Label color
        hintText: label,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // Hint text color
        alignLabelWithHint: true,
      ),
      validator: validator, // Add validator to TextFormField
    );
  }
}
