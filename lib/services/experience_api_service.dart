import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hostpool/models/experience_model.dart';

class ExperienceApi {
  final Dio _dio = Dio();
  final  _baseUrl = dotenv.env['API_KEY'] ?? '';

  Future<List<Experience>> fetchExperiences() async {
    try {
      final response = await _dio.get(_baseUrl);
      final data = response.data['data']['experiences'] as List;
      return data.map((json) => Experience.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to fetch experiences: $e');
    }
  }
}