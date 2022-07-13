import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// AppContext contains the NavigatorState of the app.
class AppContext {
  /// [navigatorState] is the NavigatorState of the app.
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey();
}

/// [App] final variable to access the AppContext.
final App = AppContext();

/// [AppExt] is a extension class to access the AppContext.
extension AppExt on AppContext {
  /// [ctx] is the context of the app.
  BuildContext? get ctx => AppContext.navigatorState.currentContext;

  /// [theme] is the theme of the app.
  ThemeData get theme {
    var _theme = ThemeData.fallback();
    if (ctx != null) {
      _theme = Theme.of(ctx!);
    }
    return _theme;
  }

  /// [pixelRatio] is the pixel ratio of the device.
  double get pixelRatio => ui.window.devicePixelRatio;

  /// [size] is the size of the device.
  Size get size => ui.window.physicalSize / pixelRatio;

  /// [width] is the width of the device.
  double get width => size.width;

  /// [height] is the height of the device.
  double get height => size.height;

  /// [columnSpacer] is a Custom Spacer to add space between columns.
  Widget columnSpacer({double? height}) => SizedBox(
    height: height ?? width * 0.05,
  );

  /// [rowSpacer] is a Custom Spacer to add space between rows.
  Widget rowSpacer({double? width}) => SizedBox(
    width: width ?? height * 0.02,
  );

  /// [textTheme] is the text theme of the app.
  TextTheme get textTheme => theme.textTheme;

  /// push is a method to push a new widget.
  /// [page] will be the widget to be pushed.
  Future<dynamic> push(Widget page) =>
      Navigator.of(ctx!).push(MaterialPageRoute(builder: (context) => page));

  /// pushReplacement is a method to push a new widget and replace the current widget.
  /// [page] will be the widget to be replaced.
  Future<dynamic> pushReplacement(Widget page) =>
      Navigator.of(ctx!).pushReplacement(PageRouteBuilder(
          transitionDuration: const Duration(seconds: 2),
          pageBuilder: (context, _, __) => page));

  /// pushAndRemoveUntil is a method to push a new widget and remove all the previous widgets.
  /// [page] will be the widget to be pushed.
  Future<dynamic> pushAndRemoveUntil(Widget page) =>
      Navigator.of(ctx!).pushAndRemoveUntil(
          PageRouteBuilder(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, _, __) => page),
              (_) => false);

  /// pop is a method to pop the current widget.
  /// [result] will pass the data from the previous widget to current widget.
  void pop([Object? result]) => Navigator.of(ctx!).pop(result);
}


