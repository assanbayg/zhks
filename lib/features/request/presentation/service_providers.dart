// Dart imports:
import 'dart:io';

// Package imports:
import 'package:riverpod_annotation/riverpod_annotation.dart';

// Project imports:
import 'package:zhks/features/request/data/service.dart';
import 'package:zhks/features/request/data/service_repository.dart';
import 'package:zhks/features/request/data/service_request.dart';

part 'service_providers.g.dart';

// Provider for the repository itself
@riverpod
ServiceRepository serviceRepository(ref) {
  return ServiceRepository();
}

// Provider for fetching services
@riverpod
Future<List<Service>> services(ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getServices();
}

// Provider for fetching user's service requests
@riverpod
Future<List<ServiceRequest>> userServiceRequests(ref) {
  final repository = ref.watch(serviceRepositoryProvider);
  return repository.getUserServiceRequests();
}

// Provider for managing the current service request form state
@riverpod
class ServiceRequestForm extends _$ServiceRequestForm {
  @override
  ServiceRequest build() {
    // Initialize with default values
    return ServiceRequest(
      serviceId: 1,
      requestedDate: DateTime.now(),
      requestedTime: '13:00',
    );
  }

  // Update service ID
  void updateServiceId(int serviceId) {
    state = state.copyWith(serviceId: serviceId);
  }

  // Update description
  void updateDescription(String description) {
    state = state.copyWith(description: description);
  }

  // Update requested date
  void updateRequestedDate(DateTime date) {
    state = state.copyWith(requestedDate: date);
  }

  // Update requested time
  void updateRequestedTime(String time) {
    state = state.copyWith(requestedTime: time);
  }

  // Update photo
  void updatePhoto(File photo) {
    state = state.copyWith(photo: photo);
  }

  // Reset form
  void reset() {
    state = ServiceRequest(
      serviceId: 1,
      requestedDate: DateTime.now(),
      requestedTime: '13:00',
    );
  }
}

// Provider for submitting the service request
@riverpod
Future<void> submitServiceRequest(ref, ServiceRequest request) async {
  final repository = ref.watch(serviceRepositoryProvider);
  await repository.createServiceRequest(request);

  // Invalidate the userServiceRequests provider to refresh the list
  ref.invalidate(userServiceRequestsProvider);
}

// Provider for deleting a service request
@riverpod
Future<void> deleteServiceRequest(ref, int requestId) async {
  final repository = ref.watch(serviceRepositoryProvider);
  await repository.deleteServiceRequest(requestId);

  // Invalidate the userServiceRequests provider to refresh the list
  ref.invalidate(userServiceRequestsProvider);
}
