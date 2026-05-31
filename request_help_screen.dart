import 'package:flutter/material.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/models/request.dart';
import 'package:dar_plus/repositories/request_repository.dart';

class RequestHelpScreen extends StatefulWidget {
  const RequestHelpScreen({super.key});

  @override
  State<RequestHelpScreen> createState() => _RequestHelpScreenState();
}

class _RequestHelpScreenState extends State<RequestHelpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  RequestCategory? _selectedCategory;
  RequestPriority _selectedPriority = RequestPriority.medium; // Default priority
  bool _isLoading = false;

  final RequestRepository _requestRepository = RequestRepository();

  Future<void> _submitRequest() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor selecciona una categoría.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final newRequest = Request(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: 'current_user_id', // TODO: Replace with actual user ID
        category: _selectedCategory!,
        description: _descriptionController.text,
        priority: _selectedPriority,
        location: _locationController.text,
        createdAt: DateTime.now(),
      );

      await _requestRepository.saveRequest(newRequest);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Solicitud de ayuda publicada con éxito.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar Ayuda'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                '¿Qué necesitas?',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: RequestCategory.values.map((category) {
                  return ChoiceChip(
                    label: Text(category.toString().split('.').last.toUpperCase()),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? category : null;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                    backgroundColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                      color: _selectedCategory == category ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Detalla tu necesidad aquí...', 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor describe tu necesidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Prioridad:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: RequestPriority.values.map((priority) {
                  return ChoiceChip(
                    label: Text(priority.toString().split('.').last.toUpperCase()),
                    selected: _selectedPriority == priority,
                    onSelected: (selected) {
                      setState(() {
                        _selectedPriority = priority;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                    backgroundColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                      color: _selectedPriority == priority ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Ubicación',
                  prefixIcon: Icon(Icons.location_on),
                  hintText: 'Ej: Calle Principal #456',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa tu ubicación';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Publicar Solicitud',
                      onPressed: _submitRequest,
                      icon: Icons.send,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
