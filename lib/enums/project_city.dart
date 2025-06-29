enum ProjectCity {
  riyadh,
  jeddah,
  dammam,
  makkah,
  madinah,
  other,
}

extension ProjectCityExtension on ProjectCity {
  String toJson() {
    switch (this) {
      case ProjectCity.riyadh:
        return 'الرياض';
      case ProjectCity.jeddah:
        return 'جدة';
      case ProjectCity.dammam:
        return 'الدمام';
      case ProjectCity.makkah:
        return 'مكة المكرمة';
      case ProjectCity.madinah:
        return 'المدينة المنورة';
      case ProjectCity.other:
        return 'مناطق أخري';
    }
  }

  static ProjectCity fromJson(String city) {
    switch (city) {
      case 'الرياض':
        return ProjectCity.riyadh;
      case 'جدة':
        return ProjectCity.jeddah;
      case 'الدمام':
        return ProjectCity.dammam;
      case 'مكة المكرمة':
        return ProjectCity.makkah;
      case 'المدينة المنورة':
        return ProjectCity.madinah;
      case 'مناطق أخري':
        return ProjectCity.other;
      default:
        throw ArgumentError('Invalid ProjectCity: $city');
    }
  }
}
