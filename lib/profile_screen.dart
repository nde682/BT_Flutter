import 'package:flutter/material.dart';
import 'package:flutter_application_1/form_login.dart';
import 'package:flutter_application_1/model/userProfile.dart';

class UserProfileScreen extends StatelessWidget {
  final Userprofile user;

  const UserProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Màu nền nhẹ nhàng
      appBar: AppBar(
        title: const Text("Hồ sơ cá nhân"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
            tooltip: "Đăng xuất",
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  // 1. Thông tin cá nhân cơ bản
                  _buildSectionCard("Thông tin cá nhân", Icons.person, [
                    _buildInfoRow("Họ tên", "${user.firstName} ${user.lastName} ${user.maidenName ?? ''}"),
                    _buildInfoRow("Tuổi", "${user.age}"),
                    _buildInfoRow("Giới tính", user.gender ?? "N/A"),
                    _buildInfoRow("Ngày sinh", user.birthDate ?? "N/A"),
                    _buildInfoRow("Nhóm máu", user.bloodGroup ?? "N/A"),
                    _buildInfoRow("Chiều cao", "${user.height} cm"),
                    _buildInfoRow("Cân nặng", "${user.weight} kg"),
                    _buildInfoRow("Màu mắt", user.eyeColor ?? "N/A"),
                    _buildInfoRow("Tóc", "${user.hair?.color ?? ''}, ${user.hair?.type ?? ''}"),
                  ]),

                  // 2. Liên hệ & Địa chỉ
                  _buildSectionCard("Liên hệ & Địa chỉ", Icons.contact_mail, [
                    _buildInfoRow("Email", user.email ?? "N/A"),
                    _buildInfoRow("SĐT", user.phone ?? "N/A"),
                    _buildInfoRow("Đại học", user.university ?? "N/A"),
                    const Divider(),
                    _buildInfoRow("Địa chỉ", user.address?.address ?? "N/A"),
                    _buildInfoRow("Thành phố", "${user.address?.city}, ${user.address?.state}"),
                    _buildInfoRow("Mã bưu điện", user.address?.postalCode ?? "N/A"),
                  ]),

                  // 3. Công việc
                  _buildSectionCard("Công việc", Icons.work, [
                    _buildInfoRow("Công ty", user.company?.name ?? "N/A"),
                    _buildInfoRow("Chức vụ", user.company?.title ?? "N/A"),
                    _buildInfoRow("Phòng ban", user.company?.department ?? "N/A"),
                    _buildInfoRow("Địa chỉ CT", user.company?.address?.address ?? "N/A"),
                  ]),

                  // 4. Tài chính (Ngân hàng & Crypto)
                  _buildSectionCard("Tài chính", Icons.attach_money, [
                    _buildInfoRow("Số thẻ", user.bank?.cardNumber ?? "N/A"),
                    _buildInfoRow("Loại thẻ", user.bank?.cardType ?? "N/A"),
                    _buildInfoRow("Hết hạn", user.bank?.cardExpire ?? "N/A"),
                    _buildInfoRow("Tiền tệ", user.bank?.currency ?? "N/A"),
                    const Divider(),
                    _buildInfoRow("Ví Crypto", user.crypto?.wallet ?? "N/A"),
                    _buildInfoRow("Coin", user.crypto?.coin ?? "N/A"),
                    _buildInfoRow("Mạng lưới", user.crypto?.network ?? "N/A"),
                  ]),

                  // 5. Thông tin hệ thống (Technical)
                  _buildSectionCard("Thông tin hệ thống", Icons.settings_ethernet, [
                    _buildInfoRow("IP", user.ip ?? "N/A"),
                    _buildInfoRow("Mac Address", user.macAddress ?? "N/A"),
                    _buildInfoRow("User Agent", user.userAgent ?? "N/A", isLongText: true),
                    _buildInfoRow("EIN", user.ein ?? "N/A"),
                    _buildInfoRow("SSN", user.ssn ?? "N/A"),
                  ]),

                  const SizedBox(height: 30),
                  // Nút Logout to ở dưới cùng
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () => _logout(context),
                      icon: const Icon(Icons.logout),
                      label: const Text("Đăng xuất", style: TextStyle(fontSize: 18)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // HEADER: Avatar + Tên + Role
  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 47,
              backgroundImage: NetworkImage(user.image ?? ""),
              onBackgroundImageError: (_, __) {},
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${user.firstName} ${user.lastName}",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            "@${user.username}",
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 8),
          Chip(
            label: Text(user.role?.toUpperCase() ?? "USER"),
            backgroundColor: Colors.white,
            labelStyle: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  // WIDGET CON: Card chứa nhóm thông tin
  Widget _buildSectionCard(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blueAccent),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 20, thickness: 1),
            ...children,
          ],
        ),
      ),
    );
  }

  // WIDGET CON: Dòng thông tin (Label: Value)
  Widget _buildInfoRow(String label, String value, {bool isLongText = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: isLongText ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100, // Độ rộng cố định cho nhãn
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  void _logout(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FormLogin()),
    );
  }
}