import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/model/product.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cửa hàng trực tuyến"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart))
        ],
      ),
      backgroundColor: Colors.grey[100], 
      body: FutureBuilder<List<Product>>(
        future: test_api.getAllProduct(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text("Lỗi: ${snap.error}"));
          }
          if (!snap.hasData || snap.data!.isEmpty) {
            return const Center(child: Text("Không có sản phẩm nào"));
          }
          
          return myGridList(snap.data!);
        },
      ),
    );
  }

  Widget myGridList(List<Product> products) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 2 cột
        childAspectRatio: 0.7, // Tỷ lệ chiều rộng/cao của 1 ô (càng nhỏ ô càng cao)
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return myItem(products[index]);
      },
    );
  }

  Widget myItem(Product p) {
    return Card(
      elevation: 2, // Độ đổ bóng
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Ảnh sản phẩm
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                color: Colors.white,
              ),
              child: Image.network(
                p.image,
                fit: BoxFit.contain, // Giữ tỷ lệ ảnh
              ),
            ),
          ),
          
          // 2. Thông tin sản phẩm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tên sản phẩm (giới hạn 2 dòng)
                Text(
                  p.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                
                // Giá tiền
                Text(
                  "\$${p.price}",
                  style: const TextStyle(
                    color: Colors.redAccent, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                  ),
                ),
                
                const SizedBox(height: 4),
                
                // Rating và Count (Đã lấy được từ Product mà không cần class Rating)
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    Text(
                      " ${p.rate}", 
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)
                    ),
                    Text(
                      " (${p.count})", 
                      style: const TextStyle(fontSize: 12, color: Colors.grey)
                    ),
                    const Spacer(),
                    // Nút thêm vào giỏ hàng nhỏ
                    InkWell(
                      onTap: (){},
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 16),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}