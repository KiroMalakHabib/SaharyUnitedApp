class Division {
  final int id;
  final String? slug;
  final String name;
  final String? image;

  Division({
    required this.id,
    this.slug,
    required this.name,
    this.image,
  });

  factory Division.fromJson(Map<String, dynamic> json) {
    return Division(
      id: json['id'],
      slug: json['slug'] ?? '',
      name: json['name'],
      image: json['image'] ?? '',
    );
  }
}
