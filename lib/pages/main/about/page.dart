import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Value/app_assets.dart';
import 'package:thientammedicalapp/Value/app_color.dart';
import 'package:thientammedicalapp/Value/enum.dart';
import 'package:thientammedicalapp/control/ControlSharePreference.dart';
import 'package:thientammedicalapp/models/nhanvien.dart';
import 'package:thientammedicalapp/pages/main/about/changepassword/page.dart';

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
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final nhanvien = await getProfileMe();
    if (mounted) {
      setState(() {
        _nhanvien = nhanvien;
        _isLoading = false;
        _phongBan = (nhanvien?.phongBan ?? 1) - 1;
      });
    }
  }

  void _navigateToChangePassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordScreen(isFirstPass: false),
      ),
    );
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            _buildAvatarInfo(),
            const SizedBox(height: 16),
            _buildInfoList(screenSize),
            const SizedBox(height: 16),
            _buildMenuList(screenSize),
            const SizedBox(height: 16),
            _logoutItem(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundColor: Colors.transparent,
                child: ClipOval(
                  child: Image.asset(
                    AppAssets.logo,
                    fit: BoxFit.cover,
                    width: 70,
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
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "Mã nhân viên: ${_nhanvien?.maNV ?? ""}",
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoList(Size screenSize) {
    return Column(
      children: [
        _infoItem(Icons.phone, "Số điện thoại", "${_nhanvien?.sdt ?? ""}", screenSize),
        _divider(screenSize),
        _infoItem(Icons.location_on_outlined, "Địa chỉ",
            "Tổ dân phố 7, Phường Tân Lập, Tỉnh Đắk Lắk, Việt Nam", screenSize),
        _divider(screenSize),
        _infoItem(Icons.account_circle_outlined, "Tài khoản", "nguyenA@gmail.com", screenSize),
        _divider(screenSize),
        _infoItem(Icons.badge_outlined, "Phòng Ban", "${NamePhongBan[_phongBan]}", screenSize),
        _divider(screenSize),
        _infoItem(Icons.info_outline, "Thông tin khác", "Ghi chú thêm...", screenSize),
        _divider(screenSize),
        _infoItem(Icons.list_alt_outlined, "Thông tin khác", "Thông tin khác...", screenSize),
      ],
    );
  }

  Widget _buildMenuList(Size screenSize) {
    return Column(
      children: [
        _menuItem(icon: Icons.lock_outline, title: "Đổi mật khẩu", onTap: _navigateToChangePassword),
        _divider(screenSize),
        _menuItem(icon: Icons.info_outline, title: "Thông tin ứng dụng", onTap: () {}),
      ],
    );
  }

  Widget _infoItem(IconData icon, String title, String value, Size screenSize) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
      child: Row(
        children: [
          Icon(icon, color: AppColor.textDisabled),
          const SizedBox(width: 12),
          SizedBox(
            width: screenSize.width / 3,
            child: Text(title, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    IconData? icon,
    required String title,
    VoidCallback? onTap,
  }) {
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }

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

  Widget _divider(Size screenSize) {
    return Container(
      height: 1,
      width: screenSize.width,
      color: AppColor.textDisabled,
    );
  }
}
