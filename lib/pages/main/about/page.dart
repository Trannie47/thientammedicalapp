import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Value/app_assets.dart';
import 'package:thientammedicalapp/Value/app_color.dart';
import 'package:thientammedicalapp/Value/enum.dart';
import 'package:thientammedicalapp/control/ControlSharePreference.dart';
import 'package:thientammedicalapp/models/nhanvien.dart';


class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();

}

class _AboutPageState extends State<AboutPage> {
  NhanVien? _nhanvien;
  bool _isLoading = true;
  late int _phongBan = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final nhanvien = await getProfileMe(); // hàm async bạn đã sửa đúng rồi
    if (mounted) {
      setState(() {
        _nhanvien = nhanvien;
        _isLoading = false;
        _phongBan = (nhanvien?.phongBan ?? 1) -1 ;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Thông tin của tôi",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.edit_note_rounded, color: Colors.blue, size: 30),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            const SizedBox(height: 0),

            // 🧑‍🦰 Avatar + Tên + SĐT
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.transparent, // hoặc Colors.white nếu muốn nền
                        child: ClipOval(
                          child: Image.asset(
                            AppAssets.logo,
                            fit: BoxFit.cover,       // quan trọng: vừa khít, không méo
                            width: 70,               // = 2 × radius
                            height: 70,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 16,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${_nhanvien?.tenNhanVien ?? ""}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Mã nhân viên: ${_nhanvien?.maNV ?? ""}",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 🧾 Danh sách thông tin
            Column(
              children: [
                _infoItem(Icons.phone, "Số điện thoại", "${_nhanvien?.sdt ?? ""}"),
                Center(
                  child: Container(
                    height: 1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.textDisabled,
                    ),
                  ),
                ),
                _infoItem(Icons.location_on_outlined, "Địa chỉ",
                    "Tổ dân phố 7, Phường Tân Lập, Tỉnh Đắk Lắk, Việt Nam"),
                Center(
                  child: Container(
                    height: 1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.textDisabled,
                    ),
                  ),
                ),
                _infoItem(Icons.account_circle_outlined, "Tài Khoản", "nguyenA@gmail.com"),
                Center(
                  child: Container(
                    height: 1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.textDisabled,
                    ),
                  ),
                ),
                _infoItem(Icons.badge_outlined, "Phòng Ban", "${NamePhongBan[_phongBan ?? 0]}"),
                Center(
                  child: Container(
                    height: 1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.textDisabled,
                    ),
                  ),
                ),
                _infoItem(Icons.info_outline, "Thông tin khác", "Ghi chú thêm..."),
                Center(
                  child: Container(
                    height: 1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.textDisabled,
                    ),
                  ),
                ),
                _infoItem(Icons.list_alt_outlined, "Thông tin khác", "thông tin khác..."),
              ],
            ),

            Column(
              children: [
                _menuItem(Icons.lock_outline, "Đổi mật khẩu"),
                Center(
                  child: Container(
                    height: 1,
                    width: screenSize.width,
                    decoration: BoxDecoration(
                      color: AppColor.textDisabled,
                    ),
                  ),
                ),
                _menuItem(Icons.info_outline, "Thông tin ứng dụng"),
              ],
            ),

            _logoutItem(),
          ],
        ),
      ),
    );
  }

  // ======= WIDGET ITEM THÔNG TIN =======
  Widget _infoItem(IconData icon, String title, String value) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        spacing: 10,
        children: [
          Icon(icon, color: TColors.gray_400 ),

          Container(
              width: screenSize.width/3,
              child: Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)
              )
          ),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ======= WIDGET MENU =======
  Widget _menuItem(IconData icon, String title) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  // ======= WIDGET ĐĂNG XUẤT =======
  Widget _logoutItem() {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text(
          "Đăng xuất",
          style: TextStyle(color: Colors.red),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.red),
        onTap: () {},
      ),
    );
  }
}
