import 'package:flutter_application_1/model/product.dart';

// 1. Model cho một món trong giỏ (Gồm sản phẩm và số lượng)
class CartItem {
  Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

// 2. Class quản lý giỏ hàng (Singleton - Dùng chung toàn app)
class Cart {
  // Tạo instance duy nhất
  static final Cart _instance = Cart._internal();
  factory Cart() => _instance;
  Cart._internal();

  // Danh sách sản phẩm trong giỏ
  List<CartItem> items = [];

  // Hàm thêm vào giỏ
  void addToCart(Product product) {
    // Kiểm tra xem sản phẩm đã có trong giỏ chưa
    // indexWhere trả về -1 nếu không tìm thấy
    int index = items.indexWhere((item) => item.product.id == product.id);

    if (index >= 0) {
      // Nếu có rồi thì tăng số lượng
      items[index].quantity++;
    } else {
      // Chưa có thì thêm mới
      items.add(CartItem(product: product));
    }
  }

  // Hàm xóa khỏi giỏ
  void removeFromCart(CartItem item) {
    items.remove(item);
  }

  // Hàm tăng số lượng
  void increaseQty(CartItem item) {
    item.quantity++;
  }

  // Hàm giảm số lượng
  void decreaseQty(CartItem item) {
    if (item.quantity > 1) {
      item.quantity--;
    } else {
      // Nếu còn 1 mà giảm tiếp thì hỏi xóa (xử lý ở UI) hoặc xóa luôn
      items.remove(item);
    }
  }

  // Hàm tính tổng tiền
  double getTotalPrice() {
    double total = 0.0;
    for (var item in items) {
      // Ép kiểu dynamic price sang num rồi sang double để tránh lỗi
      double price = (item.product.price as num).toDouble();
      total += price * item.quantity;
    }
    return total;
  }

  // Hàm đếm tổng số sản phẩm (để hiện lên badge)
  int getItemCount() {
    return items.fold(0, (sum, item) => sum + item.quantity);
  }
  
  // Xóa sạch giỏ hàng (sau khi thanh toán)
  void clear() {
    items.clear();
  }
}

// Biến toàn cục để dùng nhanh
final cart = Cart();