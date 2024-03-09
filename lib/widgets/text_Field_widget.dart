import 'package:flutter/material.dart';
class TextfieldInput extends StatelessWidget {
  const TextfieldInput({
    super.key,
    required this.hintText,
    required this.isPass,
    required this.inputType,
    required this.textEditingController
  });
  final bool isPass;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {

    final inputBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 3.0, color: Colors.black), // Set border width and color
      borderRadius: BorderRadius.circular(10.0), // Set border radius
    );
    return Container(
      child: TextField(
        controller: textEditingController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12), // Adjust padding here
            hintText: hintText,
            border: inputBorder,
            focusedBorder: inputBorder,
            enabledBorder: inputBorder
          ),
        keyboardType: inputType,
        obscureText: isPass,
      ),
    );
  }
}