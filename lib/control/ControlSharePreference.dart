import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thientammedicalapp/Value/share_keys.dart';
import 'package:thientammedicalapp/models/nhanvien.dart';
import 'package:thientammedicalapp/models/userLogin.dart';

Future<void> saveUserLogin(UserLogin user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Chuyển đổi đối tượng User thành chuỗi JSON
  String userJson = jsonEncode(user.toJson());

  // Lưu trữ chuỗi JSON sử dụng SharedPreferences
  await prefs.setString(ShareKeys.userNV, userJson);
}

Future<void> deleteUserLogin() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Lưu trữ chuỗi JSON sử dụng SharedPreferences
  await prefs.remove(ShareKeys.userNV);

}

Future<void> saveNhanVienSharedPreferences(NhanVien nhanvien) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Chuyển đổi đối tượng User thành chuỗi JSON
  String nhanvienJson = jsonEncode(nhanvien.toJson());

  // Lưu trữ chuỗi JSON sử dụng SharedPreferences
  await prefs.setString(ShareKeys.nhanVien, nhanvienJson);
}

Future<void> deleteNhanvienSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Lưu trữ chuỗi JSON sử dụng SharedPreferences
  await prefs.remove(ShareKeys.nhanVien);

}


Future<String?> getSavedToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(ShareKeys.TokenKey);
}