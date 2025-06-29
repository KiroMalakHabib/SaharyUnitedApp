enum ProjectType {
  landExcavation,
  construction,
  infrastructure,
  industrial,
  agricultural,
}

extension ProjectTypeExtension on ProjectType {
  String toJson() {
    switch (this) {
      case ProjectType.landExcavation:
        return 'حفر وتسوية الأراضي';
      case ProjectType.construction:
        return 'إنشاءات وبناء';
      case ProjectType.infrastructure:
        return 'مشاريع بنية تحتية';
      case ProjectType.industrial:
        return 'مشاريع صناعية';
      case ProjectType.agricultural:
        return 'مشاريع زراعية';
    }
  }

  static ProjectType fromJson(String type) {
    switch (type) {
      case 'حفر وتسوية الأراضي':
        return ProjectType.landExcavation;
      case 'إنشاءات وبناء':
        return ProjectType.construction;
      case 'مشاريع بنية تحتية':
        return ProjectType.infrastructure;
      case 'مشاريع صناعية':
        return ProjectType.industrial;
      case 'مشاريع زراعية':
        return ProjectType.agricultural;
      default:
        throw ArgumentError('Invalid ProjectType: $type');
    }
  }
}
