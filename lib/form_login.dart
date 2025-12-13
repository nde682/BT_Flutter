import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart'; // Import API service
import 'package:flutter_application_1/profile_screen.dart'; // Import màn hình profile

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _isLoading = false; // Biến trạng thái để hiện vòng quay loading

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  Future<void> _validateAndLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      String username = _usernameController.text;
      String password = _passwordController.text;
      
      bool isSuccess = await authApi.login(username, password);

      if (isSuccess) {
        var userProfile = await authApi.getProfile();
        setState(() {
          _isLoading = false;
        });

        if (userProfile != null) {
          if (!mounted) return; 
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfileScreen(user: userProfile),
            ),
          );
        } else {
           _showError("Không lấy được thông tin người dùng");
        }
      } else {
        setState(() {
          _isLoading = false;
        });
        _showError("Sai tên đăng nhập hoặc mật khẩu");
      }
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Đăng nhập'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Username
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Tên người dùng',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  hintText: 'VD: emilys', // Gợi ý user test
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Vui lòng nhập tên';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Mật khẩu',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(),
                  hintText: 'VD: emilyspass', // Gợi ý pass test
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword ? Icons.visibility_off : Icons.visibility),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Vui lòng nhập mật khẩu';
                  if (value.length < 6) return 'Mật khẩu quá ngắn';
                  return null;
                },
              ),
              const SizedBox(height: 30),

              // Button Đăng nhập
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _validateAndLogin, // Vô hiệu hóa nút khi đang load
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: _isLoading 
                    ? const CircularProgressIndicator(color: Colors.white) // Hiện vòng quay
                    : const Text('Đăng nhập', style: TextStyle(fontSize: 18)),
                ),
              ),
              
              const SizedBox(height: 20),
              // Gợi ý tài khoản test cho em dễ dùng
              const Text(
                "Tài khoản test: emilys / emilyspass",
                style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
              )
            ],
          ),
        ),
      ),
    );
  }
}