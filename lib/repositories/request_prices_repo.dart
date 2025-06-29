import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';

class RequestPricesRepository {
  Future<bool> submitQuoteRequest({
    required String name,
    required String email,
    required String phone,
    required String companyName,
    required String city,
    required String division,
    required String location,
    String? message,
    File? file,
  }) async {
    try {
      final String url = ApiConstants.submitQuote;

      var request = http.MultipartRequest('POST', Uri.parse(url));

      request.headers.addAll({'x-api-key': ApiConstants.apiKey});

      request.fields.addAll({
        'your-name': name,
        'your-email': email,
        'your-phone': phone,
        'your-company-name': companyName,
        'your-city': city,
        'your-division': division,
        'your-location': location,
        if (message != null && message.isNotEmpty) 'your-message': message,
      });

      if (file != null) {
        var fileStream = http.ByteStream(file.openRead());
        var length = await file.length();
        var multipartFile = http.MultipartFile(
          'file-568',
          fileStream,
          length,
          filename: file.path.split('/').last,
        );
        request.files.add(multipartFile);
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('Quote request submitted successfully');
        return true;
      } else {
        debugPrint(
          'Failed to submit quote request. Status: ${response.statusCode}',
        );
        debugPrint('Response body: ${response.body}');
        throw Exception(
          'Failed to submit quote request: ${response.statusCode}',
        );
      }
    } catch (e) {
      debugPrint('Error submitting quote request: $e');
      rethrow;
    }
  }
}
