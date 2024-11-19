import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_core/info/constant.dart';

Future<Map<String, dynamic>> getAppVersion() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return {
    AppConstant.appVersion: packageInfo.version,
    AppConstant.appCode: packageInfo.buildNumber,
  };
}
