
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:thientammedicalapp/Value/app_http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thientammedicalapp/Value/share_keys.dart';

Future<bool> accessToken(String maNV,String matkhau ) async {
  String urilink = "${HTTP.webServer}auth/login";
  final response =
  await http.post(Uri.parse(urilink), body: {
    "maNV": maNV.toString(),
    "matKhau": matkhau.toString()
  });
  // print(response.body);
  if (response.statusCode == 201) {
    final data = jsonDecode(response.body);
    final token = data['access_token'];

    // Lưu token vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ShareKeys.TokenKey, token);
    return true;
  } else {
    // throw Exception("Fail to load");
    return false;
  }
}