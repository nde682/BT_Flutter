import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/model/article.dart';
import 'package:flutter_application_1/news_detail.dart';

class MyNews extends StatefulWidget {
  const MyNews({super.key});

  @override
  State<MyNews> createState() => _MyNewsState();
}

class _MyNewsState extends State<MyNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tin Tức 24h"),
        centerTitle: true,
        backgroundColor: Colors.redAccent, // Màu đỏ cho giống báo chí
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100], // Màu nền xám nhẹ
      body: FutureBuilder<List<Article>>(
        future: test_newsApi.getTopHeadlines(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snap.hasError) {
            return Center(child: Text('Lỗi: ${snap.error}'));
          }
          if (!snap.hasData || snap.data!.isEmpty) {
            return const Center(child: Text('Không có tin tức nào'));
          }

          // Hiển thị danh sách
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: snap.data!.length,
            itemBuilder: (context, index) {
              final article = snap.data![index];
              return _buildNewsCard(article);
            },
          );
        },
      ),
    );
  }

  // Tách widget Card ra hàm riêng cho code gọn
  Widget _buildNewsCard(Article article) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => NewsDetail(article),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Ảnh bài viết (có xử lý bo góc và ảnh lỗi)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                        );
                      },
                    )
                  : Container(
                      height: 150, // Chiều cao mặc định nếu không có ảnh
                      color: Colors.grey[200],
                      width: double.infinity,
                      child: const Icon(Icons.newspaper, size: 50, color: Colors.grey),
                    ),
            ),
            
            // 2. Nội dung bài viết
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nguồn tin và thời gian
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.redAccent,
                          borderRadius: BorderRadius.circular(4)
                        ),
                        child: Text(
                          article.name ?? 'News',
                          style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Cắt chuỗi ngày tháng cho gọn (chỉ lấy 10 ký tự đầu: YYYY-MM-DD)
                      Text(
                        (article.publishedAt != null && article.publishedAt!.length > 10) 
                            ? article.publishedAt!.substring(0, 10) 
                            : '',
                        style: const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Tiêu đề
                  Text(
                    article.title ?? '',
                    style: const TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold,
                      height: 1.3
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  
                  const SizedBox(height: 6),
                  
                  // Mô tả ngắn
                  Text(
                    article.description ?? '',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}