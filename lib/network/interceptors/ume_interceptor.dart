import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ume/flutter_ume.dart';

import '../../ume/utils/convert.dart';
import '../../ume/utils/ume_const.dart';

class UmeInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kReleaseMode) {
      Monitor.instance.put(UmeConst.CURL, convertToCurl(options));
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      Monitor.instance.put(UmeConst.AES_DECODE, convertToAesDecode(response));
    }
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kReleaseMode) {
      Monitor.instance.put(UmeConst.ERROR, convertToError(err));
    }
    return handler.next(err);
  }
}
