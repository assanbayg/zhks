class Specialist {
  final int id;
  final String name;
  final String phone;
  final String position;
  final String? photo;
  final String whatsappLink;
  final List<Schedule>? schedules;

  Specialist({
    required this.id,
    required this.name,
    required this.phone,
    required this.position,
    required this.photo,
    required this.whatsappLink,
    this.schedules,
  });

  factory Specialist.fromJson(Map<String, dynamic> json) {
    return Specialist(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      position: json['position'],
      photo: json['photo'],
      whatsappLink: json['whatsapp_link'],
      schedules:
          json['schedules'] != null
              ? List<Schedule>.from(
                json['schedules'].map((x) => Schedule.fromJson(x)),
              )
              : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phone': phone,
    'position': position,
    'photo': photo,
    'whatsapp_link': whatsappLink,
    'schedules': schedules?.map((x) => x.toJson()).toList(),
  };
}

class Schedule {
  final int id;
  final String day;
  final String startTime;
  final String endTime;

  Schedule({
    required this.id,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'],
      day: json['day'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'day': day,
    'start_time': startTime,
    'end_time': endTime,
  };
}
