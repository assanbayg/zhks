  // TODO: replace with factory once I resolve that stupid 'Missing concrete implementation' bug
// I used the old way instead of freezed because I got tired of debugging it for 6+ hours 

class Resident {
  final String firstName;
  final String lastName;
  final String gender;
  final String email;
  final String phoneNumber;
  final int zhkId;
  final String queue;
  final String entranceNumber;
  final String floor;
  final String apartmentNumber;

  Resident({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.zhkId,
    required this.queue,
    required this.entranceNumber,
    required this.floor,
    required this.apartmentNumber,
  });

  @override
  String toString() {
    return 'Resident('
        'firstName: $firstName, '
        'lastName: $lastName, '
        'gender: $gender, '
        'email: $email, '
        'phoneNumber: $phoneNumber, '
        'zhkId: $zhkId, '
        'queue: $queue, '
        'entranceNumber: $entranceNumber, '
        'floor: $floor, '
        'apartmentNumber: $apartmentNumber'
        ')';
  }

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
    firstName: json['first_name'],
    lastName: json['last_name'],
    gender: json['gender'],
    email: json['email'],
    phoneNumber: json['phone_number'],
    zhkId: json['zhk_id'],
    queue: json['queue'],
    entranceNumber: json['entrance_number'],
    floor: json['floor'],
    apartmentNumber: json['apartment_number'],
  );

  Map<String, dynamic> toJson() => {
    'first_name': firstName,
    'last_name': lastName,
    'gender': gender,
    'email': email,
    'phone_number': phoneNumber,
    'zhk_id': zhkId,
    'queue': queue,
    'entrance_number': entranceNumber,
    'floor': floor,
    'apartment_number': apartmentNumber,
  };
}
