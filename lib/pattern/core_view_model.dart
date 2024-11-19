import 'package:get/get.dart';
import 'package:flutter_core/pattern/core_view_model_imp.dart';

import 'core_status.dart';

abstract class CoreViewModel extends GetxController
    with StateMixin
    implements CoreViewModelImp {
  void onUpdateLoadingStatus() {
    change([], status: RxStatus.loading());
  }

  void onUpdateLoadingMoreStatus() {
    change([], status: RxStatus.loadingMore());
  }

  void onUpdateSuccessStatus() {
    change([], status: RxStatus.success());
  }

  void onUpdateEmptyStatus() {
    change([], status: RxStatus.empty());
  }

  void onUpdateErrorStatus() {
    change([], status: RxStatus.error());
  }

  void onUpdateNoInternetStatus() {
    change([], status: RxStatus.error(CoreStatus.NO_INTERNET));
  }

  void onUpdateNotFoundStatus() {
    change([], status: RxStatus.error(CoreStatus.NOT_FOUND));
  }

  void onUpdateNoPermissionStatus() {
    change([], status: RxStatus.error(CoreStatus.NO_PERMISSION));
  }

  void onUpdateMaintenanceStatus() {
    change([], status: RxStatus.error(CoreStatus.MAINTENANCE));
  }
}
