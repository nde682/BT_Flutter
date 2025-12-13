import 'package:flutter/material.dart';

class MyPlace extends StatelessWidget {
  const MyPlace({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Place'),
      ),
      body: Column(
        children: [
          block1(),
          block2(),
          block3(),
          block4()
        ],
      )
      );
  }
  Widget block1(){
    var src = "https://file.hstatic.net/1000379600/article/hinh-nen-26_94b01372b3f441f494bbf297ee6cc655_grande.jpg";
    return Image.network(src);
  }
  Widget block2(){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Biển ở đâu đó", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              Text("Chỗ nào đó trên thế giới", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w100),)
            ],
          ),
          Row(
            children: [
              Icon(Icons.favorite , color: Colors.red,),
              Text("1,000", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)
            ])
        ])
    );
  }
  Widget block3(){
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Icon(Icons.phone, color: Colors.blue,),
              Text("Call", style: TextStyle(fontSize: 20,color: Colors.blue))
            ]
          ),
          Column(
            children: [
              Icon(Icons.send, color: Colors.blue,),
              Text("Route", style: TextStyle(fontSize: 20,color: Colors.blue))
            ]
          ),
          Column(
            children: [
              Icon(Icons.share, color: Colors.blue,),
              Text("Share", style: TextStyle(fontSize: 20,color: Colors.blue))
            ]
          )
        ]
      )
    );
  }
  Widget block4(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Đây là 1 bãi biển đâu đó trên mạng mà thằng viết app này kiếm được", style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),)
          ]
        )
      )
    );
  }
}