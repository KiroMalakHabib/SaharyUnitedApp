import 'brand.dart';
import 'division.dart';

class ProductImage {
  final int id;
  final String url;

  ProductImage({required this.id, required this.url});

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      id: json['id'],
      url: json['url'],
    );
  }
}

class Product {
  final int id;
  final String title;
  final List<Brand> brands;
  final List<Division> divisions;
  final String? titleEn;

  // Arabic product details
  final String? brand;
  final String? model;
  final String? categorry;
  final String? year;
  final String? operatinghours;
  final String? carriage;
  final String? weight;
  final String? drillingdepth;
  final String? drillingradius;
  final String? dischargeheight;
  final String? hydropump;
  final String? hoppercapacity;
  final String? generalstandards;
  final String? enginepower;
  final String? gastype;

  // Boolean options
  final bool? warming;
  final bool? airconditioner;
  final bool? tacometer;
  final bool? frontheadlights;
  final bool? foglights;
  final bool? regularhooper;
  final bool? video;

  final String? howtouse;

  final List<ProductImage> gallery;

  Product({
    required this.id,
    required this.title,
    required this.brands,
    required this.divisions,
    this.titleEn,
    this.brand,
    this.model,
    this.categorry,
    this.year,
    this.operatinghours,
    this.carriage,
    this.weight,
    this.drillingdepth,
    this.drillingradius,
    this.dischargeheight,
    this.hydropump,
    this.hoppercapacity,
    this.generalstandards,
    this.enginepower,
    this.gastype,
    this.warming,
    this.airconditioner,
    this.tacometer,
    this.frontheadlights,
    this.foglights,
    this.regularhooper,
    this.video,
    this.howtouse,
    this.gallery = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      brands: (json['brands'] as List).map((e) => Brand.fromJson(e)).toList(),
      divisions:
          (json['divisions'] as List).map((e) => Division.fromJson(e)).toList(),
      titleEn: json['title_en'],

      brand: json['brand'],
      model: json['model'],
      categorry: json['categorry'],
      year: json['year'],
      operatinghours: json['operatinghours'],
      carriage: json['carriage'],
      weight: json['weight'],
      drillingdepth: json['drillingdepth'],
      drillingradius: json['drillingradius'],
      dischargeheight: json['dischargeheight'],
      hydropump: json['hydropump'],
      hoppercapacity: json['hoppercapacity'],
      generalstandards: json['generalstandards'],
      enginepower: json['enginepower'],
      gastype: json['gastype'],

      warming: json['warming'],
      airconditioner: json['airconditioner'],
      tacometer: json['tacometer'],
      frontheadlights: json['frontheadlights'],
      foglights: json['foglights'],
      regularhooper: json['regularhooper'],
      video: json['video'],
      howtouse: json['howtouse'],

      gallery: (json['gallery'] as List<dynamic>?)
              ?.map((e) => ProductImage.fromJson(e))
              .toList() ??
          [],
    );
  }
}
