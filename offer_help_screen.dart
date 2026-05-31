import 'package:flutter/material.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/models/request.dart';
import 'package:dar_plus/data/mock_data.dart';

enum VolunteerSkill {
  food,
  health,
  clothing,
  transport,
  housing,
  education,
  other,
}

class OfferHelpScreen extends StatefulWidget {
  const OfferHelpScreen({super.key});

  @override
  State<OfferHelpScreen> createState() => _OfferHelpScreenState();
}

class _OfferHelpScreenState extends State<OfferHelpScreen> {
  List<VolunteerSkill> _selectedSkills = [];
  bool _isAvailable = true;
  List<Request> _nearbyRequests = [];

  @override
  void initState() {
    super.initState();
    _loadNearbyRequests();
  }

  void _loadNearbyRequests() {
    // Simulate loading nearby requests from mock data
    setState(() {
      _nearbyRequests = MockData.requests.where((req) => req.status == RequestStatus.pending).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ofrecer Ayuda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Mis Capacidades:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 10,
              children: VolunteerSkill.values.map((skill) {
                return FilterChip(
                  label: Text(skill.toString().split('.').last.toUpperCase()),
                  selected: _selectedSkills.contains(skill),
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        _selectedSkills.add(skill);
                      } else {
                        _selectedSkills.remove(skill);
                      }
                    });
                  },
                  selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                  backgroundColor: Theme.of(context).cardColor,
                  labelStyle: TextStyle(
                    color: _selectedSkills.contains(skill) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Estado: ${_isAvailable ? 'Disponible' : 'No Disponible'}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Switch(
                  value: _isAvailable,
                  onChanged: (value) {
                    setState(() {
                      _isAvailable = value;
                    });
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              'Solicitudes Cercanas:',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            _nearbyRequests.isEmpty
                ? const Text('No hay solicitudes cercanas en este momento.')
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _nearbyRequests.length,
                    itemBuilder: (context, index) {
                      final request = _nearbyRequests[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
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
                              const SizedBox(height: 10),
                              CustomButton(
                                text: 'Ayudar',
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Has ofrecido ayuda para ${request.description}')),
                                  );
                                  // Simulate accepting help, remove from list
                                  setState(() {
                                    _nearbyRequests.removeAt(index);
                                  });
                                },
                                backgroundColor: Theme.of(context).hintColor,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
