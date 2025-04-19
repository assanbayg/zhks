// {
//     "id": 12,
//     "message": "news 1",
//     "created_at": "2024-08-23 20:52:30"

// },

class NewsMessage {
  final int id;
  final String message;
  final String createdAt;

  NewsMessage({
    required this.id,
    required this.message,
    required this.createdAt,
  });

  factory NewsMessage.fromJson(Map<String, dynamic> json) {
    return NewsMessage(
      id: json['id'] as int,
      message: json['message'] as String,
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'message': message, 'created_at': createdAt};
  }
}
