import 'package:dio/dio.dart';
import '../models/profile_request.dart';
import 'api_client.dart';
import 'endpoints.dart';

class ApiService {
  final ApiClient _client = ApiClient();

  Future<Response> registerProfile(ProfileRequest request) async {
    try {
      final response = await _client.post(
        Endpoints.profiles,
        data: request.toJson(),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
