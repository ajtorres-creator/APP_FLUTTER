import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../services/connectivity_services.dart';
import '../services/local_storage_service.dart';

class ConnectivityProvider extends ChangeNotifier {
  final ConnectivityService _connectivityService = ConnectivityService();

  final LocalStorageService _localStorageService = LocalStorageService();

  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _hasConnection = true;
  bool _loading = true;

  bool get hasConnection => _hasConnection;
  bool get loading => _loading;

  // Inicializar la conectividad
  Future<void> initialize() async {
    try {
      final savedStatus = await _localStorageService.getConnectionStatus();

      _hasConnection = savedStatus ?? true;
      _loading = false;
      notifyListeners();

      final results = await _connectivityService.checkConnection();

      _updateStatus(_connectivityService.hasConnection(results));

      await _localStorageService.saveConnectionStatus(_hasConnection);

      _subscription ??= _connectivityService.connectivityStream.listen(
        (results) {
          _updateStatus(_connectivityService.hasConnection(results));
        },
        onError: (error) {
          debugPrint('Error de conectividad: $error');
        },
      );
    } catch (e) {
      debugPrint('Error al inicializar conectividad: $e');
      _hasConnection = false;
      _loading = false;
      notifyListeners();
    }
  }

  // Actualizar estado de conexión
  void _updateStatus(bool connected) {
    if (_hasConnection == connected && !_loading) return;

    _hasConnection = connected;
    _loading = false;

    notifyListeners();

    _saveStatus(connected);
  }

  // Guardar estado localmente
  Future<void> _saveStatus(bool connected) async {
    try {
      await _localStorageService.saveConnectionStatus(connected);
    } catch (e) {
      debugPrint('Error al guardar conexión: $e');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
