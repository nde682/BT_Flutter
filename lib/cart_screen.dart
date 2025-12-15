import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/cart.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Giỏ hàng của bạn"),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[100],
      body: cart.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey),
                  SizedBox(height: 20),
                  Text("Giỏ hàng đang trống", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : Column(
              children: [
                // 1. Danh sách sản phẩm
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(15),
                    itemCount: cart.items.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return _buildCartItem(item);
                    },
                  ),
                ),
                // 2. Phần thanh toán (Bottom Bar)
                _buildBottomBar(),
              ],
            ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // Ảnh sản phẩm
            Container(
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.network(item.product.image, fit: BoxFit.contain),
            ),
            const SizedBox(width: 15),
            
            // Thông tin + Tăng giảm
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "\$${item.product.price}",
                    style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  
                  // Nút tăng giảm số lượng
                  Row(
                    children: [
                      _buildQtyBtn(Icons.remove, () {
                        setState(() {
                          cart.decreaseQty(item);
                        });
                      }),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text("${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      _buildQtyBtn(Icons.add, () {
                        setState(() {
                          cart.increaseQty(item);
                        });
                      }),
                    ],
                  )
                ],
              ),
            ),
            
            // Nút xóa
            IconButton(
              onPressed: () {
                // Hiện hộp thoại xác nhận xóa
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text("Xác nhận"),
                    content: const Text("Bạn muốn xóa sản phẩm này khỏi giỏ?"),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Hủy")),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            cart.removeFromCart(item);
                          });
                          Navigator.pop(ctx);
                        }, 
                        child: const Text("Xóa", style: TextStyle(color: Colors.red))
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline, color: Colors.red),
            )
          ],
        ),
      ),
    );
  }

  // Nút nhỏ tăng/giảm
  Widget _buildQtyBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Tổng cộng:", style: TextStyle(color: Colors.grey)),
              Text(
                "\$${cart.getTotalPrice().toStringAsFixed(2)}", // Làm tròn 2 số thập phân
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Xác nhận"),
                      content: const Text("Bạn muốn xóa giỏ hàng này?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text("Hủy")),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              cart.clear();
                            });
                            Navigator.pop(ctx);
                          }, 
                          child: const Text("Xóa", style: TextStyle(color: Colors.red))
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Xoá giỏ hàng", style: TextStyle(fontSize: 16)),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Thanh toán giả vờ thành công!")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text("Thanh toán", style: TextStyle(fontSize: 16)),
              ),
            ],
          ),

          
        ],
      ),
    );
  }
}