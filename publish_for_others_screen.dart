import 'package:flutter/material.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/models/beneficiary.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PublishForOthersScreen extends StatefulWidget {
  const PublishForOthersScreen({super.key});

  @override
  State<PublishForOthersScreen> createState() => _PublishForOthersScreenState();
}

class _PublishForOthersScreenState extends State<PublishForOthersScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  BeneficiaryRelationship? _selectedRelationship;
  BeneficiaryNeedType? _selectedNeedType;
  bool _isLoading = false;

  Future<void> _submitBeneficiary() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedRelationship == null || _selectedNeedType == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Por favor selecciona la relación y el tipo de necesidad.')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      final newBeneficiary = Beneficiary(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        relationship: _selectedRelationship!,
        needType: _selectedNeedType!,
        location: _locationController.text,
        description: _descriptionController.text,
        createdAt: DateTime.now(),
      );

      // Simulate saving beneficiary locally
      final prefs = await SharedPreferences.getInstance();
      List<String> beneficiariesJson = prefs.getStringList('beneficiaries') ?? [];
      beneficiariesJson.add(json.encode(newBeneficiary.toJson()));
      await prefs.setStringList('beneficiaries', beneficiariesJson);

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Reporte para otro publicado con éxito.')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Publicar para Otros'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Reporte Externo',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre del beneficiario',
                  hintText: 'Ej: Vecino de la cuadra',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del beneficiario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Vínculo / Relación:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: BeneficiaryRelationship.values.map((relationship) {
                  return ChoiceChip(
                    label: Text(relationship.toString().split('.').last.toUpperCase()),
                    selected: _selectedRelationship == relationship,
                    onSelected: (selected) {
                      setState(() {
                        _selectedRelationship = selected ? relationship : null;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                    backgroundColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                      color: _selectedRelationship == relationship ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              Text(
                'Tipo de Necesidad:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: BeneficiaryNeedType.values.map((needType) {
                  return ChoiceChip(
                    label: Text(needType.toString().split('.').last.toUpperCase()),
                    selected: _selectedNeedType == needType,
                    onSelected: (selected) {
                      setState(() {
                        _selectedNeedType = selected ? needType : null;
                      });
                    },
                    selectedColor: Theme.of(context).primaryColor.withOpacity(0.3),
                    backgroundColor: Theme.of(context).cardColor,
                    labelStyle: TextStyle(
                      color: _selectedNeedType == needType ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium?.color,
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
                  hintText: 'Abrir mapa (funcionalidad futura)',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la ubicación';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Detalles adicionales',
                  hintText: 'Describe la situación...', 
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor describe la situación';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : CustomButton(
                      text: 'Enviar Reporte',
                      onPressed: _submitBeneficiary,
                      icon: Icons.send,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
