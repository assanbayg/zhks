// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:zhks/core/presentation/widgets/custom_app_bar.dart';
import 'package:zhks/features/posts/data/post.dart';
import 'package:zhks/features/posts/data/post_user.dart';
import 'package:zhks/features/posts/data/zhk.dart';
import 'package:zhks/features/posts/presentation/widgets/post_widget.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PostUser postUser = PostUser(
      id: 1,
      firstName: 'User',
      lastName: 'fff',
      gender: 'female',
      email: 'user${1}@example.com',
      phoneNumber: '123456789',
      zhk: Zhk(id: 1, name: 'ЖК Сункар'),
      queue: '2',
      entranceNumber: '2',
      floor: '2',
      apartmentNumber: '10',
    );

    return Scaffold(
      // TODO: Add trailing to create new posts
      appBar: CustomAppBar(label: 'ЖК', showBackButton: true, location: '/'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            PostWidget(
              post: Post(
                id: 1,
                user: postUser,
                text:
                    'This is post number with some content about the complex or neighborhood issues.',
                status: 'В ожидании',
                photos: ['https://dummyimage.com/200X120/ff00ff/fff.png'],
                likesCount: 20,
                commentsCount: 15,
                createdAt:
                    DateTime.now()
                        .subtract(Duration(days: 2))
                        .toString()
                        .split(' ')[0],
                isLikedByUser: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
