enum BeneficiaryRelationship {
  known,
  family,
  friend,
  neighbor,
  other,
}

enum BeneficiaryNeedType {
  food,
  health,
  clothing,
  transport,
  housing,
  education,
  employment,
  other,
}

class Beneficiary {
  final String id;
  final String name;
  final BeneficiaryRelationship relationship;
  final BeneficiaryNeedType needType;
  final String location;
  final String description;
  final DateTime createdAt;

  Beneficiary({
    required this.id,
    required this.name,
    required this.relationship,
    required this.needType,
    required this.location,
    required this.description,
    required this.createdAt,
  });

  factory Beneficiary.fromJson(Map<String, dynamic> json) {
    return Beneficiary(
      id: json["id"],
      name: json["name"],
      relationship: BeneficiaryRelationship.values.firstWhere((e) => e.toString().split(".").last == json["relationship"]),
      needType: BeneficiaryNeedType.values.firstWhere((e) => e.toString().split(".").last == json["needType"]),
      location: json["location"],
      description: json["description"],
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "relationship": relationship.toString().split(".").last,
      "needType": needType.toString().split(".").last,
      "location": location,
      "description": description,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
