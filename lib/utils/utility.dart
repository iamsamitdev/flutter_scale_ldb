// ignore_for_file: prefer_conditional_assignment, prefer_const_constructors

import 'package:flutter/material.dart';

class Utility {

  static Utility? utility;

  static Utility? getInstance(){
    if(utility == null){
      utility = Utility();
    }
    return utility;
  }

  // สร้างฟังก์ชันสำหรับการแสดงผล Alert
  showAlertDialog(BuildContext context, String alertTitle, String alertContent){
    AlertDialog alert = AlertDialog(
      title: Text(alertTitle),
      content: Text(alertContent),
      actions: [
        TextButton(
          onPressed: (() => Navigator.pop(context)), 
          child: Text('OK')
        )
      ],
    );

    showDialog(
      context: context, 
      builder: (context) => alert
    );
  }

}