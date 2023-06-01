import 'package:flutter/material.dart';

Widget getMyTextField(
    {required TextEditingController controller,
    obscureText = false,
    icon,
    hintText = ''}) {
  return TextField(
    obscureText: obscureText,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: icon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
    ),
  );
}
