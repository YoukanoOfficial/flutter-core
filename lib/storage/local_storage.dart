import 'dart:ui';

import 'package:flutter_core/flutter_core.dart';

class CoreLocalStorage {
  static CoreLocalStorage? _instance;
  static final storage = GetStorage();

  static CoreLocalStorage get instance {
    _instance ??= CoreLocalStorage();
    return _instance!;
  }

  CoreLocalStorage();

  static Future<void> initialize() async {
    await GetStorage.init();
    listenLanguage();
    listenToken();
    listenBaseUrl();
  }

  static Map<String, dynamic> getAll() {
    final Map<String, dynamic> keyValues = {};
    final keys = storage.getKeys();
    for (String key in keys) {
      keyValues[key] = storage.read(key);
    }
    return keyValues;
  }

  static T? get<T>(String key) {
    return storage.read<T>(key);
  }

  static Future<void> save<T>(String key, T value) {
    return storage.write(key, value);
  }

  static Future<void> saveIfNull<T>(String key, T value) {
    return storage.writeIfNull(key, value);
  }

  static void saveInMemory<T>(String key, T value) {
    return storage.writeInMemory(key, value);
  }

  static Future<void> remove(String key) {
    return storage.remove(key);
  }

  static Future<void> removeAll() async {
    return await storage.erase();
  }

  static VoidCallback listen(
      String key, void Function(dynamic value) callBack) {
    return storage.listenKey(key, (value) {
      callBack(value);
    });
  }

  static void listenLanguage() {
    storage.listenKey(CoreLocalStorageConstants.lang, (value) {
      HttpConfig.setInstance();
    });
  }

  static void listenToken() {
    storage.listenKey(CoreLocalStorageConstants.token, (value) {
      HttpConfig.setInstance();
    });
  }

  static void listenBaseUrl() {
    storage.listenKey(CoreLocalStorageConstants.baseUrl, (value) {
      HttpConfig.setInstance();
    });
  }
}
