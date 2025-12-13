import 'package:flutter/material.dart';
import 'package:flutter_application_1/bmi.dart';
import 'package:flutter_application_1/count_num.dart';
import 'package:flutter_application_1/count_time.dart';
import 'package:flutter_application_1/feedback_form.dart';
import 'package:flutter_application_1/my_class.dart';
import 'package:flutter_application_1/my_home_page.dart';
import 'package:flutter_application_1/my_place.dart';
import 'package:flutter_application_1/my_place_homepage.dart';
import 'package:flutter_application_1/my_news.dart';
import 'package:flutter_application_1/my_product.dart';
import 'package:flutter_application_1/form_login.dart';
import 'package:flutter_application_1/ran_color.dart';
import 'package:flutter_application_1/register_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      // 1. THANH APP BAR
      appBar: AppBar(
        title: const Text("Bài Tập Cuối Kỳ"),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      
      // 2. DRAWER (MENU TRƯỢT) 
      drawer: _buildDrawer(),

      // 3. GIAO DIỆN CHÍNH (DASHBOARD)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeBanner(),
            const SizedBox(height: 20),
            const Text(
              "Danh sách bài tập",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            // Lưới các chức năng (Grid)
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: [
                _buildDashboardItem(
                  "Bài đầu tiên", 
                  Icons.home, 
                  const Color.fromARGB(153, 68, 102, 88), 
                  () => _navigateTo(const MyHomePage())
                ),
                _buildDashboardItem(
                  "Bài phong cảnh", 
                  Icons.photo_library, 
                  const Color.fromARGB(255, 13, 0, 255), 
                  () => _navigateTo(const MyPlace())
                ),
                _buildDashboardItem(
                  "Thư viện ảnh", 
                  Icons.photo_library, 
                  Colors.orange, 
                  () => _navigateTo(const MyPlaceHP())
                ),
                _buildDashboardItem(
                  "Lớp học", 
                  Icons.class_, 
                  const Color.fromARGB(255, 255, 102, 0), 
                  () => _navigateTo(const MyClass())
                ),
                _buildDashboardItem(
                  "Màu ngẫu nhiên", 
                  Icons.color_lens, 
                  const Color.fromARGB(255, 255, 0, 111), 
                  () => _navigateTo(const RanColor())
                ),
                _buildDashboardItem(
                  "Đếm số", 
                  Icons.numbers, 
                  const Color.fromARGB(255, 7, 197, 90), 
                  () => _navigateTo(const CountNum())
                ),
                _buildDashboardItem(
                  "Đếm thoi gian", 
                  Icons.lock_clock, 
                  const Color.fromARGB(255, 255, 102, 0), 
                  () => _navigateTo(const CountTime())
                ),
                _buildDashboardItem(
                  "Tính BMI", 
                  Icons.line_weight, 
                  const Color.fromARGB(255, 255, 0, 0), 
                  () => _navigateTo(const Bmi())
                ),
                _buildDashboardItem(
                  "Trang đăng nhập", 
                  Icons.person, 
                  const Color.fromARGB(255, 77, 5, 60), 
                  () => _navigateTo(const FormLogin())
                ),
                _buildDashboardItem(
                  "Trang đăng ký", 
                  Icons.person_2, 
                  const Color.fromARGB(255, 17, 78, 1), 
                  () => _navigateTo(const RegisterForm())
                ),
                _buildDashboardItem(
                  "Trang feedback", 
                  Icons.feedback, 
                  const Color.fromARGB(255, 80, 33, 2), 
                  () => _navigateTo(const FeedbackForm())
                ),
                _buildDashboardItem(
                  "Tin tức 24h", 
                  Icons.newspaper, 
                  Colors.redAccent, 
                  () => _navigateTo(const MyNews())
                ),
                _buildDashboardItem(
                  "Cửa hàng", 
                  Icons.storefront, 
                  Colors.teal, 
                  () => _navigateTo(const MyProduct())
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET: DRAWER ĐẸP MẮT ---
  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header với Gradient
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.indigo, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: const Text(
              "Lý Ngọc Đế",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: const Text("22T1080053@husc.edu.vn"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: const AssetImage("assets/images/5.jpg"),
              ),
            ),
          ),

          // Các mục menu
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Danh sách bài tập", style: TextStyle( fontSize: 25, fontWeight: FontWeight.bold),
              ),
            )),
          const Divider(),
          _buildDrawerItem(Icons.photo_library, "Bài 1: Bài đầu tiên", () => _navigateTo(const MyHomePage())),
          _buildDrawerItem(Icons.photo_library, "Bài 2: Trang phong cảnh", () => _navigateTo(const MyPlace())),
          _buildDrawerItem(Icons.photo_library, "Bài 3: GridView Ảnh", () => _navigateTo(const MyPlaceHP())),
          _buildDrawerItem(Icons.photo_library, "Bài 4: Giao diện lớp học", () => _navigateTo(const MyClass())),
          _buildDrawerItem(Icons.photo_library, "Bài 5: Màu ngẫu nhiên", () => _navigateTo(const RanColor())),
          _buildDrawerItem(Icons.photo_library, "Bài 6: Đến số", () => _navigateTo(const CountNum())),
          _buildDrawerItem(Icons.photo_library, "Bài 7: Đếm thời gian", () => _navigateTo(const CountTime())),
          _buildDrawerItem(Icons.photo_library, "Bài 8: Tính BMI", () => _navigateTo(const Bmi())),
          _buildDrawerItem(Icons.photo_library, "Bài 9: Form đăng nhập", () => _navigateTo(const FormLogin())),
          _buildDrawerItem(Icons.photo_library, "Bài 10: Form đăng ký", () => _navigateTo(const RegisterForm())),
          _buildDrawerItem(Icons.photo_library, "Bài 11: Form feedback", () => _navigateTo(const FeedbackForm())),
          _buildDrawerItem(Icons.newspaper, "Bài 12: Tin tức (API)", () => _navigateTo(const MyNews())),
          _buildDrawerItem(Icons.store, "Bài 13: Cửa hàng (API)", () => _navigateTo(const MyProduct())),
          const Divider(),
          SizedBox(
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Đây là toàn bộ bài tập của Lý Ngọc Đế từng làm trong học kỳ qua", style: TextStyle(fontStyle: FontStyle.italic, fontSize: 15),
              ),
            )),
        ],
      ),
    );
  }

  // Widget con: Item trong Drawer
  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, 
      {Color? textColor, Color? iconColor}) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.indigo),
      title: Text(
        title, 
        style: TextStyle(color: textColor ?? Colors.black87, fontWeight: FontWeight.w500)
      ),
      onTap: () {
        Navigator.pop(context); // Đóng Drawer trước khi chuyển trang
        onTap();
      },
    );
  }

  // Widget con: Item dạng thẻ trên Dashboard
  Widget _buildDashboardItem(String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1), // Màu nền nhạt
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ]
              ),
              child: Icon(icon, size: 30, color: color),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: TextStyle(
                fontSize: 16, 
                fontWeight: FontWeight.bold,
                color: color.withOpacity(0.8)
              ),
            )
          ],
        ),
      ),
    );
  }

  // Widget con: Banner chào mừng
  Widget _buildWelcomeBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.indigo, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ]
      ),
      child: const Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Chào mừng đến với bài tập cuối kỳ của Lý Ngọc Đế!",
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Icon(Icons.rocket_launch, color: Colors.white, size: 50)
        ],
      ),
    );
  }

  // Hàm chuyển trang chung
  void _navigateTo(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
