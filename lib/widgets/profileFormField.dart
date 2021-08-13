import 'package:flutter/material.dart';

class ProfileFormField extends StatelessWidget {
  final String hintText;

  final textEditingController;

  final TextInputType textInputType;


  ProfileFormField({
    required this.hintText,

    required this.textInputType,
    this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xFFF7F7F7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Color(0xFFF7F7F7)),
          ),
          fillColor: Color(0xfff7f7f7),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Color(0xffbababa),
          ),
        ),
        keyboardType: TextInputType.text,
      ),
    );
  }
}
