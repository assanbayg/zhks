// Project imports:
import 'package:zhks/features/auth/data/resident.dart';
import 'package:zhks/features/posts/data/zhk.dart';

class PostUser extends Resident {
  final int id;
  final Zhk zhk;

  PostUser({
    required this.id,
    required super.firstName,
    required super.lastName,
    required super.gender,
    required super.email,
    required super.phoneNumber,
    required this.zhk,
    required super.queue,
    required super.entranceNumber,
    required super.floor,
    required super.apartmentNumber,
  }) : super(zhkId: zhk.id);

  factory PostUser.fromJson(Map<String, dynamic> json) {
    return PostUser(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      zhk: Zhk.fromJson(json['zhk']),
      queue: json['queue'],
      entranceNumber: json['entrance_number'],
      floor: json['floor'],
      apartmentNumber: json['apartment_number'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final baseJson = super.toJson();
    return {...baseJson, 'id': id, 'zhk': zhk.toJson()};
  }

  String get fullName => '$firstName $lastName';
}
