import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thientammedicalapp/Value/app_http.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: "${HTTP.webServer}",
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  // Khởi tạo interceptor để gắn token
  static Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("access_token");

    dio.interceptors.clear();
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) {
            options.headers["Authorization"] = "Bearer $token";
          }
          return handler.next(options);
        },
        onError: (e, handler) {
          // có thể xử lý lỗi token expired ở đây
          return handler.next(e);
        },
      ),
    );
  }

  // GET
  static Future<Response> get(String endpoint, {Map<String, dynamic>? query}) async {
    return await dio.get(endpoint, queryParameters: query);
  }

  // POST
  static Future<Response> post(String endpoint, {dynamic data}) async {
    return await dio.post(endpoint, data: data);
  }

  // PUT
  static Future<Response> put(String endpoint, {dynamic data}) async {
    return await dio.put(endpoint, data: data);
  }

  // PATCH
  static Future<Response> patch(String endpoint, {dynamic data}) async {
    return await dio.patch(endpoint, data: data);
  }

  // DELETE
  static Future<Response> delete(String endpoint, {dynamic data}) async {
    return await dio.delete(endpoint, data: data);
  }
}
