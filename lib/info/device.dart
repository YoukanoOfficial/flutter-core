import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_core/info/constant.dart';

Future<Map<String, dynamic>> getDeviceInfo() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return {
      DeviceConstant.deviceType: OSConstant.android,
      DeviceConstant.deviceModel: androidInfo.model,
      DeviceConstant.deviceVersion: androidInfo.version.release,
      // 'device_code': androidInfo.version.codename,
    };
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return {
      DeviceConstant.deviceType: OSConstant.ios,
      DeviceConstant.deviceModel: iosInfo.model,
      DeviceConstant.deviceVersion: iosInfo.systemVersion,
      // 'device_code': iosInfo.systemName,
    };
  }
  return {};
}
