import 'package:dio/dio.dart';
import 'package:flutter_application_1/model/article.dart';
import 'package:flutter_application_1/model/product.dart';
import 'package:flutter_application_1/model/userProfile.dart';
import 'package:flutter_application_1/model/userlogin.dart';

class Api {
  Future<List<Product>> getAllProduct() async {
    var url = "https://fakestoreapi.com/products";
    var dio = Dio();
    
    try {
      var response = await dio.get(url); 
      List<Product> products = [];
      
      if (response.statusCode == 200) {
        List data = response.data;
        products = data.map((json) => Product.fromJson(json)).toList();
      } else {
        print("Lỗi API: ${response.statusMessage}");
      }
      return products;
    } catch (e) {
      print("Lỗi kết nối: $e");
      return []; // Trả về danh sách rỗng nếu lỗi
    }
  }
}

var test_api = Api();

class NewsApi {
  final Dio _dio = Dio();
  
  // Thay KEY của em vào đây
  final String _apiKey = '1127e0295b3541c8b404780d164748e6'; 
  
  // Hàm lấy tin tức mới nhất (Top Headlines)
  // category: business, entertainment, health, science, sports, technology
  Future<List<Article>> getTopHeadlines() async {
    // URL mẫu: lấy tin công nghệ tại Mỹ
    final String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$_apiKey';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['articles'];
        return data.map((json) => Article.fromJson(json)).toList();
      } else {
        throw Exception('Không tải được tin tức');
      }
    } catch (e) {
      print('Lỗi: $e');
      return [];
    }
  }
}
var test_newsApi = NewsApi();

class LoginApi {
  var accesstoken = "";

  // Sửa lại: Trả về Future<bool> để biết thành công hay thất bại
  Future<bool> login(String username, String password) async {
    var url = "https://dummyjson.com/auth/login";
    var dio = Dio();

    try {
      var response = await dio.post(url, data: {
        "username": username,
        "password": password,
        "expiresInMins": 30
      });

      if (response.statusCode == 200) {
        Userlogin user = Userlogin.fromJson(response.data);
        accesstoken = user.accessToken!;
        return true; // Đăng nhập thành công
      }
      return false;
    } catch (e) {
      print("Lỗi Login: $e");
      return false; // Đăng nhập thất bại
    }
  }

  // Hàm lấy thông tin profile (Giữ nguyên logic của em nhưng thêm null check)
  Future<Userprofile?> getProfile() async {
    var url = "https://dummyjson.com/auth/me";
    var dio = Dio();

    try {
      var options = Options(headers: {
        "Authorization": "Bearer $accesstoken" // Dùng token đã lưu
      });
      
      var response = await dio.get(url, options: options);
      
      if (response.statusCode == 200) {
        return Userprofile.fromJson(response.data);
      }
    } catch (e) {
      print("Lỗi Get Profile: $e");
    }
    return null;
  }
}

// Khởi tạo đối tượng toàn cục để dùng chung
var authApi = LoginApi();