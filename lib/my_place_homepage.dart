import 'package:flutter/material.dart';
// dart:math sẽ giúp chúng ta tạo ra các số ngẫu nhiên, 
// nhưng ở đây chúng ta chỉ cần dùng hàm shuffle() có sẵn của List

// Bước 1: Chuyển sang StatefulWidget
// Chúng ta cần nó để "nhớ" 4 bức ảnh ngẫu nhiên
class MyPlaceHP extends StatefulWidget {
  const MyPlaceHP({super.key});

  @override
  State<MyPlaceHP> createState() => _MyPlaceHPState();
}

class _MyPlaceHPState extends State<MyPlaceHP> {
  // Đây là danh sách "bộ nhớ" của widget
  // Nó sẽ lưu 4 ảnh ngẫu nhiên được chọn
  List<String> _randomImagePaths = [];

  // Giả sử em có 10 bức ảnh trong 'assets/images/'
  // Đặt tên chúng là image_1.jpg, image_2.jpg, ... image_10.jpg
  // Và đã khai báo trong pubspec.yaml
  final List<String> _allImagePaths = List.generate(
    4, 
    (index) => 'assets/images/${index + 1}.jpg'
  );

  @override
  void initState() {
    super.initState();
    // Hàm này CHỈ CHẠY 1 LẦN khi widget được tạo ra
    _selectRandomImages();
  }

  void _selectRandomImages() {
    // Tạo một bản sao của danh sách và xáo trộn nó
    final List<String> shuffledList = List.from(_allImagePaths)..shuffle();

    // Lấy 4 phần tử đầu tiên sau khi xáo trộn và cập nhật "bộ nhớ" (State)
    setState(() {
      _randomImagePaths = shuffledList.take(4).toList();
    });
  }

  // Toàn bộ phần build được chuyển vào trong State
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Xóa tiêu đề và màu nền cho giống thiết kế
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
        // Bước 2: Đưa các icon vào 'actions' của AppBar cho đúng chuẩn
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_outlined, color: Colors.black),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.extension_outlined, color: Colors.black),
          ),
          const SizedBox(width: 8), // Thêm chút khoảng cách
        ],
      ),
      body: SingleChildScrollView(
        // Bước 3: Thêm Padding để nội dung không dính sát vào cạnh màn hình
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            // Bước 4: Căn lề trái cho tất cả phần tử con
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // block 1 đã đưa lên AppBar
              // block2: Tối ưu
              _buildWelcomeText(),
              const SizedBox(height: 20),
              // block3: Tối ưu và làm đẹp
              _buildSearchBar(),
              const SizedBox(height: 30),
              // Tiêu đề "Saved picture"
              _buildSectionTitle("Saved Places"), // Đổi tên cho giống ảnh
              const SizedBox(height: 10),
              // block4: Hiển thị 4 ảnh ngẫu nhiên đã lưu
              _buildImageGrid()
            ],
          ),
        ),
      ),
    );
  }

  // Anh đổi tên hàm cho rõ ràng hơn và thêm _ ở trước (quy ước cho private)
  Widget _buildWelcomeText() {
    // Dùng Text.rich thay cho RichText để code gọn hơn
    return Text.rich(
      const TextSpan(
        style: TextStyle(fontSize: 36, color: Colors.black), // Style chung
        children: [
          TextSpan(text: 'Welcome, \n'), // Xuống dòng cho đẹp
          TextSpan(
            text: 'Ngoc De', // Tên này em thay bằng tên trong ảnh (Charlie)
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        // Làm đẹp TextField
        filled: true,
        fillColor: Colors.grey[200], // Màu nền xám nhạt
        contentPadding: EdgeInsets.zero,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none, // Bỏ viền
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).primaryColor), // Viền xanh khi focus
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildImageGrid() {
    // Kiểm tra xem ảnh đã kịp load chưa
    if (_randomImagePaths.isEmpty) {
      // Nếu chưa, hiển thị vòng xoay loading
      return const Center(child: CircularProgressIndicator());
    }

    return GridView.builder(
      // Bước 5: Sửa lỗi GridView lồng SingleChildScrollView
      // Báo cho GridView không cần cuộn
      physics: const NeverScrollableScrollPhysics(), 
      // shrinkWrap là bắt buộc khi lồng ListView/GridView
      shrinkWrap: true, 
      
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cột
        crossAxisSpacing: 12.0, // Khoảng cách ngang
        mainAxisSpacing: 12.0, // Khoảng cách dọc
        childAspectRatio: 1.2, // Điều chỉnh tỷ lệ ảnh
      ),
      itemCount: 4, // Luôn là 4
      itemBuilder: (context, index) {
        final String imagePath = _randomImagePaths[index];

        // Bước 6: Làm đẹp ảnh bằng cách bo góc
        return ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover, // Đảm bảo ảnh lấp đầy khung
            // Thêm xử lý lỗi nếu không tìm thấy ảnh
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image, color: Colors.grey),
              );
            },
          ),
        );
      },
    );
  }
}
