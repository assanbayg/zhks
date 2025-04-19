// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:zhks/core/api/api_client.dart';
import 'package:zhks/core/api/handle_dio_error.dart';
import 'package:zhks/features/request/data/service.dart';
import 'package:zhks/features/request/data/service_request.dart';

class ServiceRepository {
  final ApiClient _apiClient;
  ServiceRepository(this._apiClient);

  Future<List<Service>> getServices() async {
    final response = await _apiClient.get('/api/services');
    final services =
        (response.data['data'] as List).map((service) {
          return Service.fromJson(service);
        }).toList();
    return services;
  }

  Future<List<ServiceRequest>> getUserServiceRequests() async {
    try {
      final response = await _apiClient.get('/api/service-requests/user');
      final serviceRequests =
          (response.data['data'] as List)
              .map((item) => ServiceRequest.fromJson(item))
              .toList();
      return serviceRequests;
    } on DioException catch (e) {
      throw handleDioError(e);
    }
  }

  // Create service request
  Future<void> createServiceRequest(ServiceRequest request) async {
    // Generate a new ID for the request
    final serviceRequests = await getUserServiceRequests();
    final newId =
        serviceRequests.isNotEmpty
            ? serviceRequests
                    .map((r) => r.id!)
                    .reduce((a, b) => a > b ? a : b) +
                1
            : 1;

    final services = await getServices();
    final service = services.firstWhere((s) => s.id == request.serviceId);

    await _apiClient.post(
      '/api/service-requests',
      data: request.copyWith(id: newId, service: service).toJson(),
    );
  }

  // Delete service request
  Future<void> deleteServiceRequest(int id) async {
    // Find the index of the request with the given ID
    final serviceRequests = await getUserServiceRequests();
    final index = serviceRequests.indexWhere((req) => req.id == id);

    // If found, remove it
    if (index != -1) {
      await _apiClient.delete('/api/service-requests/$id');
    } else {
      throw Exception('Service request not found');
    }
  }
}
