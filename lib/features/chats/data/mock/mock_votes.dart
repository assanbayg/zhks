// Project imports:
import 'package:zhks/features/chats/data/models/vote.dart';

final mockVotes = [
  Vote(
    id: 1,
    description: 'Когда проведем субботник?',
    documentUrl: 'http://localhost/storage/documents/somefile.docx',
    endDate: '2024-08-30 14:01:14',
    createdAt: '2024-08-27 14:01:14',
    options: [
      VoteOption(id: 1, option: 'Суббота', percentage: 0),
      VoteOption(id: 2, option: 'Воскресенье', percentage: 100),
    ],
  ),
  Vote(
    id: 2,
    description: 'Выбор даты ремонта лифта',
    documentUrl: null,
    endDate: '2025-04-22 10:00:00',
    createdAt: '2025-04-18 09:00:00',
    options: [
      VoteOption(id: 3, option: '1 сентября', percentage: 30),
      VoteOption(id: 4, option: '5 сентября', percentage: 70),
    ],
  ),
];
