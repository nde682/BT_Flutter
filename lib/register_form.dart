import 'package:flutter/material.dart';
class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  void initState() {
    super.initState();
    
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isPasswordConfirmVisible = false;
  String? validateEmail(String? value) {
  
    if (value == null || value.isEmpty) {
      return 'Vui lòng nhập email';
    }
    final RegExp emailRegex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@'
        r'((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|'
        r'(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!emailRegex.hasMatch(value)) {
      return 'Email không hợp lệ';
    }
    return null;
  }
  void _validateAndLogin() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập thành công'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  bool _checkPasswordMatch() {
    return _passwordController.text == _confirmPasswordController.text;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Đăng ký" , style: TextStyle(color: Colors.white, fontSize: 20),),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: "Họ tên",
                  hintText: "Nhập tên người dùng",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập họ tên" : null,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Nhập email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) => validateEmail(value),
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _passwordController,
                obscureText: _isPasswordVisible,
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  hintText: "Nhập mật khẩu",
                  prefixIcon: const Icon(Icons.lock_sharp),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                    icon: Icon(_isPasswordVisible ? Icons.visibility_off : Icons.visibility)
                  ), 
                ),
                validator: (value) => value!.isEmpty ? "Vui nhập mật khẩu" : value.length < 6 ? "Mật khẻ phải nhất 6 ký tập" : null,
              ),
              SizedBox(height: 20,),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: _isPasswordConfirmVisible,
                decoration: InputDecoration(
                  labelText: "Xác nhận mật khẩu",
                  hintText: "Nhập lại mật khẩu",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon:IconButton(
                    onPressed: () {
                      setState(() {
                        _isPasswordConfirmVisible = !_isPasswordConfirmVisible;
                      });
                    },
                    icon:  Icon(_isPasswordConfirmVisible ? Icons.visibility_off : Icons.visibility)
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Vui xác nhận mật khẩu" : _checkPasswordMatch() ? null : "Mật khẩu không khớp",
              ),
              SizedBox(height: 20,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _validateAndLogin,
                  style: ElevatedButton.styleFrom( 
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                  ),
                  child: const Text("Đăng ký", style: TextStyle(fontSize: 20, color: Colors.white),),
                ),
              )
            ],
          ),
        )
        ),
    );
  }
}