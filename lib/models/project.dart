import 'package:sahary_united_company_for_powers/models/project_gallary.dart';

class Project {
  final int id;
  final String title;
  final String type;
  final String location;
  final String machineryUsed;
  final String target;
  final String period;
  final String text1;
  final String text2;
  final String text3;
  final List<ProjectGallery> gallery;
  final bool video;
  final String status;

  Project({
    required this.id,
    required this.title,
    required this.type,
    required this.location,
    required this.machineryUsed,
    required this.target,
    required this.period,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.gallery,
    required this.video,
    required this.status,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] as int,
      title: json['title'] as String,
      type: json['type'] as String,
      location: json['location'] as String,
      machineryUsed: json['machineryused'] as String,
      target: json['target'] as String,
      period: json['period'] as String,
      text1: json['text_1'] as String,
      text2: json['text_2'] as String,
      text3: json['text_3'] as String,
      gallery: (json['gallery'] as List<dynamic>)
          .map((gallery) => ProjectGallery.fromJson(gallery))
          .toList(),
      video: json['video'] as bool,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'type': type,
      'location': location,
      'machineryused': machineryUsed,
      'target': target,
      'period': period,
      'text_1': text1,
      'text_2': text2,
      'text_3': text3,
      'gallery': gallery.map((g) => g.toJson()).toList(),
      'video': video,
      'status': status,
    };
  }

  // Helper getter for the main image URL
  String get imageUrl {
    return gallery.isNotEmpty ? gallery.first.url : '';
  }

  // Helper getter for project name (using title)
  String get projectName => title;
}
