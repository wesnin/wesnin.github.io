class Book {
  final String id;
  final String title;
  final String author;
  final String description;
  final String status;
  final DateTime createdAt;
  final String userId;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
    };
  }

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      description: json['description'],
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
    );
  }
}