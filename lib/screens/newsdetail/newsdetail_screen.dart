// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_scale/models/NewsDetailModel.dart';
import 'package:flutter_scale/services/rest_api.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {

  // เรียกใช้งาน NewsDetailModel
  NewsDetailModel? _dataNews;

  // สร้างฟังก์ชันอ่านรายละเอียดข่าวตาม id
  readNewsDetail(id) async {
    // Call API
    try {
      var response = await CallAPI().getNewsDetail(id);
      setState(() {
        _dataNews = response;
      });
    }catch(error){
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    // รับค่า arguments id ที่ส่งมาจากหน้า home_screen
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // print(arguments['id']);

    readNewsDetail(arguments['id'].toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(_dataNews?.topic ?? "..."),
      ),
      body: ListView(
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(_dataNews?.imageurl ?? "..."),
                fit: BoxFit.cover
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _dataNews?.topic ?? "...",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              _dataNews?.detail ?? "...",
              style: TextStyle(fontSize: 16),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Publish Date: ${_dataNews?.createdAt ?? "..."}',
              style: TextStyle(fontSize: 14.0),
            ),
          )
        ],
      ),
    );
    
  }
}