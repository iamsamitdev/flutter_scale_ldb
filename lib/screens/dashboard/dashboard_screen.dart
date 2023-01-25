// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter_scale/screens/bottomnavmenu/home_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/notification_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/profile_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/report_screen.dart';
import 'package:flutter_scale/screens/bottomnavmenu/setting_screen.dart';
import 'package:flutter_scale/themes/colors.dart';
import 'package:flutter_scale/utils/constant.dart';
import 'package:flutter_scale/utils/string.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  // สร้างตัวแปรเก็บลำดับที่ของ tab
  int _currentIndex = 0;
  String _title = CustomStrings.appName;

  // สร้างตัวแปรแบบ List เก็บหน้า Screen ของ BottomNavigation
  final List<Widget> _children = [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  // ฟังก์ชันสำหรับสลับ Tab
  void onTabChange(int index){
    setState(() {
      _currentIndex = index;
      switch (index) {
        case 0: _title = CustomStrings.bottom_menu_home_text; break;
        case 1: _title = CustomStrings.bottom_menu_report_text; break;
        case 2: _title = CustomStrings.bottom_menu_notification_text; break;
        case 3: _title = CustomStrings.bottom_menu_setting_text; break;
        case 4: _title = CustomStrings.bottom_menu_profile_text; break;
      }
    });
  }

  // สร้างฟังก์ชันสำหรับอ่านข้อมูล profile จาก Shared Preferences
  String? _fullname, _username, _avatar, _userstatus;

  readUserProfile() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      _fullname = sharedPreferences.getString('fullName');
      _username = sharedPreferences.getString('userName');
      _avatar = sharedPreferences.getString('imgProfile');
      _userstatus = sharedPreferences.getString('userStatus');
    });
  }

  // เรียกใช้งานตอนเริ่มต้นโหลดหน้าแอพ
  @override
  void initState() {
    readUserProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: _children[_currentIndex],
      drawer: Drawer(
        backgroundColor: icons,
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_fullname ?? "..."), 
              accountEmail: Text(_username ?? "..."),
              currentAccountPicture: _avatar != null ? CircleAvatar(
                radius: 60.0,
                backgroundColor: primary_dark,
                backgroundImage: NetworkImage('${baseImageURL}profile/${_avatar}'),
              ) : CircularProgressIndicator(),
            ),
            ListTile(
              leading: Icon(Icons.person_outline),
              title: Text(CustomStrings.drawer_menu_about_text),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pushNamed(context, '/about');
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outlined),
              title: Text(CustomStrings.drawer_menu_info_text),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pushNamed(context, '/info');
              },
            ),
            ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text(CustomStrings.drawer_menu_contact_text),
              trailing: Icon(Icons.chevron_right),
              onTap: (){
                Navigator.pushNamed(context, '/contact');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text(CustomStrings.drawer_menu_logout_text),
              trailing: Icon(Icons.chevron_right),
              onTap: () async {
                // Clear ข้อมูล User Storage
                SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                // sharedPreferences.clear(); // ลบทั้งหมด
                sharedPreferences.setInt('userStep', 1);
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        )
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabChange,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: CustomStrings.bottom_menu_home_text
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart_outlined),
            label: CustomStrings.bottom_menu_report_text
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            label: CustomStrings.bottom_menu_notification_text
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: CustomStrings.bottom_menu_setting_text
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: CustomStrings.bottom_menu_profile_text
          ),
        ]
      ),
    );
  }
}