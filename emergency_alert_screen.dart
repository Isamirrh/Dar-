import 'package:flutter/material.dart';
import 'package:dar_plus/widgets/custom_button.dart';
import 'package:dar_plus/services/emergency_service.dart';
import 'package:dar_plus/models/emergency_alert.dart';
import 'package:geolocator/geolocator.dart';

class EmergencyAlertScreen extends StatefulWidget {
  const EmergencyAlertScreen({super.key});

  @override
  State<EmergencyAlertScreen> createState() => _EmergencyAlertScreenState();
}

class _EmergencyAlertScreenState extends State<EmergencyAlertScreen> {
  EmergencyCategory? _selectedCategory;
  RiskLevel? _selectedRiskLevel;
  bool _isActivating = false;
  String _currentLocation = 'Obteniendo ubicación...';
  final EmergencyService _emergencyService = EmergencyService();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _currentLocation = 'Servicio de ubicación deshabilitado.';
      });
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _currentLocation = 'Permiso de ubicación denegado.';
        });
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _currentLocation = 'Permiso de ubicación denegado permanentemente.';
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = 'Lat: ${position.latitude}, Lon: ${position.longitude}';
    });
  }

  Future<void> _activateAlert() async {
    if (_selectedCategory == null || _selectedRiskLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor selecciona una categoría y un nivel de riesgo.')),
      );
      return;
    }

    setState(() {
      _isActivating = true;
    });

    final newAlert = EmergencyAlert(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'current_user_id', // TODO: Replace with actual user ID
      category: _selectedCategory!,
      riskLevel: _selectedRiskLevel!,
      location: _currentLocation,
      timestamp: DateTime.now(),
    );

    await _emergencyService.activateAlert(newAlert);

    setState(() {
      _isActivating = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Alerta de emergencia activada con éxito.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayuda Urgente'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Activa una alerta de emergencia',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildCategorySelector(),
            const SizedBox(height: 20),
            _buildRiskLevelSelector(),
            const SizedBox(height: 20),
            Text(
              'Ubicación actual: $_currentLocation',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Spacer(),
            _isActivating
                ? const Center(child: CircularProgressIndicator())
                : CustomButton(
                    text: 'Activar Alerta',
                    onPressed: _activateAlert,
                    icon: Icons.flash_on,
                    backgroundColor: Theme.of(context).hintColor,
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tipo de Emergencia:', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: EmergencyCategory.values.map((category) {
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
      ],
    );
  }

  Widget _buildRiskLevelSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Nivel de Riesgo:', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: RiskLevel.values.map((level) {
            return ChoiceChip(
              label: Text(level.toString().split('.').last.toUpperCase()),
              selected: _selectedRiskLevel == level,
              onSelected: (selected) {
                setState(() {
                  _selectedRiskLevel = selected ? level : null;
                });
              },
              selectedColor: Theme.of(context).hintColor.withOpacity(0.3),
              backgroundColor: Theme.of(context).cardColor,
              labelStyle: TextStyle(
                color: _selectedRiskLevel == level ? Theme.of(context).hintColor : Theme.of(context).textTheme.bodyMedium?.color,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
