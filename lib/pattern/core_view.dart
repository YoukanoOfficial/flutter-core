import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/empty_widget.dart';
import '../widget/internal_error_widget.dart';
import '../widget/loading_widget.dart';
import '../widget/maintenance_widget.dart';
import '../widget/no_permission_widget.dart';
import '../widget/not_found_widget.dart';
import '../widget/not_internet_widget.dart';
import 'core_status.dart';
import 'core_view_model.dart';


class CoreView<T extends CoreViewModel> extends GetView<T> {
  final Scaffold Function(BuildContext context, T viewModel)? coreAppBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreLoadingBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreEmptyBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreErrorBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreNoInternetBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreNotFoundBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreNoPermissionBuilder;
  final Widget Function(BuildContext context, T viewModel)? coreMaintenanceBuilder;

  final void Function(BuildContext context, T viewModel)? onCoreInit;
  final void Function(BuildContext context, T viewModel)? onCoreDispose;

  const CoreView({
    Key? key,
    this.coreAppBuilder,
    this.coreBuilder,
    this.coreLoadingBuilder,
    this.coreEmptyBuilder,
    this.coreErrorBuilder,
    this.coreNoInternetBuilder,
    this.coreNotFoundBuilder,
    this.coreNoPermissionBuilder,
    this.coreMaintenanceBuilder,

    this.onCoreInit,
    this.onCoreDispose,
  }) : super(key: key);

  Widget coreLoadingWidget(BuildContext context, T controller) {
    return const LoadingWidget();
  }

  Widget coreEmptyWidget(BuildContext context, T controller) {
    return const EmptyWidget();
  }

  Widget coreNoInternetWidget(BuildContext context, T controller) {
    return const NoInternetWidget();
  }

  Widget coreNoPermissionWidget(BuildContext context, T controller) {
    return const NoPermissionWidget();
  }

  Widget coreNotFoundWidget(BuildContext context, T controller) {
    return const NotFoundWidget();
  }

  Widget coreMaintenanceWidget(BuildContext context, T controller) {
    return const MaintenanceWidget();
  }

  Widget coreErrorWidget(BuildContext context, T controller) {
    return const InternalErrorWidget();
  }

  Widget building(BuildContext context, T controller){
    return controller.obx(
      (state) => coreBuilder!(context, controller),
      onLoading: (coreLoadingBuilder ?? coreLoadingWidget).call(context, controller),
      onEmpty: (coreEmptyBuilder ?? coreEmptyWidget).call(context, controller),
      onError: (dynamic status) {
        switch (status) {
          case CoreStatus.NO_INTERNET:
            return (coreNoInternetBuilder ?? coreNoInternetWidget).call(context, controller);
          case CoreStatus.NOT_FOUND:
            return (coreNotFoundBuilder ?? coreNotFoundWidget).call(context, controller);
          case CoreStatus.NO_PERMISSION:
            return (coreNoPermissionBuilder ?? coreNoPermissionWidget).call(context, controller);
          case CoreStatus.MAINTENANCE:
            return (coreMaintenanceBuilder ?? coreMaintenanceWidget).call(context, controller);
          default:
            return (coreErrorBuilder ?? coreErrorWidget).call(context, controller);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {

    onCoreInit?.call(context, controller);

    if(coreAppBuilder == null) return building(context, controller);

    final existingScaffold = coreAppBuilder!(context, controller);

    return existingScaffold.copyWith(
      body: building(context, controller),
    );
  }
}


extension ScaffoldCopyWith on Scaffold {
  Scaffold copyWith({
    PreferredSizeWidget? appBar,
    Widget? floatingActionButton,
    FloatingActionButtonLocation? floatingActionButtonLocation,
    FloatingActionButtonAnimator? floatingActionButtonAnimator,
    List<Widget>? persistentFooterButtons,
    AlignmentDirectional? persistentFooterAlignment,
    Widget? drawer,
    DrawerCallback? onDrawerChanged,
    Widget? endDrawer,
    DrawerCallback? onEndDrawerChanged,
    Widget? bottomNavigationBar,
    Widget? bottomSheet,
    Color? backgroundColor,
    bool? resizeToAvoidBottomInset,
    bool? primary,
    DragStartBehavior? drawerDragStartBehavior,
    bool? extendBody,
    bool? extendBodyBehindAppBar,
    Color? drawerScrimColor,
    double? drawerEdgeDragWidth,
    bool? drawerEnableOpenDragGesture,
    bool? endDrawerEnableOpenDragGesture,
    String? restorationId,
    Widget? body,
  }) {
    return Scaffold(
      appBar: appBar ?? this.appBar,
      floatingActionButton: floatingActionButton ?? this.floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation ?? this.floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator ?? this.floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons ?? this.persistentFooterButtons,
      persistentFooterAlignment: persistentFooterAlignment ?? this.persistentFooterAlignment,
      drawer: drawer ?? this.drawer,
      onDrawerChanged: onDrawerChanged ?? this.onDrawerChanged,
      endDrawer: endDrawer ?? this.endDrawer,
      onEndDrawerChanged: onEndDrawerChanged ?? this.onEndDrawerChanged,
      bottomNavigationBar: bottomNavigationBar ?? this.bottomNavigationBar,
      bottomSheet: bottomSheet ?? this.bottomSheet,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? this.resizeToAvoidBottomInset,
      primary: primary ?? this.primary,
      drawerDragStartBehavior: drawerDragStartBehavior ?? this.drawerDragStartBehavior,
      extendBody: extendBody ?? this.extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar ?? this.extendBodyBehindAppBar,
      drawerScrimColor: drawerScrimColor ?? this.drawerScrimColor,
      drawerEdgeDragWidth: drawerEdgeDragWidth ?? this.drawerEdgeDragWidth,
      drawerEnableOpenDragGesture: drawerEnableOpenDragGesture ?? this.drawerEnableOpenDragGesture,
      endDrawerEnableOpenDragGesture: endDrawerEnableOpenDragGesture ?? this.endDrawerEnableOpenDragGesture,
      restorationId: restorationId ?? this.restorationId,
      body: body ?? this.body,
    );
  }
}