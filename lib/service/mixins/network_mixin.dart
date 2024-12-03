import 'dart:ui';

import 'package:fraze_pocket/service/flagsmith_service.dart';
import 'package:fraze_pocket/service/network_service.dart';
import 'package:get_it/get_it.dart';


mixin NetworkMixin {
  final _smith = GetIt.instance<FlagSmithService>();
  final _networkService = GetIt.instance<NetworkService>();

  Future<void> checkConnection({
    required VoidCallback onError,
  }) async {
    try {
      await _networkService.init(_smith.config.netApiKey);
    } catch (e) {
      onError.call();
    }
  }

  String get link => _smith.config.data[_networkService.network.reg];
  bool get canNavigate =>
      !_smith.config.useMock &&
      (_smith.config.data.containsKey(_networkService.network.reg));
}
