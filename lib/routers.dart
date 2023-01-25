// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_scale/screens/drawermenu/about_screen.dart';
import 'package:flutter_scale/screens/drawermenu/contact_screen.dart';
import 'package:flutter_scale/screens/drawermenu/info_screen.dart';
import 'package:flutter_scale/screens/login/login_screen.dart';
import 'package:flutter_scale/screens/newsdetail/newsdetail_screen.dart';
import 'package:flutter_scale/screens/welcome/welcome_screen.dart';

// สร้างตัวแปรกำหนด URL ของแต่ละหน้า
Map<String, WidgetBuilder> routes = {
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/about": (BuildContext context) => AboutScreen(),
  "/info": (BuildContext context) => InfoScreen(),
  "/contact": (BuildContext context) => ContactScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/newsdetail": (BuildContext context) => NewsDetailScreen(),
};