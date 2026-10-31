import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _connectionKey = 'last_connection_status';

  Future<void> saveConnectionStatus(bool connected) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(_connectionKey, connected);
  }

  Future<bool?> getConnectionStatus() async {
    final preferences = await SharedPreferences.getInstance();

    return preferences.getBool(_connectionKey);
  }
}
