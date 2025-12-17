import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// AuthManager handles secure storage of authentication tokens and user data.
/// It uses flutter_secure_storage to persist data securely across app restarts.
class AuthManager {
  static final AuthManager _instance = AuthManager._internal();

  factory AuthManager() => _instance;

  AuthManager._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _profileIdKey = 'profile_id';
  static const String _contactNumberKey = 'contact_number';

  /// Save authentication data after successful login
  Future<void> saveAuthData({
    required String token,
    required String profileId,
    String? contactNumber,
  }) async {
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(key: _profileIdKey, value: profileId);
    if (contactNumber != null) {
      await _storage.write(key: _contactNumberKey, value: contactNumber);
    }
  }

  /// Get the stored auth token
  Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Get the stored profile ID
  Future<String?> getProfileId() async {
    return await _storage.read(key: _profileIdKey);
  }

  /// Get the stored contact number
  Future<String?> getContactNumber() async {
    return await _storage.read(key: _contactNumberKey);
  }

  /// Check if user is logged in (has valid token)
  Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear all auth data (logout)
  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _profileIdKey);
    await _storage.delete(key: _contactNumberKey);
  }

  /// Clear all stored data
  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
