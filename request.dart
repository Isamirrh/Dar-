enum RequestCategory {
  food,
  health,
  clothing,
  transport,
  housing,
  other,
}

enum RequestPriority {
  low,
  medium,
  high,
  urgent,
}

enum RequestStatus {
  pending,
  inProgress,
  completed,
}

class Request {
  final String id;
  final String userId;
  final RequestCategory category;
  final String description;
  final RequestPriority priority;
  final String location;
  RequestStatus status;
  final DateTime createdAt;

  Request({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    required this.priority,
    required this.location,
    this.status = RequestStatus.pending,
    required this.createdAt,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json["id"],
      userId: json["userId"],
      category: RequestCategory.values.firstWhere((e) => e.toString().split(".").last == json["category"]),
      description: json["description"],
      priority: RequestPriority.values.firstWhere((e) => e.toString().split(".").last == json["priority"]),
      location: json["location"],
      status: RequestStatus.values.firstWhere((e) => e.toString().split(".").last == json["status"]),
      createdAt: DateTime.parse(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "userId": userId,
      "category": category.toString().split(".").last,
      "description": description,
      "priority": priority.toString().split(".").last,
      "location": location,
      "status": status.toString().split(".").last,
      "createdAt": createdAt.toIso8601String(),
    };
  }
}
