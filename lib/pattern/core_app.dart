import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_ume/flutter_ume.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// import 'package:ume_kit_ui/ume_kit_ui.dart';
// import 'package:ume_kit_perf/ume_kit_perf.dart';
// import 'package:ume_kit_show_code/ume_kit_show_code.dart';
// import 'package:ume_kit_device/ume_kit_device.dart';
// import 'package:ume_kit_console/ume_kit_console.dart';
// import 'package:ume_kit_channel_monitor/ume_kit_channel_monitor.dart';
import 'package:flutter_core/ume/dialogs/environment_dialog.dart';
import 'package:flutter_core/ume/dialogs/language_dialog.dart';
import 'package:flutter_core/ume/dialogs/local_storage_dialog.dart';
import 'package:flutter_core/ume/dialogs/monitor.dart';
import 'package:flutter_core/ume/dialogs/permission_dialog.dart';
import 'package:flutter_core/ume/dialogs/role_dialog.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:ume/ume.dart'
    hide Monitor, MonitorActionWidget, MonitorPlugin, MonitorActionsPlugin;

class CoreApp extends StatelessWidget {
  final Widget materialApp;
  final bool isRefreshConfiguration;
  final bool enabledUme;

  const CoreApp({
    super.key,
    required this.materialApp,
    this.isRefreshConfiguration = false,
    this.enabledUme = true,
  });

  @override
  Widget build(BuildContext context) {
    late Widget child = materialApp;

    if (isRefreshConfiguration) {
      child = RefreshConfiguration(
        headerBuilder: () => const ClassicHeader(),
        footerBuilder: () => const ClassicFooter(),
        headerTriggerDistance: 80.0,
        springDescription: const SpringDescription(
          stiffness: 170,
          damping: 16,
          mass: 1.9,
        ),
        maxOverScrollExtent: 100,
        maxUnderScrollExtent: 100,
        enableScrollWhenRefreshCompleted: true,
        enableLoadingWhenFailed: true,
        hideFooterWhenNotFull: false,
        enableBallisticLoad: true,
        child: child,
      );
    }

    if (!kReleaseMode && enabledUme) {
      PluginManager.instance

        // Monitor
        ..register(MonitorPlugin())
        ..register(MonitorActionsPlugin())

        // Channel monitor
        // ..register(ChannelMonitor())

        // Channel observer
        ..register(ChannelObserver())

        // Clean local data
        ..register(DataCleanPanel())

        // Console
        ..register(Console())

        // Database
        ..register(DatabasePanel(databases: []))

        // Designer check
        ..register(DesignerCheck())

        // Device
        // ..register(CpuInfoPage())
        // ..register(DeviceInfoPanel())

        // Dio
        // ..register(DioInspector(dio: dio))

        // GetConnect
        // ..register(GetConnectInspector(connect: get_connect))

        // Memory detector
        ..register(MemoryDetectorButton())

        // ..register(DBViewer())

        // Perf
        ..register(Performance())
        ..register(MemoryInfoPage())

        // SharedPreferences
        ..register(SharedPreferencesInspector())

        // Show code
        ..register(ShowCode())

        // Slow animation
        ..register(SlowAnimation())
        // UI inspector
        ..register(WidgetInfoInspector())
        ..register(WidgetDetailInspector())
        ..register(ColorSucker())
        ..register(AlignRuler())
        ..register(ColorPicker())
        ..register(TouchIndicator());

      // PluginManager.instance
      //   ..register(const MonitorPlugin())
      //   ..register(const MonitorActionsPlugin())
      //   ..register(const WidgetInfoInspector())
      //   ..register(const WidgetDetailInspector())
      //   ..register(const ColorSucker())
      //   ..register(AlignRuler())
      //   ..register(const ColorPicker())
      //   ..register(const TouchIndicator())
      //   ..register(Performance())
      //   ..register(const ShowCode())
      //   ..register(const MemoryInfoPage())
      //   ..register(CpuInfoPage())
      //   ..register(const DeviceInfoPanel())
      //   ..register(ChannelPlugin())
      //   ..register(Console());
      // ..register(DioInspector(dio: dio));

      Monitor.instance.addActions([
        MonitorActionWidget(
          title: "Environment Page",
          onTap: () {
            Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EnvironmentDialog();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
        MonitorActionWidget(
          title: "Local Storage Page",
          onTap: () {
            Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const LocalStorageDialog();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
        MonitorActionWidget(
          title: "Language Page",
          onTap: () {
            Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const LanguageDialog();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
        MonitorActionWidget(
          title: "Role Page",
          onTap: () {
            Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const RoleDialog();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
        MonitorActionWidget(
          title: "Monitor Page",
          onTap: () {
            Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const MonitorDialog();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
        MonitorActionWidget(
          title: "Permission Page",
          onTap: () {
            Navigator.of(Get.context!).push(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return const PermissionDialog();
                },
                fullscreenDialog: true,
              ),
            );
          },
        ),
      ]);
    }

    return !kReleaseMode && enabledUme
        ? UMEWidget(enable: true, child: child)
        : child;
  }
}
