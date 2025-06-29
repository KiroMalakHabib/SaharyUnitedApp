import 'department_item.dart'; // If you split them into separate files

class Department {
  final int id;
  final String imageUrl;
  final String name;
  final List<DepartmentItem> items;

  Department({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.items,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      id: json['id'],
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((item) => DepartmentItem.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}
