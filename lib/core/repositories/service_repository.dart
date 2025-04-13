/* there are three routes related to service for a client

1. POST api/service-requests/  -> то есть просто отправить заявку

2. GET /api/service-requests/user -> get a list of them

3. DELETE /api/service-requests/{id} -> self-explanatory 

*/

// Project imports:
import '../models/service.dart';
import '../models/service_request.dart';

class ServiceRepository {
  // Dummy data на услуги
  final List<Service> _services = [
    Service(id: 1, name: 'Клининг'),
    Service(id: 2, name: 'Сантехника'),
    Service(id: 3, name: 'Сборка/ремонт мебели'),
    Service(id: 4, name: 'Клейка обоев'),
    Service(id: 5, name: 'Ремонт техники'),
    Service(id: 6, name: 'Другая услуга'),
  ];

  // Dummy data на списки заявок
  final List<ServiceRequest> _serviceRequests = [
    ServiceRequest(
      id: 1,
      serviceId: 1,
      service: Service(id: 1, name: 'Клининг'),
      description: 'Мне нужна уборка дома',
      requestedDate: DateTime(2024, 8, 22),
      requestedTime: '13:00:00',
      status: ServiceRequestStatus.rejected,
    ),
    ServiceRequest(
      id: 2,
      serviceId: 2,
      service: Service(id: 2, name: 'Сантехника'),
      description: 'Протекает кран',
      requestedDate: DateTime(2024, 8, 25),
      requestedTime: '14:00:00',
      status: ServiceRequestStatus.pending,
    ),
  ];

  // Если мы будем грузить их с сервера
  Future<List<Service>> getServices() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _services;
  }

  // 2. GET /api/service-requests/user -> get a list of them
  // Типо грузим их с бэка
  Future<List<ServiceRequest>> getUserServiceRequests() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return _serviceRequests;
  }

  // 1. POST api/service-requests/  -> то есть просто отправить заявку
  // Create service request
  Future<void> createServiceRequest(ServiceRequest request) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 1000));

    // Generate a new ID for the request
    final newId =
        _serviceRequests.isNotEmpty
            ? _serviceRequests
                    .map((r) => r.id!)
                    .reduce((a, b) => a > b ? a : b) +
                1
            : 1;

    // Add the service object
    final service = _services.firstWhere((s) => s.id == request.serviceId);

    // Add the request to our mock database
    _serviceRequests.add(request.copyWith(id: newId, service: service));
  }

  // 3. DELETE /api/service-requests/{id} -> self-explanatory
  // Delete service request
  Future<void> deleteServiceRequest(int id) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 600));

    // Find the index of the request with the given ID
    final index = _serviceRequests.indexWhere((req) => req.id == id);

    // If found, remove it
    if (index != -1) {
      final request = _serviceRequests[index];
      // Check if the request is not accepted (in a real app, this logic would be server-side)
      if (request.status != ServiceRequestStatus.accepted) {
        _serviceRequests.removeAt(index);
      } else {
        throw Exception('Cannot delete an accepted service request');
      }
    } else {
      throw Exception('Service request not found');
    }
  }
}
