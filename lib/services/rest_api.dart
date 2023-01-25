// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;

class CallAPI {

  // URL API
  String baseURLAPI = 'https://www.itgenius.co.th/sandbox_api/mrta_flutter_api/public/api/';

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

}