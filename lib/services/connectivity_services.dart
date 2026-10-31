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
    return !results.contains(ConnectivityResult.none);
  }
}
