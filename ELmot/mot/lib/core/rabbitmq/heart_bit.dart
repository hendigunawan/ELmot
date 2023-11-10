import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';

class HeartLove extends GetxService {
  Rx<DateTime>? timestampStart;
  Rx<DateTime>? timestampStartFeedBack;
  StreamSubscription? timerSubscription;
  StreamSubscription? timerSubscriptionFormServer;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startHeartCheckLoop();
    startHeartCheckLoopFromServer();
  }

  void startHeartCheckLoop() {
    // Memulai loop dengan interval 10 detik
    timerSubscription =
        Stream.periodic(const Duration(milliseconds: 500)).listen((_) {
      cekHeart();
    });
  }

  void startHeartCheckLoopFromServer() {
    // Memulai loop dengan interval 10 detik
    timerSubscriptionFormServer =
        Stream.periodic(const Duration(milliseconds: 500)).listen((_) {
      cekFeedBack();
    });
  }

  void cekFeedBack() {
    if (timestampStartFeedBack == null) {
      timestampStartFeedBack = DateTime.now().obs;
    } else {
      DateTime timestampNow = DateTime.now();
      Duration difference =
          timestampNow.difference(timestampStartFeedBack!.value);

      if (difference.inSeconds >= 15) {
        print(
          "Tidak ada Respon Dari server selama ${difference.inSeconds} detik atau lebih.",
        );
        var s = Get.find<LifecycleController>();
        timestampStartFeedBack = DateTime.now().obs;
        if (s.states.value != AppLifecycleState.paused) {
          NotifikasiPopup.showFAILED(
            'No Internet Access\nPlease Check Your Internet',
            barrierDismissible: false,
            onClose: () {
              // Restart.restartApp();
              Get.find<ConnectionsController>().initializeConnections();
              if (Get.find<ControllerHandelSUB>().saved.value == false) {
                Get.find<ControllerHandelSUB>().saved.toggle();
                Get.find<ControllerHandelSUB>();
              }

              ActivityRequest.heardBeats();
              OrderMassage.heardBeats();
              Get.back();
            },
          );
        } else {
          timestampStartFeedBack = DateTime.now().obs;
        }
      }
    }
  }

  void cekHeart() {
    if (timestampStart == null) {
      timestampStart = DateTime.now().obs;
    } else {
      DateTime timestampNow = DateTime.now();
      Duration difference = timestampNow.difference(timestampStart!.value);

      if (difference.inSeconds >= 10) {
        print(
          "Tidak ada Req Order selama ${difference.inSeconds} detik atau lebih.",
        );
        ActivityRequest.heardBeats();
        OrderMassage.heardBeats();
        timestampStart!.value = DateTime.now();
      }
    }
  }
}
