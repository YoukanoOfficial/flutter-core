import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CorePage {

  static GetPage getPage({
    required String name,
    required GetPageBuilder page,
    String? title,
    bool? participatesInRootNavigator,
    double Function(BuildContext context)? gestureWidth,
    bool maintainState = true,
    Curve curve = Curves.linear,
    Alignment? alignment,
    Map<String, String>? parameters,
    bool opaque = true,
    Duration? transitionDuration,
    bool? popGesture,
    Bindings? binding,
    List<Bindings> bindings = const [],
    Transition? transition,
    CustomTransition? customTransition,
    bool fullscreenDialog = false,
    List<GetPage> children = const <GetPage>[],
    List<GetMiddleware>? middlewares,
    GetPage? unknownRoute,
    Object? arguments,
    bool showCupertinoParallax = true,
    bool preventDuplicates = true,

    bool transparentRoute = false,
  }) {
    // if (transparentRoute) {
    //   return GetPage(
    //     name: name,
    //     binding: binding,
    //     transition: transition ?? Transition.downToUp,
    //     page: () {
    //       // Monitor.instance.putPage(name);
    //       return page();
    //     },
    //   );
    // }
    return GetPage(
      name: name,
      page: () {
        // Monitor.instance.putPage("PageName: $name Transition: $transition");
        return page();
      },
      title: title,
      participatesInRootNavigator: participatesInRootNavigator,
      gestureWidth: gestureWidth,
      maintainState: maintainState,
      curve: curve,
      alignment: alignment,
      parameters: parameters,
      opaque: opaque,
      transitionDuration: transitionDuration,
      popGesture: popGesture,
      binding: binding,
      bindings: bindings,
      transition: transition ?? Transition.rightToLeft,
      customTransition: customTransition,
      fullscreenDialog: fullscreenDialog,
      children: children,
      middlewares: middlewares,
      unknownRoute: unknownRoute,
      arguments: arguments,
      showCupertinoParallax: showCupertinoParallax,
    );
  }

}