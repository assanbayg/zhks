class Zhk {
  final int id;
  final String name;

  Zhk({required this.id, required this.name});

  factory Zhk.fromJson(Map<String, dynamic> json) {
    return Zhk(id: json['id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
