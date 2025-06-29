import 'package:sahary_united_company_for_powers/models/project.dart';

class ProjectsResponse {
  final int total;
  final int totalPages;
  final int currentPage;
  final int perPage;
  final List<Project> data;

  ProjectsResponse({
    required this.total,
    required this.totalPages,
    required this.currentPage,
    required this.perPage,
    required this.data,
  });

  factory ProjectsResponse.fromJson(Map<String, dynamic> json) {
    return ProjectsResponse(
      total: json['total'] as int,
      totalPages: json['total_pages'] as int,
      currentPage: json['current_page'] as int,
      perPage: json['per_page'] as int,
      data: (json['data'] as List<dynamic>)
          .map((project) => Project.fromJson(project))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'total_pages': totalPages,
      'current_page': currentPage,
      'per_page': perPage,
      'data': data.map((project) => project.toJson()).toList(),
    };
  }
}
