import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sahary_united_company_for_powers/constants/api_constants.dart';
import 'package:sahary_united_company_for_powers/models/project.dart';
import 'package:sahary_united_company_for_powers/models/project_filters.dart';
import 'package:sahary_united_company_for_powers/models/project_response.dart';

class ProjectsRepository {
  Future<ProjectFilters> fetchProjectFilters() async {
    try {
      final String url = ApiConstants.fetchProjectsFilters;
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': ApiConstants.apiKey, 'X-language': 'ar'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ProjectFilters.fromJson(jsonData);
      } else {
        throw Exception('Failed to load project filters');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<ProjectsResponse> fetchProjects() async {
    try {
      final String url = ApiConstants.fetchProjects;
      final response = await http.get(
        Uri.parse(url),
        headers: {'x-api-key': ApiConstants.apiKey},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        return ProjectsResponse.fromJson(jsonData);
      } else {
        throw Exception('Failed to load projects');
      }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<Project>> fetchProjectsData() async {
    try {
      final projectsResponse = await fetchProjects();
      return projectsResponse.data;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}