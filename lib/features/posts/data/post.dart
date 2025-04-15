// Project imports:
import 'package:zhks/features/posts/data/post_user.dart';

enum PostStatus {
  pending,
  rejected,
  accepted;

  String get displayName {
    switch (this) {
      case PostStatus.pending:
        return "В ожидании";
      case PostStatus.rejected:
        return "Отклонено";
      case PostStatus.accepted:
        return "Закрыто";
    }
  }

  factory PostStatus.fromString(String status) {
    switch (status) {
      case "В ожидании":
        return PostStatus.pending;
      case "Отклонено":
        return PostStatus.rejected;
      case "Закрыто":
        return PostStatus.accepted;
      default:
        return PostStatus.pending;
    }
  }
}

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

  Post copyWith({
    int? id,
    PostUser? user,
    String? text,
    String? status,
    List<String>? photos,
    int? likesCount,
    int? commentsCount,
    String? createdAt,
    bool? isLikedByUser,
  }) {
    return Post(
      id: id ?? this.id,
      user: user ?? this.user,
      text: text ?? this.text,
      status: status ?? this.status,
      photos: photos ?? this.photos,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      createdAt: createdAt ?? this.createdAt,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
    );
  }
}
