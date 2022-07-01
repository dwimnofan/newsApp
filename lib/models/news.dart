class News {
  String id;
  String title;
  String subTitle;
  String publishedAt;
  String news;
  String imagePath;

  //TODO: dari json ke object news, untuk baca
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        json['id'].toString(),
        json['title'].toString(),
        json['subTitle'].toString(),
        json['publishedAt'].toString(),
        json['news'].toString(),
        json['imagePath'].toString());
  }

  //TODO: dari object ke json, untuk simpan
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'subTitle': subTitle,
        'publishedAt': publishedAt,
        'news': news,
        'imagePath': imagePath
      };

  News(this.id, this.title, this.subTitle, this.publishedAt, this.news,
      this.imagePath);
}
