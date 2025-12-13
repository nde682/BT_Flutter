import 'package:flutter/material.dart';
class CountNum extends StatefulWidget {
  const CountNum({super.key});

  @override
  State<CountNum> createState() => _CountNumState();
}
class _CountNumState extends State<CountNum> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  int countNum = 0;
  void _incrementCounter() {
    setState(() {
      countNum++;
    });
  }
  void _decrementCounter() {
    setState(() {
      countNum--;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Ứng dụng đếm số"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Container(
        decoration: BoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Text("Giá trị hiện lại",style: TextStyle(fontSize: 20),),
            Text(countNum.toString(),style: TextStyle(fontSize: 40,color: Colors.red),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: _decrementCounter, 
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.red, ),
                  child: const Text("- Giảm",style: TextStyle(fontSize: 20,color: Colors.white),)
                ),
                ElevatedButton(
                  onPressed: (){
                    setState(() {
                      countNum = 0;
                    });
                  }, 
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.grey, ),
                  child: const Text(" Đặt lại",style: TextStyle(fontSize: 20,color: Colors.white),)
                ),
                ElevatedButton(
                  onPressed: _incrementCounter, 
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.green, ),
                  child: const Text("+ Tăng",style: TextStyle(fontSize: 20,color: Colors.white),
                  )
                )
              ],
            )
            
          ],
        ),
      ),
    );
  }
}