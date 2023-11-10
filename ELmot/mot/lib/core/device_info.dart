import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

enum FormFactorType { Monitor, SmallPhone, LargePhone, Tablet }

class DeviceOS {
  static bool isIOS = UniversalPlatform.isIOS;
  static bool isAndroid = UniversalPlatform.isAndroid;
  static bool isMacOS = UniversalPlatform.isMacOS;
  static bool isLinux = UniversalPlatform.isLinux;
  static bool isWindows = UniversalPlatform.isWindows;

  static bool isWeb = kIsWeb;
  static bool get isDesktop => isWindows || isMacOS || isLinux;
  static bool get isMobile => isAndroid || isIOS;
  static bool get isDesktopOrWeb => isDesktop || isWeb;
  static bool get isMobileOrWeb => isMobile || isWeb;
}

class DeviceScreen {
  static FormFactorType get(BuildContext context) {
    double shortestSide = MediaQuery.of(context).size.shortestSide;
    if (shortestSide <= 300) return FormFactorType.SmallPhone;
    if (shortestSide <= 600) return FormFactorType.LargePhone;
    if (shortestSide <= 900) return FormFactorType.Tablet;
    return FormFactorType.Monitor;
  }

  static bool isPhone(BuildContext context) =>
      isSmallPhone(context) || isLargePhone(context);
  static bool isTablet(BuildContext context) =>
      get(context) == FormFactorType.Tablet;
  static bool isMonitor(BuildContext context) =>
      get(context) == FormFactorType.Monitor;
  static bool isSmallPhone(BuildContext context) =>
      get(context) == FormFactorType.SmallPhone;
  static bool isLargePhone(BuildContext context) =>
      get(context) == FormFactorType.LargePhone;
}
