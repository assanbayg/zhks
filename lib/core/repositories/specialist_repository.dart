// Project imports:
import '../models/specialist.dart';

class SpecialistRepository {
  Future<List<Specialist>> getAllSpecialists() async {
    return List.generate(5, (i) => Specialist.mock(id: i + 1));
  }

  Future<Specialist> getSpecialistById(int id) async {
    return Specialist.mock(id: id);
  }

  Future<List<Schedule>> getSchedules(int specialistId) async {
    return Specialist.mock(id: specialistId).schedules!;
  }
}
