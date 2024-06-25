import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    Key? key,
    required this.label,
    this.obscureText = false,
    required this.controller,
    required this.keyboardType,
  }) : super(key: key);

  final String label;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: controller,
      obscuringCharacter: '•',
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white), // Couleur du texte de l'input
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        filled: true,
        fillColor: const Color(0xFF1D1E33), // Fond de l'input
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
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // Couleur du label
        hintText: label,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)), // Couleur du texte indicatif
        alignLabelWithHint: true,
      ),
    );
  }
}
