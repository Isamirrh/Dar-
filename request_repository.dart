import 'package:dar_plus/models/request.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RequestRepository {
  static const String _requestsKey = 'requests';

  Future<List<Request>> getRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final requestsData = prefs.getStringList(_requestsKey);
    if (requestsData != null) {
      return requestsData.map((e) => Request.fromJson(json.decode(e))).toList();
    }
    return [];
  }

  Future<void> saveRequest(Request request) async {
    final prefs = await SharedPreferences.getInstance();
    List<Request> requests = await getRequests();
    // Remove existing request if updating
    requests.removeWhere((r) => r.id == request.id);
    requests.add(request);
    await prefs.setStringList(_requestsKey, requests.map((e) => json.encode(e.toJson())).toList());
  }

  Future<void> updateRequest(Request updatedRequest) async {
    final prefs = await SharedPreferences.getInstance();
    List<Request> requests = await getRequests();
    final index = requests.indexWhere((r) => r.id == updatedRequest.id);
    if (index != -1) {
      requests[index] = updatedRequest;
      await prefs.setStringList(_requestsKey, requests.map((e) => json.encode(e.toJson())).toList());
    }
  }

  Future<void> deleteRequest(String requestId) async {
    final prefs = await SharedPreferences.getInstance();
    List<Request> requests = await getRequests();
    requests.removeWhere((r) => r.id == requestId);
    await prefs.setStringList(_requestsKey, requests.map((e) => json.encode(e.toJson())).toList());
  }

  // Mock data for initial testing
  Future<void> initMockRequests() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(_requestsKey)) {
      final mockRequests = [
        Request(
          id: 'req1',
          userId: '1',
          category: RequestCategory.food,
          description: 'Necesito alimentos no perecederos para mi familia.',
          priority: RequestPriority.high,
          location: 'Calle Falsa 123, Springfield',
          status: RequestStatus.pending,
          createdAt: DateTime.now().subtract(Duration(days: 2)),
        ),
        Request(
          id: 'req2',
          userId: '1',
          category: RequestCategory.health,
          description: 'Necesito transporte para una cita médica.',
          priority: RequestPriority.medium,
          location: 'Avenida Siempreviva 742, Springfield',
          status: RequestStatus.inProgress,
          createdAt: DateTime.now().subtract(Duration(days: 1)),
        ),
        Request(
          id: 'req3',
          userId: '2',
          category: RequestCategory.clothing,
          description: 'Ropa de abrigo para niños.',
          priority: RequestPriority.low,
          location: 'Calle de la Alegría 1, Springfield',
          status: RequestStatus.completed,
          createdAt: DateTime.now().subtract(Duration(hours: 5)),
        ),
      ];
      await prefs.setStringList(_requestsKey, mockRequests.map((e) => json.encode(e.toJson())).toList());
    }
  }
}
