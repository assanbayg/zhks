// Project imports:
import 'package:zhks/features/request/data/service_request.dart';
import 'package:zhks/features/specialist/data/specialist.dart';

/*
GET /api/jobs

{
    "data": [
        {
            "id": 1,
            "service_request": {
                "id": 2,
                "description": "Мне нужна уборка дома",
                "requested_date": "2024-08-22",
                "requested_time": "13:00:00",
                "service": {
                    "id": 1,
                    "name": "Клининг"
                },
                "photo": null,
                "status": "accepted"
            },
            "specialist": {
                "id": 2,
                "name": "Алексей Алексеев",
                "phone": "+77001112233",
                "photo": null,
                "position": "Сантехник",
                "whatsapp_link": "https://wa.me/77001112233"
            }
        },
        ...
    ]
}
*/

class Job {
  final int id;
  final ServiceRequest serviceRequest;
  final Specialist specialist;

  Job({
    required this.id,
    required this.serviceRequest,
    required this.specialist,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json['id'],
      serviceRequest: ServiceRequest.fromJson(json['service_request']),
      specialist: Specialist.fromJson(json['specialist']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'service_request': serviceRequest.toJson(),
      'specialist': specialist.toJson(),
    };
  }
}
