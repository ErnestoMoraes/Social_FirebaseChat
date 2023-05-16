import 'package:flutter/material.dart';

class TextfiledComponent extends StatelessWidget {
  final TextEditingController controllerEC;
  final String hitnText;
  final bool obscureText;
  final Color? color;

  const TextfiledComponent({
    super.key,
    required this.hitnText,
    required this.obscureText,
    required this.controllerEC,
    this.color = Colors.black,
  });
  const TextfiledComponent.input({
    super.key,
    required this.hitnText,
    required this.obscureText,
    required this.controllerEC,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: color == Colors.black ? Colors.white : Colors.black,
        fontSize: 18,
      ),
      controller: controllerEC,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hitnText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        fillColor: color == Colors.black ? Colors.black : Colors.white,
        filled: true,
        hintStyle: TextStyle(
          color: color == Colors.black ? Colors.white : Colors.black,
          fontSize: 18,
        ),
      ),
    );
  }
}
