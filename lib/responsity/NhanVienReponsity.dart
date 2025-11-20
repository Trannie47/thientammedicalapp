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