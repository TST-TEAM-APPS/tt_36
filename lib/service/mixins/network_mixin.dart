import 'dart:ui';

import 'package:fraze_pocket/service/flagsmith_service.dart';
import 'package:fraze_pocket/service/network_service.dart';
import 'package:fraze_pocket/service/shared_service.dart';
import 'package:get_it/get_it.dart';

mixin NetworkMixin {
  final _smith = GetIt.instance<FlagSmithService>();
  final _networkService = GetIt.instance<NetworkService>();
  final _sharedService = GetIt.instance<SharedService>();

  Future<void> checkConnection({
    required VoidCallback onError,
  }) async {
    try {
      await _networkService.init(_smith.config.netApiKey);
    } catch (e) {
      onError.call();
    }
  }

  void saveLastVisit(String url) =>
      _sharedService.setString('lastVisitedUrl', url);

  String loadUrl() {
    final initialLink = _sharedService.getString('initialLink');
    if (initialLink.isEmpty) {
      _sharedService.setString('initialLink', link);
    } else {
      if (link != initialLink) {
        _sharedService.setString('initialLink', link);
        return link;
      }
    }
    final lastVisitedUrl = _sharedService.getString('lastVisitedUrl');
    final url = lastVisitedUrl.isEmpty ? link : lastVisitedUrl;

    return url;
  }

  String get link => _smith.config.data[_networkService.network.reg];
  bool get canNavigate =>
      !_smith.config.useMock &&
      (_smith.config.data.containsKey(_networkService.network.reg));
}
