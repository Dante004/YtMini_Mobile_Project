class Movie {
  final int id;
  final String title;
  final String url;
  final String author;
  final int likes;

  const Movie({
    required this.id,
    required this.title,
    required this.url,
    required this.author,
    required this.likes
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      author: json['author'],
    likes: json['likes']
    );
  }
}