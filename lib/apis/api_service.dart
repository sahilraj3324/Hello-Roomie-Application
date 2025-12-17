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

  Future<Response> login({
    required String contactNumber,
    required String password,
  }) async {
    try {
      final response = await _client.post(
        Endpoints.login,
        data: {'contactNumber': contactNumber, 'password': password},
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getProfile(String profileId) async {
    try {
      final response = await _client.get('${Endpoints.profiles}/$profileId');
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
