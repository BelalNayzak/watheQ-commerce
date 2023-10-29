import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkStatus {
  Future<bool> get isConnected;
}

class NetworkStatusImpl implements NetworkStatus {
  final InternetConnectionChecker internetChecker;

  NetworkStatusImpl({required this.internetChecker});

  @override
  Future<bool> get isConnected => internetChecker.hasConnection;
}
