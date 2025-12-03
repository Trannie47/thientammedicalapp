import 'package:flutter/material.dart';
import 'package:thientammedicalapp/Value/app_assets.dart';
import 'package:thientammedicalapp/Value/app_color.dart';
import 'package:thientammedicalapp/Value/enum.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int selectedTab = 0; // 0 = Đang giao, 1 = Đã giao, 2 = Đã hoàn thành

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Đơn đặt hàng",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      body: Column(
        children: [
          // 🔵 TAB MENU
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTab(0, "Đang giao"),
                const SizedBox(width: 10),
                _buildTab(1, "Đã giao"),
                const SizedBox(width: 10),
                _buildTab(2, "Đã hoàn thành"),
              ],
            ),
          ),

          const SizedBox(height: 40),

          // 🔵 NỘI DUNG THEO TAB
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
    );
  }

  // TAB ITEM
  Widget _buildTab(int index, String title) {
    bool isSelected = selectedTab == index;
    final screenSize = MediaQuery.of(context).size;
    final selectColor = tabColors[index];
    return GestureDetector(
      onTap: () {
        setState(() => selectedTab = index);
      },
      child: Container(
        width: screenSize.width*0.30,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ? selectColor : Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isSelected ? selectColor : Colors.black26,
            width: 1.2,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // NỘI DUNG THEO TAB
  Widget _buildBody() {
    switch (selectedTab) {
      case 0:
        return _emptyOrder("Danh sách đơn hàng đang giao trống.");
      case 1:
        return _emptyOrder("Không có đơn hàng đã giao.");
      case 2:
        return _emptyOrder("Không có đơn hàng đã hoàn thành.");
      default:
        return Container();
    }
  }

  // TRẠNG THÁI RỖNG (GIỐNG HÌNH BẠN GỬI)
  Widget _emptyOrder(String message) {
    final screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppAssets.imgEmpty,
          fit: BoxFit.fill,
          width: screenSize.width * (3 / 4),
          height: screenSize.width * (3 / 4),
        ),
        const SizedBox(height: 20),
        Text(
          message,
          style: const TextStyle(
            fontSize: 20,
            color: AppColor.textPrimary,
          ),
        ),
      ],
    );
  }
}
