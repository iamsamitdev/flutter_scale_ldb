// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/themes/colors.dart';

class HeadingText extends Text {
  HeadingText(
    String data,
    {required TextStyle style}
  ):super(
    data,
    style: style.merge(
      TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: primary_text)
    )
  );
}