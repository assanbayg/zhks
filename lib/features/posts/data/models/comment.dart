// Project imports:
import 'package:zhks/core/data/models/user_profile.dart';

class Comment {
  final int id;
  final UserProfile? user;
  final String text;
  final int likesCount;
  final String createdAt;
  final bool isLikedByUser;

  Comment({
    required this.id,
    required this.user,
    required this.text,
    required this.likesCount,
    required this.createdAt,
    required this.isLikedByUser,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: UserProfile.fromJson(json['user']),
      text: json['text'],
      likesCount: json['likes_count'],
      createdAt: json['created_at'],
      isLikedByUser: json['is_liked_by_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user?.toJson(),
      'text': text,
      'likes_count': likesCount,
      'created_at': createdAt,
      'is_liked_by_user': isLikedByUser,
    };
  }

  Comment copyWith({
    int? id,
    UserProfile? user,
    String? text,
    int? likesCount,
    String? createdAt,
    bool? isLikedByUser,
  }) {
    return Comment(
      id: id ?? this.id,
      user: user ?? this.user,
      text: text ?? this.text,
      likesCount: likesCount ?? this.likesCount,
      createdAt: createdAt ?? this.createdAt,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
    );
  }
}
