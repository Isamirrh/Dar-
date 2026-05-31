enum EmergencyCategory {
  medical,
  security,
  fire,
  other,
}

enum RiskLevel {
  low,
  medium,
  high,
  critical,
}

class EmergencyAlert {
  final String id;
  final String userId;
  final EmergencyCategory category;
  final RiskLevel riskLevel;
  final String location;
  final DateTime timestamp;
  bool isActive;

  EmergencyAlert({
    required this.id,
    required this.userId,
    required this.category,
    required this.riskLevel,
    required this.location,
    required this.timestamp,
    this.isActive = true,
  });

  factory EmergencyAlert.fromJson(Map<String, dynamic> json) {
    return EmergencyAlert(
      id: json["id"],
      userId: json["userId"],
      category: EmergencyCategory.values.firstWhere((e) => e.toString().split(".").last == json["category"]),
      riskLevel: RiskLevel.values.firstWhere((e) => e.toString().split(".").last == json["riskLevel"]),
      location: json["location"],
      timestamp: DateTime.parse(json["timestamp"]),
      isActive: json["isActive"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "category": category.toString().split(".").last,
      "riskLevel": riskLevel.toString().split(".").last,
      "location": location,
      "timestamp": timestamp.toIso8601String(),
      "isActive": isActive,
    };
  }
}
