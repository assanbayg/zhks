// Project imports:
import 'package:zhks/features/job/data/job.dart';

final mockJobs = [
  Job.fromJson({
    'id': 1,
    'service_request': {
      'id': 2,
      'description': 'Мне нужна уборка дома',
      'requested_date': '2024-08-22',
      'requested_time': '13:00:00',
      'service': {'id': 1, 'name': 'Клининг'},
      'photo': null,
      'status': 'accepted',
    },
    'specialist': {
      'id': 2,
      'name': 'Алексей Алексеев',
      'phone': '+77001112233',
      'photo': null,
      'position': 'Сантехник',
      'whatsapp_link': 'https://wa.me/77001112233',
    },
  }),
  Job.fromJson({
    'id': 2,
    'service_request': {
      'id': 3,
      'description': 'Протекает кран в ванной',
      'requested_date': '2024-08-24',
      'requested_time': '15:00:00',
      'service': {'id': 2, 'name': 'Сантехника'},
      'photo': null,
      'status': 'pending',
    },
    'specialist': {
      'id': 1,
      'name': 'Иван Иванов',
      'phone': '+77009998877',
      'photo': null,
      'position': 'Техник',
      'whatsapp_link': 'https://wa.me/77009998877',
    },
  }),
];
