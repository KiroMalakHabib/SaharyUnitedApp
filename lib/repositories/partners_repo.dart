import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';
import 'package:sahary_united_company_for_powers/models/partner.dart';

class PartnersRepository {
  Future<List<Partner>> fetchPartners() async {
    try {
      final String url = ApiConstants.fetchPartners;
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': ApiConstants.apiKey, 'X-language': 'ar'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);

        // Convert the JSON array to a list of Partner objects
        final List<Partner> clients =
            jsonData
                .map(
                  (clientJson) =>
                      Partner.fromJson(clientJson as Map<String, dynamic>),
                )
                .toList();

        return clients;
      } else {
        throw Exception('Failed to load Partners: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching Partners: ${e.toString()}');
      rethrow;
    }
  }
}
