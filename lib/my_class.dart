import 'package:flutter/material.dart';

class MyClass extends StatelessWidget {
  const MyClass({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lớp học của tôi"),centerTitle: true,),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              lop1(),
              lop2(),
              lop3(),
              lop4(),
              lop5()
            ],
          ),
        )
      )
      
    );
  }

  Widget lop1(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("XML và ứng dụng - Nhóm 1", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis,),
              Icon(Icons.more_horiz, color: Colors.white,size: 30,)
            ],
          ),
          Text("2025-2026.1.TIN4583.001", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color: Colors.white),),
          SizedBox(height: 20,),
          Text("58 học viên", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
  Widget lop2(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(152, 158, 158, 158),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 350,
                child: Text(
                  "Lập trình ứng dụng cho các thiết bị di động - Nhóm 1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white,size: 30,),
            ],
          ),
          Text("2025-2026.1.TIN4583.001", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color: Colors.white),),
          SizedBox(height: 20,),
          Text("58 học viên", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
  Widget lop3(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 78, 65, 65),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 350,
                child: Text(
                  "Lập trình ứng dụng cho các thiết bị di động - Nhóm 1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white,size: 30,),
            ],
          ),
          Text("2025-2026.1.TIN4583.001", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color: Colors.white),),
          SizedBox(height: 20,),
          Text("58 học viên", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
  Widget lop4(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 22, 10, 10),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 350,
                child: Text(
                  "Lập trình ứng dụng cho các thiết bị di động - Nhóm 1",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Icon(Icons.more_horiz, color: Colors.white,size: 30,),
            ],
          ),
          Text("2025-2026.1.TIN4583.001", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color: Colors.white),),
          SizedBox(height: 20,),
          Text("58 học viên", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
  Widget lop5(){
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black, width: 2)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("XML và ứng dụng - Nhóm 1", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),maxLines: 1,overflow: TextOverflow.ellipsis),
              Icon(Icons.more_horiz, color: Colors.white,size: 30,)
            ],
          ),
          Text("2025-2026.1.TIN4583.001", style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,color: Colors.white),),
          SizedBox(height: 20,),
          Text("58 học viên", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.white),),
        ],
      ),
    );
  }
}