import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/article.dart';

class NewsDetail extends StatelessWidget {
  // Biến để hứng dữ liệu truyền sang
  final Article article;

  const NewsDetail(article, {super.key}) : this.article = article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Cho phép nội dung tràn lên status bar nhìn cho đẹp
      body: CustomScrollView(
        slivers: [
          // 1. App Bar co giãn có ảnh nền
          SliverAppBar(
            expandedHeight: 300.0, // Chiều cao ảnh bìa
            floating: false,
            pinned: true, // Ghim thanh Appbar khi cuộn xuống
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: article.urlToImage != null
                  ? Image.network(
                      article.urlToImage!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: Colors.grey, child: const Icon(Icons.broken_image)),
                    )
                  : Container(color: Colors.redAccent, child: const Icon(Icons.newspaper, size: 80, color: Colors.white)),
            ),
          ),
          
          // 2. Nội dung chi tiết
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nguồn tin và ngày tháng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Chip(
                        label: Text(article.sourceName ?? 'News', style: const TextStyle(color: Colors.white)),
                        backgroundColor: Colors.redAccent,
                      ),
                      Text(
                        (article.publishedAt != null && article.publishedAt!.length > 10)
                            ? article.publishedAt!.substring(0, 10)
                            : '',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  // Tiêu đề lớn
                  Text(
                    article.title ?? '',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Phần mô tả (Description)
                  Text(
                    article.description ?? '',
                    style: const TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),

                  // Nội dung chính (Content)
                  // Lưu ý: API miễn phí thường chỉ trả về 1 đoạn ngắn của content
                  Text(
                    article.content ?? 'Không có nội dung chi tiết. Vui lòng đọc tiêu đề và mô tả.',
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Nút đọc bản đầy đủ (Demo)
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Sau này em có thể dùng url_launcher để mở trình duyệt
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Chức năng mở trình duyệt đang phát triển')),
                        );
                      },
                      icon: const Icon(Icons.language),
                      label: const Text('Đọc bài viết gốc trên Web'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}