import 'package:fraze_pocket/service/network_service.dart';
import 'package:get_it/get_it.dart';
import 'flagsmith_service.dart';

class ServiceLocator {
  static Future<void> setup() async {
    GetIt.I.registerSingletonAsync<FlagSmithService>(
        () => FlagSmithService().init());
    await GetIt.I.isReady<FlagSmithService>();
    GetIt.I.registerSingleton<NetworkService>(NetworkService());
  }
}
