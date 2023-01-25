// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_scale/provider/CounterProvider.dart';
import 'package:flutter_scale/routers.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var userStep;
var initRoute;

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userStep = sharedPreferences.getInt('userStep');

  if(userStep == 1){
    initRoute = '/login';
  }else if(userStep == 2){
    initRoute = '/dashboard';
  }else{
    initRoute = '/welcome';
  }

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => CounterProvider()
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        initialRoute: initRoute,
        routes: routes,
      ),
    );
  }
}