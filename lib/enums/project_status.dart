enum ProjectStatus {
  future,
  inProgress,
  completed,
}

extension ProjectStatusExtension on ProjectStatus {
  String toJson() {
    switch (this) {
      case ProjectStatus.future:
        return 'مستقبلي';
      case ProjectStatus.inProgress:
        return 'قيد التنفيذ';
      case ProjectStatus.completed:
        return 'مكتمل';
    }
  }

  static ProjectStatus fromJson(String status) {
    switch (status) {
      case 'مستقبلي':
        return ProjectStatus.future;
      case 'قيد التنفيذ':
        return ProjectStatus.inProgress;
      case 'مكتمل':
        return ProjectStatus.completed;
      default:
        throw ArgumentError('Invalid ProjectStatus: $status');
    }
  }
}
