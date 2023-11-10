import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/getasync.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/objectbox/model/objectbox_model.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/screen_controller.dart';
import 'package:synchronized/synchronized.dart';

class InternetChecker {
  final Connectivity _connectivity = Connectivity();
  ConnectionsController connectionsController = Get.find();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  static late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Stream<ConnectivityResult> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<void> startMonitoring(String clientTag) async {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.none && isOpen == true) {
        // Tidak ada koneksi internet
        print('Tidak terhubung ke internet');

        connectionsController.onInit();
      } else {
        // Terhubung ke internet
        print('Terhubung ke internet');
        Get.put(CekConnect());
        InfoMobile info = InfoMobile();
        for (var interface in await NetworkInterface.list()) {
          for (var addr in interface.addresses) {
            if (interface.name == 'wlan0') {
              info.ipAddressWifi = addr.address;
            } else {
              info.ipAddressMobile = addr.address;
            }
          }
        }
        info.clientTag = clientTag;
        final openBox = ObjectBoxDatabase.infoMobile;

        var query = openBox.query(InfoMobile_.id.equals(1)).build().findFirst();

        if (query != null) {
          query.clientTag = info.clientTag;
          query.ipAddressMobile = info.ipAddressMobile;
          query.ipAddressWifi = info.ipAddressWifi;

          openBox.putAsync(query);
        } else {
          openBox.putAsync(info);
        }
      }
    });
  }

  Future<void> stopMonitoring() async {
    await _connectivitySubscription.cancel();
  }
}

class CekConnect extends GetxService {
  ConnectionsController getConnect = Get.find();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(getConnect.onReadys, (callback) => getAllData(callback));
  }

  void getAllData(bool isReady) async {
    if (isReady == true) {
      Lock lock = Lock();
      await lock.synchronized(() async => HendelConsume.consumeRequest());
      await lock.synchronized(() async => HendelConsumeOrder.consumeOrder());
      if (getStatus.value == false) {
        done();
      }
      // await lock.synchronized(
      //   () async => Get.putAsync(
      //     () async => LoginControllers(),
      //   ),
      // );
      // Get.put(ControllerHandelSUB()).listSub.clear();
    }
  }

  void done() async {
    Lock lock = Lock();
    final get = GetDataStock();
    await lock.synchronized(() async => await get.getHashKey());
    final box = ObjectBoxDatabase.indexMembers;
    if (box.getAll().isNotEmpty) {
      await lock.synchronized(() async => GetDatas().getMemberUpdate());
    }
  }
}
