import 'dart:io';

class RequestPriceModel {
  final String name;
  final String phone;
  final String email;
  final String company;
  final String city;
  final String division;
  final String? message;
  final String location;
  final File? attachment;

  RequestPriceModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.company,
    required this.city,
    required this.division,
    required this.location,
    this.message,
    this.attachment,
  });
}
