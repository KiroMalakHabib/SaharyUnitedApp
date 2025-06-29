import 'package:sahary_united_company_for_powers/models/project_location.dart';
import 'package:sahary_united_company_for_powers/models/project_status.dart';
import 'package:sahary_united_company_for_powers/models/project_type.dart';

class ProjectFilters {
  final List<ProjectLocation> locations;
  final List<ProjectType> types;
  final List<ProjectStatus> statuses;

  ProjectFilters({
    required this.locations,
    required this.types,
    required this.statuses,
  });

  factory ProjectFilters.fromJson(Map<String, dynamic> json) {
    return ProjectFilters(
      locations:
          (json['locations'] as List<dynamic>)
              .map((location) => ProjectLocation.fromJson(location))
              .toList(),
      types:
          (json['types'] as List<dynamic>)
              .map((type) => ProjectType.fromJson(type))
              .toList(),
      statuses:
          (json['statuses'] as List<dynamic>)
              .map((status) => ProjectStatus.fromJson(status))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'locations': locations.map((location) => location.toJson()).toList(),
      'types': types.map((type) => type.toJson()).toList(),
      'statuses': statuses.map((status) => status.toJson()).toList(),
    };
  }
}
