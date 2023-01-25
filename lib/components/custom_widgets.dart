// ignore_for_file: void_checks, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';

// Input Widget
Widget inputFieldWidget(
  BuildContext context,
  Icon icon,
  String hintText,
  String labelText,
  Function onValidate,
  Function onSave,
  {
    String initialValue = '',
    bool autoFocus = false,
    bool obsecureText = false,
    // int maxlenght = 30,
    var keyboardType = TextInputType.text,
    // var maxLines,
  }
){
  return TextFormField(
    autofocus: autoFocus,
    initialValue: initialValue,
    obscureText: obsecureText,
    validator: (value){
      return onValidate(value);
    },
    onSaved: (value){
      return onSave(value.toString().trim());
    },
    keyboardType: keyboardType,
    // maxLines: maxLines,
    // maxLength: maxlenght,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: secondary_text, fontSize: 14),
      contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
      errorStyle: TextStyle(fontSize: 16, color: accent),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 2, color: primary),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 1, color: primary),
      ),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 10.0, right: 10.0),
        child: IconTheme(
          data: IconThemeData(
            color: primary
          ), 
          child: icon
        ),
      )
    ),
  );
}