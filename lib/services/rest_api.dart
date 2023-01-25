// ignore_for_file: prefer_interpolation_to_compose_strings, unnecessary_null_comparison

import 'dart:convert';
import 'package:flutter_scale/models/NewsDetailModel.dart';
import 'package:flutter_scale/models/NewsModel.dart';
import 'package:flutter_scale/utils/constant.dart';
import 'package:http/http.dart' as http;

class CallAPI {

  // กำหนด header ของ API
  _setHeader() => {
    'Content-Type':'application/json',
    'Accept':'application/json'
  };

  // สร้างฟังก์ชันสำหรับ Login
  loginAPI(data) async {
    return await http.post(
      Uri.parse(baseURLAPI+'login'),
      body: jsonEncode(data),
      headers: _setHeader()
    );
  }

  // ฟังก์ชันอ่านข่าวทั้งหมด
  Future<List<NewsModel>?> getAllNews() async {
    final response = await http.get(
      Uri.parse(baseURLAPI+'news'),
      headers: _setHeader()
    );
    if(response.body != null){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }
  }

    // ฟังก์ชันอ่านข่าวล่าสุด
  Future<List<NewsModel>?> getLastNews() async {
    final response = await http.get(
      Uri.parse(baseURLAPI+'lastnews'),
      headers: _setHeader()
    );
    if(response.body != null){
      return newsModelFromJson(response.body);
    }else{
      return null;
    }
  }

  // สร้างฟังก์ชันอ่านรายละเอียดข่าว
  Future<NewsDetailModel?> getNewsDetail(id) async {
    final response = await http.get(
      Uri.parse(baseURLAPI+'news/'+id),
      headers: _setHeader()
    );
    if(response.body != null){
      return newsDetailModelFromJson(response.body);
    }else{
      return null;
    }
  }


}