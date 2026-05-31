import 'package:dar_plus/models/emergency_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class EmergencyService {
  static const String _alertsKey = 'emergencyAlerts';

  Future<void> activateAlert(EmergencyAlert alert) async {
    // Simulate activating an alert. In a real scenario, this would send data to a backend.
    print('Alerta de emergencia activada: ${alert.toJson()}');
    await _saveAlertLocally(alert);
    // TODO: Add integration for Firebase/API REST/Supabase/Custom Backend here
  }

  Future<List<EmergencyAlert>> getActiveAlerts() async {
    final prefs = await SharedPreferences.getInstance();
    final alertsData = prefs.getStringList(_alertsKey);
    if (alertsData != null) {
      return alertsData.map((e) => EmergencyAlert.fromJson(json.decode(e))).where((alert) => alert.isActive).toList();
    }
    return [];
  }

  Future<void> deactivateAlert(String alertId) async {
    final prefs = await SharedPreferences.getInstance();
    List<EmergencyAlert> alerts = await getActiveAlerts();
    final index = alerts.indexWhere((alert) => alert.id == alertId);
    if (index != -1) {
      alerts[index].isActive = false;
      await prefs.setStringList(_alertsKey, alerts.map((e) => json.encode(e.toJson())).toList());
    }
  }

  Future<void> _saveAlertLocally(EmergencyAlert alert) async {
    final prefs = await SharedPreferences.getInstance();
    List<EmergencyAlert> alerts = await getActiveAlerts();
    alerts.add(alert);
    await prefs.setStringList(_alertsKey, alerts.map((e) => json.encode(e.toJson())).toList());
  }
}
