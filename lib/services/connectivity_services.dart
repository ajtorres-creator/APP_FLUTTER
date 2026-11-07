import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get connectivityStream {
    return _connectivity.onConnectivityChanged;
  }

  Future<List<ConnectivityResult>> checkConnection() async {
    return await _connectivity.checkConnectivity();
  }

  bool hasConnection(List<ConnectivityResult> results) {
    debugPrint('Tipos de conexión detectados: $results');

    return !results.contains(ConnectivityResult.none);
  }

  Future<bool> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('example.com');

      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      debugPrint('No existe acceso a Internet: $e');
      return false;
    } catch (e) {
      debugPrint('Error al comprobar Internet: $e');
      return false;
    }
  }
}
