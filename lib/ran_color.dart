import 'dart:math';

import 'package:flutter/material.dart';
class RanColor extends StatefulWidget {
  const RanColor({super.key});

  @override
  State<RanColor> createState() => _RanColorState();
}

class _RanColorState extends State<RanColor>{
  
  @override
  void initState() {
    super.initState();
    
  }
  Color bgColor = Colors.purple;
  String stringColor = "Tím";
  List<Color> listColor = [
    Colors.red,Colors.green,Colors.blue,Colors.purple,Colors.orange,Colors.pink
  ];
  List<String> listColorString = [
    "Đỏ","Xanh lá","Xanh dương","Tím","Cam","Hồng"
  ];
  void _changeColor(){
    var ran = Random();
    var ranNum = ran.nextInt(listColor.length);
    setState(() {
      bgColor = listColor[ranNum];
      stringColor = listColorString[ranNum];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ứng dụng đổi màu nền"),
        backgroundColor: Colors.green,
      ),
      body: 
        Container(
          decoration: BoxDecoration(color: bgColor),
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Màu hiện tại" , style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),),
              Text(stringColor, style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold,color: Colors.white),),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: _changeColor,
                    style: ElevatedButton.styleFrom( backgroundColor: Colors.blue),
                    child: const Text("Đổi màu",style: TextStyle(color: Colors.white),),
                    
                  ),
                  ElevatedButton(
                    onPressed: (){
                      setState(() {
                        bgColor = Colors.purple;
                        stringColor = "Tím";
                      });
                    },
                    style: ElevatedButton.styleFrom( backgroundColor: Colors.blue, ),
                    child: const Text("Đặt lại",style: TextStyle(color: Colors.white),),
                  ),

                ],
              )
            ],
          )
          ),
        )
    );
  }
}