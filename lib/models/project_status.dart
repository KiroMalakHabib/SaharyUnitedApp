class ProjectStatus {
  final int id;
  final String name;

  ProjectStatus({required this.id, required this.name});

  factory ProjectStatus.fromJson(Map<String, dynamic> json) {
    return ProjectStatus(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
