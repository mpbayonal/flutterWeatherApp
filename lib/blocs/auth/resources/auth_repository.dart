import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure;

class AuthRepository {
  final _baseUrl = '';
  static final _instance = AuthRepository._internal();
  static final _storage = secure.FlutterSecureStorage();

  factory AuthRepository() {
    return _instance;
  }

  AuthRepository._internal();

  Future<dynamic> logIn({required String email}) async {
    await _storage.write(key: 'email', value: email);
  }

  Future<void> writeToken({required String email}) async {
    await _storage.write(key: 'email', value: email);
  }

  Future<void> logOut() async {
    await _storage.delete(key: 'email');
  }

  Future<bool> checkAuth() async {
    final email = await _storage.read(key: 'email');
    if (email != null) {
      return true;
    } else {
      return false;
    }
  }
}
