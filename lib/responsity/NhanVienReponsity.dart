import 'package:thientammedicalapp/Value/app_http.dart';
import 'package:thientammedicalapp/models/nhanvien.dart';
import 'package:thientammedicalapp/services/api_service.dart';

Future<NhanVien> getNhanVienByID(String maNV ) async {
  String urilink = "${HTTP.webServer}auth/nhanvien/${maNV.toString()}";
  final response = await ApiService.get(urilink);
  print("User data: ${response.data}");
  // print(response.body);
  if (response.statusCode == 200) {
    final data = response.data['data'];
    return NhanVien.fromJson(data);
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> changeNewPassword(String newPass ) async {
  String urilink = "${HTTP.webServer}auth/change-password-first";
  final response = await ApiService.post(urilink,
      data: {
        "newPassword":  newPass.toString(),
      });

  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}

Future<bool> changePassword({required String oldPass, required String newPass}  ) async {
  String urilink = "${HTTP.webServer}auth/change-password";
  final response = await ApiService.post(urilink,
      data: {
        "oldPassword": oldPass.toString(),
        "newPassword": newPass.toString()
      });

  // print(response.body);
  if (response.statusCode == 201) {
    return true;
  } else {
    throw Exception("Fail to load");
  }
}