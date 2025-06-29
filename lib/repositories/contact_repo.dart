import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';

class ContactRepository {
  Future<bool> submitContactMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConstants.contactUs),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': ApiConstants.apiKey,
        },
        body: jsonEncode({
          'your-name': name,
          'your-email': email,
          'your-phone': phone,
          'your-message': message,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Contact message submitted successfully');
        return true;
      } else {
        debugPrint(
          'Failed to submit contact message. Status: ${response.statusCode}',
        );
        debugPrint('Response body: ${response.body}');
        throw Exception(
          'Failed to submit contact message: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error submitting contact message: $e');
      rethrow;
    }
  }
}