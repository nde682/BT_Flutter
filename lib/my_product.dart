import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/model/product.dart';
// 1. IMPORT FILE GIỎ HÀNG VÀ MÀN HÌNH GIỎ HÀNG
import 'package:flutter_application_1/model/cart.dart';
import 'package:flutter_application_1/cart_screen.dart';

class MyProduct extends StatefulWidget {
  const MyProduct({super.key});

  @override
  State<MyProduct> createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {
  late Future<List<Product>> _productsFuture;
  @override
  void initState() {
    _productsFuture = testapi.getAllProduct();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cửa hàng trực tuyến"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          // 2. ICON GIỎ HÀNG CÓ BADGE (SỐ LƯỢNG)
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Chuyển sang màn hình giỏ hàng
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  ).then((value) {
                    // Khi quay lại từ giỏ hàng, cập nhật lại số lượng (setState)
                    setState(() {});
                  });
                },
                icon: const Icon(Icons.shopping_cart),
              ),
              // Nếu giỏ hàng có đồ thì hiện chấm đỏ số lượng
              if (cart.items.isNotEmpty)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '${cart.getItemCount()}', // Lấy tổng số lượng từ cart
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
            ],
          )
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<List<Product>>(
        future: _productsFuture,
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
        childAspectRatio: 0.7, // Tỷ lệ khung hình
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
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ảnh sản phẩm
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
                fit: BoxFit.contain, // Giữ tỷ lệ ảnh không bị méo
              ),
            ),
          ),
          
          // Thông tin sản phẩm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 4),
                
                Text(
                  "\$${p.price}",
                  style: const TextStyle(
                    color: Colors.deepOrange, 
                    fontWeight: FontWeight.bold, 
                    fontSize: 16
                  ),
                ),
                
                const SizedBox(height: 4),
                
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
                    
                    // 3. NÚT THÊM VÀO GIỎ HÀNG
                    InkWell(
                      onTap: (){
                        setState(() {
                          cart.addToCart(p); // Gọi hàm thêm vào Singleton cart
                        });
                        
                        // Hiển thị thông báo nhỏ bên dưới
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Đã thêm ${p.title} vào giỏ"),
                            duration: const Duration(seconds: 1),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Colors.green,
                          )
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.blueAccent,
                          shape: BoxShape.circle
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 20),
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