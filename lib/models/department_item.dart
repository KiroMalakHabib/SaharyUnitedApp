import 'package:sahary_united_company_for_powers/enums/brands.dart';

class DepartmentItem {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final Brands brand;

  DepartmentItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    required this.brand,
  });

  factory DepartmentItem.fromJson(Map<String, dynamic> json) {
    return DepartmentItem(
      id: json['id'] as int,
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      brand: BrandExtension.fromJson(json['brand'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'description': description,
      'brand': brand.toJson(),
    };
  }
}

