import 'package:flutter/material.dart';
import 'package:dar_plus/models/request.dart';
import 'package:dar_plus/repositories/request_repository.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/screens/request_help_screen.dart'; // For editing requests

class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  final RequestRepository _requestRepository = RequestRepository();
  List<Request> _myRequests = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMyRequests();
  }

  Future<void> _loadMyRequests() async {
    setState(() {
      _isLoading = true;
    });
    // Simulate loading requests for the current user
    // In a real app, this would filter by actual userId
    _myRequests = await _requestRepository.getRequests();
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _deleteRequest(String requestId) async {
    await _requestRepository.deleteRequest(requestId);
    _loadMyRequests(); // Reload requests after deletion
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Solicitud eliminada con éxito.')),
    );
  }

  Future<void> _changeRequestStatus(Request request, RequestStatus newStatus) async {
    final updatedRequest = Request(
      id: request.id,
      userId: request.userId,
      category: request.category,
      description: request.description,
      priority: request.priority,
      location: request.location,
      status: newStatus,
      createdAt: request.createdAt,
    );
    await _requestRepository.updateRequest(updatedRequest);
    _loadMyRequests(); // Reload requests after status change
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Estado de solicitud actualizado a ${newStatus.name}.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Solicitudes'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _myRequests.isEmpty
              ? const Center(child: Text('No tienes solicitudes creadas.'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _myRequests.length,
                  itemBuilder: (context, index) {
                    final request = _myRequests[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.category.toString().split('.').last.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(request.description),
                            const SizedBox(height: 5),
                            Text('Ubicación: ${request.location}'),
                            const SizedBox(height: 5),
                            Text('Prioridad: ${request.priority.toString().split('.').last.toUpperCase()}'),
                            const SizedBox(height: 5),
                            Text('Estado: ${request.status.toString().split('.').last.toUpperCase()}'),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                                  onPressed: () {
                                    // TODO: Implement edit functionality, possibly navigate to RequestHelpScreen with pre-filled data
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Funcionalidad de edición no implementada.')),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                                  onPressed: () => _deleteRequest(request.id),
                                ),
                                PopupMenuButton<RequestStatus>(
                                  onSelected: (RequestStatus result) {
                                    _changeRequestStatus(request, result);
                                  },
                                  itemBuilder: (BuildContext context) => <PopupMenuEntry<RequestStatus>>[
                                    const PopupMenuItem<RequestStatus>(
                                      value: RequestStatus.pending,
                                      child: Text('Pendiente'),
                                    ),
                                    const PopupMenuItem<RequestStatus>(
                                      value: RequestStatus.inProgress,
                                      child: Text('En Camino'),
                                    ),
                                    const PopupMenuItem<RequestStatus>(
                                      value: RequestStatus.completed,
                                      child: Text('Completada'),
                                    ),
                                  ],
                                  child: const Icon(Icons.more_vert),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RequestHelpScreen()),
          );
          _loadMyRequests(); // Reload requests after potentially adding a new one
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
