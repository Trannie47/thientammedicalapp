import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Value/app_color.dart';
import 'package:thientammedicalapp/pages/main/about/page.dart';
import 'package:thientammedicalapp/pages/main/order/page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final PageController _pageController = PageController();

  final List<Widget> _screens = [
    OrderPage(),
    Center(child: Text("NCC")),
    Center(child: Text("Số lô")),
    Center(child: Text("Thông báo")),
    AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),

      bottomNavigationBar: Container(
        height: screenSize.height*0.1,
        color: const Color(0xFF2F3C4E), // nền tổng màu xám đậm
        child: Row(
          children: [
            _navItem(0, Icons.inventory_2_outlined, "Đơn hàng"),
            _navItem(1, Icons.apartment, "NCC"),
            _navItem(2, Icons.home_work_outlined, "Số lô"),
            _navItem(3, Icons.notifications_none, "Thông báo"),
            _navItem(4, Icons.person_outline, "Tôi"),
          ],
        ),
      ),
    );
  }

  Expanded _navItem(int index, IconData icon, String label) {
    bool selected = index == _currentIndex;

    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        child: Container(
          padding: const EdgeInsets.only(top: 10,bottom: 20),
          color: selected
              ? Colors.blue
              : const Color(0xFF2F3C4E), // ⬅ Tab không chọn → XÁM ĐẬM
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: selected
                  ? Colors.white
                  : AppColor.textDisabled),
              const SizedBox(height: 3),
              Text(
                label,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
