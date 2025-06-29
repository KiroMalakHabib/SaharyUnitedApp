enum Brands {
  hyundai,
  sany,
  volvo,
  xcmg,
  caterpillar,
  doosan,
  hiab,
  unic,
  ferrari,
  mercedes,
}

extension BrandExtension on Brands {
  String toJson() {
    switch (this) {
      case Brands.hyundai:
        return 'هيونداي';
      case Brands.sany:
        return 'ساني';
      case Brands.volvo:
        return 'فولفو';
      case Brands.xcmg:
        return 'اكس سي لم جي';
      case Brands.caterpillar:
        return 'كتربيلر';
      case Brands.doosan:
        return 'دوسان';
      case Brands.hiab:
        return 'هياب';
      case Brands.unic:
        return 'يونك';
      case Brands.ferrari:
        return 'فيراري';
      case Brands.mercedes:
        return 'مرسيدس';
    }
  }

  static Brands fromJson(String brand) {
    switch (brand) {
      case 'هيونداي':
        return Brands.hyundai;
      case 'ساني':
        return Brands.sany;
      case 'فولفو':
        return Brands.volvo;
      case 'اكس سي لم جي':
        return Brands.xcmg;
      case 'كتربيلر':
        return Brands.caterpillar;
      case 'دوسان':
        return Brands.doosan;
      case 'هياب':
        return Brands.hiab;
      case 'يونك':
        return Brands.unic;
      case 'فيراري':
        return Brands.ferrari;
      case 'مرسيدس':
        return Brands.mercedes;
      default:
        throw ArgumentError('Invalid Brands: $brand');
    }
  }
}
