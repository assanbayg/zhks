// Project imports:
import 'package:zhks/features/posts/data/post_user.dart';

class Post {
  final int id;
  final PostUser user;
  final String text;
  final String status;
  final List<String> photos;
  final int likesCount;
  final int commentsCount;
  final String createdAt;
  final bool isLikedByUser;

  Post({
    required this.id,
    required this.user,
    required this.text,
    required this.status,
    required this.photos,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.isLikedByUser,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      user: PostUser.fromJson(json['user']),
      text: json['text'],
      status: json['status'],
      photos: List<String>.from(json['photos'] ?? []),
      likesCount: json['likes_count'],
      commentsCount: json['comments_count'],
      createdAt: json['created_at'],
      isLikedByUser: json['is_liked_by_user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user.toJson(),
      'text': text,
      'status': status,
      'photos': photos,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'created_at': createdAt,
      'is_liked_by_user': isLikedByUser,
    };
  }
}
