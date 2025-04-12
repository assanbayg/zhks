// классы для всех отчетов
// у меня голова устала от англа 😭😭😭

// 1 финансовые
class FinancialReport {
  final int id;
  final DateTime date;
  final double amount;
  final String description;

  FinancialReport({
    required this.id,
    required this.date,
    required this.amount,
    required this.description,
  });

  factory FinancialReport.fromJson(Map<String, dynamic> json) {
    return FinancialReport(
      id: json['id'],
      date: DateTime.parse(json['date']),
      amount: double.tryParse(json['amount'].toString()) ?? 0.0,
      description: json['description'],
    );
  }
}

// 2 ежемесячные и реально мини
class MonthlyReport {
  final int id;
  final String title;
  final String month;

  MonthlyReport({required this.id, required this.title, required this.month});

  factory MonthlyReport.fromJson(Map<String, dynamic> json) {
    return MonthlyReport(
      id: json['id'],
      title: json['title'],
      month: json['month'],
    );
  }
}

// 3 тут короче на каждую услугу отчет
class HouseWorkReport {
  final int id;
  final String title;
  final String description;
  final DateTime date;
  final List<String> photos;

  HouseWorkReport({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.photos,
  });

  factory HouseWorkReport.fromJson(Map<String, dynamic> json) {
    return HouseWorkReport(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      date: DateTime.parse(json['date']),
      photos: List<String>.from(json['photos'] ?? []),
    );
  }
}

// 4 сборник этих услуг
class MonthlyReportDetail {
  final int id;
  final String title;
  final String month;
  final List<HouseWorkReport> houseWorkReports;

  MonthlyReportDetail({
    required this.id,
    required this.title,
    required this.month,
    required this.houseWorkReports,
  });

  factory MonthlyReportDetail.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return MonthlyReportDetail(
      id: data['id'],
      title: data['title'],
      month: data['month'],
      houseWorkReports:
          (data['house_work_reports'] as List)
              .map((e) => HouseWorkReport.fromJson(e))
              .toList(),
    );
  }
}
