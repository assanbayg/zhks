// "data": [
//         {
//             "id": 1,
//             "description": "Когда проведем субботник",
//             "document_url": "http://localhost/storage/documents/clS51RtbC1Ptk30kcdaAxwWbHkZmvzO4c8j8TYlR.docx",
//             "end_date": "2024-08-30 14:01:14",
//             "options": [
//                 {
//                     "id": 1,
//                     "option": "Суббота",
//                     "percentage": 0
//                 },
//                 {
//                     "id": 2,
//                     "option": "Воскресенье",
//                     "percentage": 100
//                 }
//             ],
//             "created_at": "2024-08-27 14:01:14"
//         },
//         ...
//     ]

class VoteOption {
  final int id;
  final String option;
  final int percentage;

  VoteOption({
    required this.id,
    required this.option,
    required this.percentage,
  });

  factory VoteOption.fromJson(Map<String, dynamic> json) {
    return VoteOption(
      id: json['id'] as int,
      option: json['option'] as String,
      percentage: json['percentage'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'option': option, 'percentage': percentage};
  }
}

class Vote {
  final int id;
  final String description;
  final String? documentUrl;
  final String endDate;
  final List<VoteOption> options;
  final String createdAt;

  Vote({
    required this.id,
    required this.description,
    this.documentUrl,
    required this.endDate,
    required this.options,
    required this.createdAt,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      id: json['id'] as int,
      description: json['description'] as String,
      documentUrl: json['document_url'] as String?,
      endDate: json['end_date'] as String,
      options:
          (json['options'] as List)
              .map(
                (option) => VoteOption.fromJson(option as Map<String, dynamic>),
              )
              .toList(),
      createdAt: json['created_at'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'document_url': documentUrl,
      'end_date': endDate,
      'options': options.map((option) => option.toJson()).toList(),
      'created_at': createdAt,
    };
  }
}
