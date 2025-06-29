class Partner {
  final int id;
  final String imageUrl;

  Partner({required this.id, required this.imageUrl});

  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(id: json['id'], imageUrl: json['image_url']);
  }
}
