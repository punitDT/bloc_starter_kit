import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class NetworkInfo {
  Future<bool> get isConnected;
}

@LazySingleton(as: NetworkInfo)
final class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._checker);

  final InternetConnection _checker;

  @override
  Future<bool> get isConnected async {
    try {
      return await _checker.hasInternetAccess;
    } on SocketException {
      return false;
    }
  }
}

@module
abstract class NetworkModule {
  @lazySingleton
  InternetConnection internetConnection() =>
      InternetConnection.createInstance();
}
