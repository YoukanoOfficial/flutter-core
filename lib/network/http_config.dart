import 'package:dio/dio.dart';
import '../info/info.dart';
import '../storage/local_storage.dart';
import '../storage/local_storage_constants.dart';
import '../utils/uuid.dart';
import 'interceptors/ume_interceptor.dart';

class HttpConfig {

  static HttpConfig? _instance;
  static Dio dio = Dio();

  static HttpConfig getInstance() {
    if (_instance == null) {
      setInstance();
    }
    return _instance!;
  }

  static HttpConfig setInstance() {
    _instance = HttpConfig();
    _instance!.initialize();
    return _instance!;
  }

  Future<Dio> initialize() async {
    final String? token = CoreLocalStorage.get<String>(CoreLocalStorageConstants.token);
    String? lang = CoreLocalStorage.get<String>(CoreLocalStorageConstants.lang);
    String? deviceId = CoreLocalStorage.get<String>(CoreLocalStorageConstants.deviceId);

    dio.options.baseUrl = CoreLocalStorage.get<String>(CoreLocalStorageConstants.baseUrl) ?? '';

    // Set connection and receive timeout (in milliseconds)
    dio.options.connectTimeout = const Duration(seconds: 30); // 30 seconds
    dio.options.sendTimeout = const Duration(seconds: 30); // 30 seconds
    dio.options.receiveTimeout = const Duration(seconds: 30); // 30 seconds

    // Enable request/response compression
    dio.options.headers['Accept'] = 'application/json,*/*';
    dio.options.headers['Accept-Encoding'] = 'gzip, deflate';
    dio.options.headers['Content-Type'] = Headers.jsonContentType;
    dio.options.headers['Access-Control-Allow-Origin'] = '*';
    dio.options.headers['Access-Control-Allow-Credentials'] = true;
    dio.options.headers['Access-Control-Allow-Headers'] = 'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale';
    // dio.options.headers['Access-Control-Allow-Methods'] = 'GET, POST, PUT, UPDATE, OPTIONS, HEAD, DELETE';

    // Token
    if(token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    // Language
    if(lang == null) {
      lang = 'en';
      CoreLocalStorage.save(CoreLocalStorageConstants.lang, lang);
    }
    dio.options.headers['lang'] = lang;
    dio.options.headers['language'] = lang;
    dio.options.headers['Accept-Language'] = lang;

    // Device ID
    if(deviceId == null) {
      deviceId = generateUUID();
      CoreLocalStorage.save(CoreLocalStorageConstants.deviceId, deviceId);
    }
    dio.options.headers['device-id'] = deviceId;

    dio.options.headers.addAll(await getDeviceInfo());
    dio.options.headers.addAll(await getAppVersion());

    // Add interceptors for logging and error handling
    dio.interceptors.clear();
    dio.interceptors.add(LogInterceptor());
    dio.interceptors.add(UmeInterceptor());

    return dio;
  }
}