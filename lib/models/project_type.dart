class ProjectType {
  final int id;
  final String name;

  ProjectType({required this.id, required this.name});

  factory ProjectType.fromJson(Map<String, dynamic> json) {
    return ProjectType(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
