// Dart imports:
import 'dart:io';

// Project imports:
import 'service.dart';

enum ServiceRequestStatus {
  pending,
  accepted,
  rejected,
  completed;

  String get displayName {
    switch (this) {
      case ServiceRequestStatus.pending:
        return 'Ожидает';
      case ServiceRequestStatus.accepted:
        return 'Принято';
      case ServiceRequestStatus.rejected:
        return 'Отклонено';
      case ServiceRequestStatus.completed:
        return 'Выполнено';
    }
  }

  factory ServiceRequestStatus.fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return ServiceRequestStatus.pending;
      case 'accepted':
        return ServiceRequestStatus.accepted;
      case 'rejected':
        return ServiceRequestStatus.rejected;
      case 'completed':
        return ServiceRequestStatus.completed;
      default:
        return ServiceRequestStatus.pending;
    }
  }
}

// {
//     "data": [
//         {
//             "id": 1,
//             "description": "Мне нужна уборка дома",
//             "requested_date": "2024-08-22",
//             "requested_time": "13:00:00",
//             "service": {
//                 "id": 1,
//                 "name": "Клининг"
//             },
//             "photo": null,
//             "status": "rejected"
//         },
//         ...
//     ]
// }

class ServiceRequest {
  final int? id;
  final int serviceId;
  final Service? service;
  final String? description;
  final DateTime requestedDate;
  final String requestedTime;
  final File? photo;
  final String? photoUrl;
  final ServiceRequestStatus status;

  ServiceRequest({
    this.id,
    required this.serviceId,
    this.service,
    this.description,
    required this.requestedDate,
    required this.requestedTime,
    this.photo,
    this.photoUrl,
    this.status = ServiceRequestStatus.pending,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      id: json['id'],
      serviceId: json['service_id'] ?? json['service']['id'],
      service:
          json['service'] != null ? Service.fromJson(json['service']) : null,
      description: json['description'],
      requestedDate: DateTime.parse(json['requested_date']),
      requestedTime: json['requested_time'],
      photoUrl: json['photo'],
      status:
          json['status'] != null
              ? ServiceRequestStatus.fromString(json['status'])
              : ServiceRequestStatus.pending,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'service_id': serviceId,
      'description': description,
      'requested_date': requestedDate.toIso8601String().split('T')[0],
      'requested_time': requestedTime,
    };
  }

  ServiceRequest copyWith({
    int? id,
    int? serviceId,
    Service? service,
    String? description,
    DateTime? requestedDate,
    String? requestedTime,
    File? photo,
    String? photoUrl,
    ServiceRequestStatus? status,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      serviceId: serviceId ?? this.serviceId,
      service: service ?? this.service,
      description: description ?? this.description,
      requestedDate: requestedDate ?? this.requestedDate,
      requestedTime: requestedTime ?? this.requestedTime,
      photo: photo ?? this.photo,
      photoUrl: photoUrl ?? this.photoUrl,
      status: status ?? this.status,
    );
  }
}
