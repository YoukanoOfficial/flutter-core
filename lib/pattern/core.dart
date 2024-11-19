import 'package:flutter/foundation.dart';

import '../network/http_config.dart';
import '../network/models/environment.dart';
import '../storage/local_storage.dart';
import 'core_global.dart';

class CoreSystem {

  final List<Environment>? environment;

  CoreSystem({
    this.environment,
  }) {
    CoreGlobal.environment = environment ?? [];
  }

  Future<void> initialize() async {
    await CoreLocalStorage.initialize();
    if (environment != null) {
      final length = environment?.length ?? 0;
      for (int i = 0; i < length; i++) {
        final env = environment?[i];
        if (env != null) {
          if (kReleaseMode) {
            env.seleced = env.prodUrl;
            CoreLocalStorage.saveIfNull(env.key, env.prodUrl);
          } else if (kProfileMode) {
            env.seleced = env.testUrl;
            CoreLocalStorage.saveIfNull(env.key, env.testUrl);
          } else {
            env.seleced = env.devUrl;
            CoreLocalStorage.saveIfNull(env.key, env.devUrl);
          }
          print('----------- environment ----------');
        }
      }
    }
          print('----------- HttpConfig ----------');
    await HttpConfig.setInstance();
  }
}