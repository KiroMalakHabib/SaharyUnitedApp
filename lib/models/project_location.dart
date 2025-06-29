class ProjectLocation {
  final int id;
  final String name;

  ProjectLocation({required this.id, required this.name});

  factory ProjectLocation.fromJson(Map<String, dynamic> json) {
    return ProjectLocation(id: json['id'] as int, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
