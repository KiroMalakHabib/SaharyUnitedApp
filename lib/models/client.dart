class Client {
  final int id;
  final String imageUrl;

  Client({required this.id, required this.imageUrl});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(id: json['id'], imageUrl: json['image_url']);
  }
}
