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

Future<NhanVien?> getProfileMe() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString(ShareKeys.nhanVien);

    if (jsonString == null || jsonString.isEmpty) {
      return null; // chưa đăng nhập hoặc chưa lưu
    }

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return NhanVien.fromJson(jsonMap);
  } catch (e) {
    return null;
  }
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