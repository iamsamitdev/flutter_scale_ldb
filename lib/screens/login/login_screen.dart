// ignore_for_file: prefer_const_constructors, sort_child_properties_last, use_build_context_synchronously

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scale/components/custom_widgets.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:flutter_scale/utils/utility.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // สร้างตัวแปร key ไว้ผูกกับฟอร์ม
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้รับ input จากฟอร์ม
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 150,),
                  Image.asset('assets/images/intro1.png', width: 150,),
                  SizedBox(height: 30.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: inputFieldWidget(
                      context, 
                      Icon(Icons.person_outline), 
                      "Username", 
                      "Username", 
                      (onValidateVal){
                        if(onValidateVal!.isEmpty){
                          return 'ต้องป้อนชื่อผู้ใช้ก่อน';
                        }else{
                          return null;
                        }
                      }, 
                      (onSaveVal){
                        _username = onSaveVal;
                      },
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: inputFieldWidget(
                      context, 
                      Icon(Icons.lock_outline), 
                      "Password", 
                      "Password", 
                      (onValidateVal){
                        if(onValidateVal!.isEmpty){
                          return 'ต้องป้อนรหัสผ่านก่อน';
                        }else{
                          return null;
                        }
                      }, 
                      (onSaveVal){
                        _password = onSaveVal;
                      },
                      obsecureText: true,
                    ),
                  ),
                  SizedBox(height: 20.0,),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        // เช็คว่าป้อนค่าในฟอร์มครบหรือยัง
                        // กรณี validate ผ่านแล้ว
                        if(formKey.currentState!.validate()){
                          formKey.currentState!.save();
                          // print(_username+_password);
                          // print("ป้อนข้อมูลครบแล้ว");

                          // เช็คสถานะการเชื่อมต่อ  Network
                          var checkNetwork = await Connectivity().checkConnectivity();

                          if(checkNetwork == ConnectivityResult.none){
                            // ถ้าไม่ได้เชื่อมต่อ
                            Utility.getInstance()!.showAlertDialog(
                              context, 
                              'มีข้อผิดพลาด', 
                              'อุปกรณ์ของท่านไม่ได้เชื่อมต่อ Internet'
                            );
                          }else{
                            // เรียกฟังก์ชัน loginAPI()
                            var response = await CallAPI().loginAPI(
                              {
                                "username":_username,
                                "password":_password
                              }
                            );

                            var body = json.decode(response.body);

                            if(body['status']=='success'){
                              // บันทึกข้อมูลผู้ใช้ลงในแอพ (local storage)
                              // สร้าง object ของ SharedPreferences
                              SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

                              // เก็บค่าที่ต้องการลงตัวแปรแบบ SharedPreferences
                              sharedPreferences.setInt('userStep', 2);
                              sharedPreferences.setString('userID', body['data']['id']);
                              sharedPreferences.setString('userName', body['data']['username']);
                              sharedPreferences.setString('fullName', body['data']['fullname']);
                              sharedPreferences.setString('imgProfile', body['data']['img_profile']);
                              sharedPreferences.setString('userStatus', body['data']['status']);

                              // ส่งไปหน้า Dashboard
                              Navigator.pushReplacementNamed(context, '/dashboard');
                            }else{
                              Utility.getInstance()!.showAlertDialog(
                                context, 
                                'มีข้อผิดพลาด', 
                                'ไม่พบข้อมูลผู้ใช้นี้ในระบบ'
                              );
                            }
                          }


                        }else{
                          Utility.getInstance()!.showAlertDialog(
                            context, 
                            'มีข้อผิดพลาด', 
                            'ป้อนข้อมูลไม่ครบถ้วน'
                          );
                        }
                      },
                      child: Text(
                        "Login", 
                        style: TextStyle(fontSize: 20),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(15.0),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}