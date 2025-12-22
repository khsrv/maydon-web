
// path: lib/src/core/connectivity/connectivity_service.dart
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService(this._connectivity);
  final Connectivity _connectivity;

  Future<bool> get isOnline async {
    final result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Stream<bool> get onStatusChanged async* {
    yield* _connectivity.onConnectivityChanged.map(
      (event) => event != ConnectivityResult.none,
    );
  }
}
