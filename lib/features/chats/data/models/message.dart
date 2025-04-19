// {
//     "sender_type": "user",
//     "sender_id": 3,
//     "message": "hi",
//     "created_at": "2024-08-26 16:42:37"
// },
class Message {
  final String message;
  final String createdAt;
  final String senderType;
  final int? senderId;

  Message({
    required this.message,
    required this.createdAt,
    required this.senderType,
    this.senderId,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      message: json['message'] as String,
      createdAt: json['created_at'] as String,
      senderType: json['sender_type'] ?? 'system',
      senderId: json['sender_id'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'created_at': createdAt,
      'sender_type': senderType,
      'sender_id': senderId,
    };
  }
}
