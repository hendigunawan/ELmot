import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/getasync.dart';
import 'package:online_trading/core/connection_cek.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/core/rabbitmq/heart_bit.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/irigasi/proses/hendle_error.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/routes_generator.dart';
import 'package:online_trading/screen_controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/tabbar_view/TabBarView1/tabbar_view1.dart';
import 'package:synchronized/synchronized.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Lock lock = Lock();
  await lock.synchronized(() async => ServiceAll().onInit());
  await lock.synchronized(() async => Get.put(ConnectionsController()));
  String getClientTag = Get.find(tag: "buildClientTag");
  InternetChecker internetChecker = InternetChecker();
  await lock.synchronized(() => internetChecker.startMonitoring(getClientTag));
  await lock.synchronized(() => Get.put(LoginControllers()));

  Get.put(ErrorPopup());
  Get.put(ControllerBoard());

  Get.put(LifecycleController());

  if (GetPlatform.isWindows) {
    await windowManager.ensureInitialized();
    WindowManager.instance.setMinimumSize(const Size(512, 384));
    WindowManager.instance.setMaximumSize(const Size(1200, 600));
  }

  runApp(const MainApp());
}

final previousRouteObserver = PreviousRouteObserver();

//add close condisi 24/jun/2023 Hendi
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (ctx, child) {
          ScreenUtil.init(ctx);
          return MaterialApp(
            navigatorKey: Get.key,
            navigatorObservers: [previousRouteObserver],
            onGenerateRoute: RouteGenerator.generateRoute,
            debugShowCheckedModeBanner: false,
            home: const ScreenController(),
          );
        });
  }
}

class LifecycleController extends GetxController with WidgetsBindingObserver {
  Rx<AppLifecycleState> states = AppLifecycleState.resumed.obs;
  @override
  void onInit() {
    super.onInit();
    // Tambahkan observer ke WidgetsBinding
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    // Hapus observer saat controller di-close
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Callback yang akan dipanggil saat aplikasi berpindah antara status hidup dan mati
    if (state == AppLifecycleState.resumed) {
      // Aplikasi dibuka kembali

      if (Get.put(ConnectionsController()).onReadys.value == false) {
        Get.find<ConnectionsController>().initializeConnections();
      }
      states.value = state;
      Get.find<HeartLove>().timestampStartFeedBack = DateTime.now().obs;
      print('Aplikasi dibuka kembali');
    } else if (state == AppLifecycleState.paused) {
      // Aplikasi ditutup
      ConnectionsController().deletequeueReq();
      ConnectionsController().deletequeueOrder();
      ControllerHandelSUB().deleteQueuewhenClose();
      Get.put(ConnectionsController()).onReadys.toggle();
      states.value = state;
      print('Aplikasi ditutup');
    }
  }
}

class PreviousRouteObserver extends NavigatorObserver {
  String? _previousRoute;
  String? _lastCode;
  String? _curentCode;

  String? get previousRoute => _previousRoute;
  String? get lastCode => _lastCode;
  String? get curentCode => _curentCode;

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    try {
      if (route.settings.name != null) {
        Get.find<ControllerHandelSUB>().unBind();
      }
    } catch (e) {
      print(e);
    }
    if (previousRoute is ModalRoute) {
      _previousRoute = previousRoute.settings.name;
      if (_previousRoute == '/' &&
          route.settings.name != null &&
          Get.put(ConnectionsController()).onReadys.value) {
        datas();
      }
      var args = route.settings.arguments;
      if (args is Map<String, String>) {
        _lastCode = args['title'];
      }
      _curentCode = route.settings.name;
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    try {
      if (route.settings.name != null) {
        Get.find<ControllerHandelSUB>().unBind();
      }
    } catch (e) {
      print(e);
    }
    if (route is ModalRoute && previousRoute is ModalRoute) {
      _previousRoute = previousRoute.settings.name;
      var args = route.settings.arguments;
      if (args is Map<String, String>) {
        _lastCode = args['title'];
      }
      _curentCode = route.settings.name;
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute is ModalRoute && oldRoute is ModalRoute) {
      try {
        if (newRoute.settings.name != null) {
          Get.find<ControllerHandelSUB>().unBind();
        }
      } catch (e) {
        print(e);
      }
      _previousRoute = oldRoute.settings.name;
      var args = oldRoute.settings.arguments;
      if (args is Map<String, String>) {
        _lastCode = args['title'];
      }
      _curentCode = oldRoute.settings.name;
    }
  }
}

class LoginControllers extends GetxController {
  var getFind = Get.find<ConnectionsController>();
  var getLoginControl = Get.put(LoginOrderController(), permanent: true).order;

  @override
  void onInit() {
    super.onInit();
    ever(getFind.onReadys, (callback) => validate());
  }

  final lock = Lock();
  void validate() async {
    final SecureStorage store = SecureStorage();
    await lock.synchronized(() async {
      if (getFind.onReadys.value == false) return;
      if (await store.getPassWord() == null &&
          await store.getUserName() == null) {
        return;
      }
      if (getLoginControl!.value.account == null &&
          await store.getPassWord() != null &&
          await store.getUserName() != null) {
        OrderMassage.loginOrder(
          userName: await store.getUserName(),
          passWord: await store.getPassWord(),
        );
      }
    });
  }
}

class SecureStorage {
  // Create storage
  final storage = const FlutterSecureStorage();

  final String _keyUserName = 'username';
  final String _keyPassWord = 'password';

  Future setUserName(String username) async {
    await storage.write(key: _keyUserName, value: username);
  }

  Future<String?> getUserName() async {
    return await storage.read(key: _keyUserName);
  }

  Future setPassWord(String password) async {
    await storage.write(key: _keyPassWord, value: password);
  }

  Future resetPassWord() async {
    await storage.delete(key: _keyPassWord);
  }

  Future<String?> getPassWord() async {
    return await storage.read(key: _keyPassWord);
  }
}
