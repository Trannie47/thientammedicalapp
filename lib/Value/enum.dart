import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Value/app_color.dart';

final List<Color> tabColors = [
  AppColor.primary,   // index 0 → Đang giao
  AppColor.warning,   // index 1 → Đã giao
  AppColor.success,   // index 2 → Đã hoàn thành
];

final List<String> NamePhongBan = [
  'Admin ',     // index 0 → Admin
  'Kế toán',    // index 1 → Kế toán
  'QL Kho',     // index 2 → QL Kho
  'Nhân Viên bán hàng'  // index 3 → Kinh doanh
];