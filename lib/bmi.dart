import 'package:flutter/material.dart';
class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _Bmi();
}

class _Bmi extends State<Bmi> {
  @override
  void initState() {
    super.initState();
  }
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();

  double bmi = 0;

  void _calculateBMI() {
    double height = double.parse(_heightController.text)/100;
    double width = double.parse(_widthController.text);
    setState(() {
      bmi = width / (height * height);
    });
  }

  String _getBMIStatus() {
    if (bmi < 18.5) {
      return "Thiếu cân";
    } else if (bmi >= 18.5 && bmi < 25) {
      return "Bình thường";
    } else if(bmi >= 25 && bmi < 30) {
      return "Thừa cân";
    }else{
      return "Béo phì";
    }
  }
  @override
  void dispose() {
    _heightController.dispose();
    _widthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tính chỉ số BMI",style: TextStyle(color: Colors.white,fontSize: 20),),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(
                  labelText: "Chiều cao (cm)",
                  hintText: "Nhập chiều cao của bạn",
                  prefixIcon: Icon(Icons.height_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập chiều cao" : null,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _widthController,
                decoration: const InputDecoration(
                  labelText: "Cân nặng (kg)",
                  hintText: "Nhập cân nặng của bạn",
                  prefixIcon: Icon(Icons.monitor_weight_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                validator: (value) => value!.isEmpty ? "Vui lòng nhập cân nặng" : null,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20,),
              ElevatedButton.icon(
                onPressed: _calculateBMI, 
                icon: const Icon(Icons.monitor_weight,color: Colors.white,),
                label: const Text("Tính chi số BMI",style: TextStyle(color: Colors.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                ),
              ),
              const SizedBox(height: 20,),
              Text("Chi số BMI: ${bmi.toStringAsFixed(2)}",style: TextStyle(fontSize: 20,color: Colors.red),),
              const SizedBox(height: 20,),
              Text("Phân loại: ${_getBMIStatus()}",style: TextStyle(fontSize: 15,color: Colors.red),),
            ],
          ),
          )
        ),
    );
  }
}