import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:thientammedicalapp/Value/share_keys.dart';
import 'package:thientammedicalapp/models/nhanvien.dart';

void saveNhanVien(NhanVien user) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Chuyển đổi đối tượng User thành chuỗi JSON
  String userJson = jsonEncode(user.toJson());

  // Lưu trữ chuỗi JSON sử dụng SharedPreferences
  await prefs.setString(ShareKeys.userNV, userJson);
}

Future<String?> getSavedToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(ShareKeys.TokenKey);
}