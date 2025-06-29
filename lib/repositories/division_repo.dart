import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';
import 'package:sahary_united_company_for_powers/models/brand.dart';
import 'package:sahary_united_company_for_powers/models/division.dart';
import 'package:sahary_united_company_for_powers/models/product.dart';

class DivisionRepository {
  Future<List<Division>> fetchDivisions() async {
    try {
      final String url = ApiConstants.fetchSections;
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': ApiConstants.apiKey},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Division.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load division');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Product>> fetchProducts({
    int numberOfItems = 10000000000,
    bool hasDivision = false,
    String division = '',
  }) async {
    try {
      final String url =
          ApiConstants.fetchProducts.replaceAll(
            '{number-of-items}',
            numberOfItems.toString(),
          ) +
          (hasDivision ? '&division={division}' : '').replaceAll(
            '{division}',
            division,
          );

      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': ApiConstants.apiKey, 'X-language': 'ar'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)['data'];
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load division');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Brand>> fetchBrands() async {
    final String url = ApiConstants.fetchBrands;
    final response = await http.get(
      Uri.parse(url),
      headers: {'x-api-key': ApiConstants.apiKey},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((json) => Brand.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }
}
