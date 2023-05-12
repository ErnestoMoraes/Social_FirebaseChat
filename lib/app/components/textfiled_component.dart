import 'package:flutter/material.dart';

class TextfiledComponent extends StatelessWidget {
  final TextEditingController controllerEC;
  final String hitnText;
  final bool obscureText;

  const TextfiledComponent({
    super.key,
    required this.hitnText,
    required this.obscureText,
    required this.controllerEC,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controllerEC,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hitnText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyle(
          color: Colors.grey[700]!,
          fontWeight: FontWeight.w500
        ),
      ),
    );
  }
}
