import 'dart:async';
import 'package:flutter/material.dart';

// 1. Xóa 'with TickerProviderStateMixin' vì không dùng đến
class CountTime extends StatefulWidget {
  const CountTime({super.key});

  @override
  State<CountTime> createState() => _CountTimeState();
}

class _CountTimeState extends State<CountTime> {
  Timer? _timer;
  int _initialTime = 0; // Thời gian ban đầu người dùng nhập
  int _currentTime = 0; // Thời gian đếm ngược hiện tại

  // 4. Thêm Controller để đọc dữ liệu từ TextField
  final TextEditingController _controller = TextEditingController();

  // Hàm format thời gian của em (OK, giữ nguyên)
  String timerText(int start) {
    final int minutes = start ~/ 60;
    final int seconds = start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _startTimer() {
    // 5. Lấy giá trị từ TextField một cách an toàn
    // Dùng int.tryParse để tránh lỗi nếu người dùng nhập chữ
    final int? seconds = int.tryParse(_controller.text);

    // Nếu người dùng không nhập gì hoặc nhập số 0, không làm gì cả
    if (seconds == null || seconds <= 0) {
      // (Nâng cao: Em có thể hiện 1 SnackBar ở đây để báo lỗi)
      return;
    }

    // Nếu đang có timer chạy, hủy nó đi
    _timer?.cancel();

    // Thiết lập trạng thái ban đầu
    setState(() {
      _initialTime = seconds;
      _currentTime = seconds;
    });

    // Bắt đầu timer mới
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // 6. Logic đếm ngược (Countdown)
      if (_currentTime > 0) {
        setState(() {
          _currentTime--;
        });
      } else {
        // Khi _currentTime == 0, dừng timer
        _timer?.cancel();
        // (Nâng cao: Em có thể thêm âm báo hoặc rung ở đây)
      }
    });
  }

  // 7. Sửa hàm 'stopTimer' thành 'resetTimer' cho đúng
  void _resetTimer() {
    // Hủy timer
    _timer?.cancel();
    // Đặt lại thời gian về giá trị ban đầu
    setState(() {
      _currentTime = _initialTime;
    });
  }

  @override
  void initState() {
    super.initState();

    _currentTime = _initialTime;
  }

  @override
  void dispose() {
    // 8. Hủy timer và controller khi State bị hủy (rất quan trọng)
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Ứng dụng đếm thời gian",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      // 9. Dùng Padding để nội dung không dính sát viền
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Căn chiều ngang
          children: [
            const SizedBox(height: 30),
            const Text(
              "Nhập số giây cần đếm:",
              style: TextStyle(fontSize: 15),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            TextField(
              // 10. Kết nối controller và chỉ cho phép nhập số
              controller: _controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center, // Cho số ra giữa
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: '60', // Gợi ý 60 giây
                filled: true,
                fillColor: Colors.grey[200],
                // Giao diện TextField của em làm đẹp rồi, anh giữ nguyên
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            const SizedBox(height: 30),
            // 11. Hiển thị _currentTime
            Text(
              timerText(_currentTime),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 56, // Cho to rõ
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _startTimer, // Gọi hàm _startTimer
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    "Bắt đầu",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: _resetTimer, // Gọi hàm _resetTimer
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    "Đặt lại",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}