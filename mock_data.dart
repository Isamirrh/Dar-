import 'package:dar_plus/models/request.dart';
import 'package:dar_plus/models/user.dart';
import 'package:dar_plus/models/beneficiary.dart';
import 'package:dar_plus/models/emergency_alert.dart';

class MockData {
  static List<User> users = [
    User(id: '1', name: 'Juan Pérez', email: 'juan.perez@example.com'),
    User(id: '2', name: 'María García', email: 'maria.garcia@example.com'),
  ];

  static List<Request> requests = [
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

  static List<Beneficiary> beneficiaries = [
    Beneficiary(
      id: 'ben1',
      name: 'Vecino de la cuadra',
      relationship: BeneficiaryRelationship.neighbor,
      needType: BeneficiaryNeedType.food,
      location: 'Calle Falsa 123, Springfield',
      description: 'Familia con 3 niños pequeños necesita ayuda con alimentos.',
      createdAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    Beneficiary(
      id: 'ben2',
      name: 'Amigo de la familia',
      relationship: BeneficiaryRelationship.friend,
      needType: BeneficiaryNeedType.housing,
      location: 'Avenida Siempreviva 742, Springfield',
      description: 'Necesita ayuda para encontrar un lugar temporal donde vivir.',
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
  ];

  static List<EmergencyAlert> emergencyAlerts = [
    EmergencyAlert(
      id: 'em1',
      userId: '1',
      category: EmergencyCategory.medical,
      riskLevel: RiskLevel.high,
      location: 'Calle Falsa 123, Springfield',
      timestamp: DateTime.now().subtract(Duration(minutes: 30)),
      isActive: true,
    ),
  ];
}
