// Project imports:
import 'package:zhks/features/chats/data/models/message.dart';

final List<Message> mockMessages = [
  Message(
    message: 'Привет! Когда будет следующая встреча?',
    createdAt: '2024-08-26 16:42:37',
    senderType: 'user',
    senderId: 3,
  ),
  Message(
    message: 'Завтра в 19:00 в общем чате обсудим.',
    createdAt: '2024-08-26 16:45:00',
    senderType: 'admin',
    senderId: 1,
  ),
  Message(
    message: 'Система обновлена до версии 1.4.3',
    createdAt: '2024-08-26 17:00:00',
    senderType: 'admin',
    senderId: null,
  ),
  Message(
    message: 'Ок, буду на встрече!',
    createdAt: '2024-08-26 17:10:15',
    senderType: 'user',
    senderId: 5,
  ),
  Message(
    message: 'Пожалуйста, не забудьте проверить голосование.',
    createdAt: '2024-08-27 08:22:01',
    senderType: 'admin',
    senderId: 1,
  ),
  Message(
    message: 'Новый документ был добавлен в раздел «Финансы».',
    createdAt: '2024-08-27 09:00:00',
    senderType: 'admin',
    senderId: null,
  ),
  Message(
    message: 'Голосование завершится завтра.',
    createdAt: '2024-08-28 11:30:00',
    senderType: 'admin',
    senderId: null,
  ),
];
