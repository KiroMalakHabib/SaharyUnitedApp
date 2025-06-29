class ProjectGallery {
  final int id;
  final String url;

  ProjectGallery({
    required this.id,
    required this.url,
  });

  factory ProjectGallery.fromJson(Map<String, dynamic> json) {
    return ProjectGallery(
      id: json['id'] as int,
      url: json['url'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'url': url,
    };
  }
}