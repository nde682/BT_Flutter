import 'package:flutter/material.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({super.key});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  // 1. Khai báo các Controller và Biến
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contentController = TextEditingController();
  
  // Biến lưu giá trị sao đang chọn (mặc định là null hoặc em có thể set là '5 sao')
  String? _selectedRating; 

  // Danh sách các lựa chọn cho Dropdown
  final List<String> _ratings = [
    '1 sao', '2 sao', '3 sao', '4 sao', '5 sao'
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // Xử lý khi form hợp lệ
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cảm ơn bạn đã gửi phản hồi!'),
          backgroundColor: Colors.deepOrange,
        ),
      );
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gửi phản hồi'),
        centerTitle: true,
        backgroundColor: Colors.deepOrange, 
        foregroundColor: Colors.white, // Chữ màu trắng
      ),
      body: SingleChildScrollView( // Cho phép cuộn nếu màn hình nhỏ
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                
                // --- 1. Ô NHẬP HỌ TÊN ---
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Họ tên',
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập họ tên';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // --- 2. DROPDOWN CHỌN SỐ SAO (Điểm mới) ---
                DropdownButtonFormField<String>(
                  value: _selectedRating, // Giá trị hiện tại
                  decoration: const InputDecoration(
                    labelText: 'Đánh giá (1 - 5 sao)',
                    prefixIcon: Icon(Icons.star),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  // Tạo danh sách các mục chọn
                  items: _ratings.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  // Xử lý khi chọn
                  onChanged: (newValue) {
                    setState(() {
                      _selectedRating = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Vui lòng chọn số sao';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // --- 3. Ô NỘI DUNG GÓP Ý (Nhiều dòng) ---
                TextFormField(
                  controller: _contentController,
                  // maxLines: null cho phép tự dãn nở, hoặc đặt số cụ thể
                  maxLines: 5, 
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung góp ý',
                    alignLabelWithHint: true, // Căn label lên trên cùng
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 60), // Căn icon lên trên
                      child: Icon(Icons.feedback_outlined),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập nội dung';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                // --- 4. NÚT GỬI ---
                SizedBox(
                  width: 200, // Độ rộng nút
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25), // Bo tròn nút
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.send),
                        SizedBox(width: 10),
                        Text('Gửi phản hồi', style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}