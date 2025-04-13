// Project imports:
import 'package:zhks/features/reports/data/report.dart';

// Репозитория. Потому просто связать с Дио чтобы связать с АПИ
class ReportRepository {
  Future<List<FinancialReport>> getFinancialReports() async {
    await Future.delayed(const Duration(milliseconds: 300)); // simulate latency
    return [
      // Тут я попросила у ГПТ сгенерировать мне дамми дэйта
      FinancialReport(
        id: 1,
        date: DateTime(2024, 3, 1),
        amount: -2000,
        description: 'Расходы',
      ),
      FinancialReport(
        id: 2,
        date: DateTime(2024, 3, 15),
        amount: 5000,
        description: 'Платеж за услуги',
      ),
    ];
  }

  Future<List<MonthlyReport>> getMonthlyReports() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return [
      MonthlyReport(
        id: 1,
        title: 'Ежемесячный отчет за Март',
        month: '2024-03',
      ),
      MonthlyReport(
        id: 2,
        title: 'Ежемесячный отчет за Февраль',
        month: '2024-02',
      ),
    ];
  }

  Future<MonthlyReportDetail> getMonthlyReportDetail(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return MonthlyReportDetail(
      id: id,
      title: 'Ежемесячный отчет за Март',
      month: '2024-03',
      houseWorkReports: [
        HouseWorkReport(
          id: 1,
          title: 'Работа сантехника',
          description: 'Ежедневные Т.О водопровода',
          date: DateTime(2024, 3, 1),
          photos: ['https://dummyimage.com/200X120/ff00ff/fff.png'],
        ),
        HouseWorkReport(
          id: 2,
          title: 'Уборка территории',
          description: 'Уборка двора и подъезда',
          date: DateTime(2024, 3, 5),
          photos: ['https://dummyimage.com/200X120/ff00ff/fff.png'],
        ),
      ],
    );
  }
}
