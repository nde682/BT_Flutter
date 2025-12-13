class Article {
  String? id;
  String? name;
  String? title;
  String? description;
  String? urlToImage;
  String? url;
  String? sourceName;
  String? publishedAt;
  String? content;

  Article({
    this.id,
    this.name,
    this.title,
    this.description,
    this.urlToImage,
    this.url,
    this.publishedAt,
    this.content
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['source']['id'] ?? '',
      name: json['source']['name'] ?? '',
      title: json['title'] ?? 'Không có tiêu đề',
      description: json['description'] ?? 'Không có mô tả',
      // Xử lý ảnh: Nếu null thì trả về null hoặc 1 link ảnh mặc định
      urlToImage: json['urlToImage'], 
      url: json['url'] ?? '',
      // Lấy tên nguồn tin (nested object)
      publishedAt: json['publishedAt'] ?? '',
      content: json['content']
    );
  }
}