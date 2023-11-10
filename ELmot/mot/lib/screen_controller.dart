// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/view/leading/part/leading_mobile.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/windowshome/mainhome.dart';

RxBool getStatus = false.obs;

class ScreenController extends StatefulWidget {
  const ScreenController({super.key});

  @override
  State<ScreenController> createState() => _ScreenControllerState();
}

enum AppStatus { active, inactive, background }

bool isOpen = true;

class _ScreenControllerState extends State<ScreenController> {
  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  void onOpen() async {
    debugPrint('-------- open --------');

    if (Get.put(ConnectionsController()).onReadys.value == false) {
      Get.find<ConnectionsController>().initializeConnections();
    }

    getStatus.value = Get.find(tag: "getStatusLogin");

    Timer(
      Duration(seconds: 2),
      () async {
        if (await hasNetwork()) {
          if (getStatus.value == false) {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return LeadingMobile();
              },
            ));
          }
        } else {
          NotifikasiPopup.showFAILED(
            'No Internet Access\nPlease Chack Your Internet',
            barrierDismissible: false,
            onClose: () {
              if (Platform.isIOS) {
                try {
                  exit(0);
                } catch (e) {
                  SystemNavigator.pop();
                }
              } else {
                try {
                  SystemNavigator.pop();
                } catch (e) {
                  exit(0);
                }
              }
            },
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    onOpen();
    // Future.delayed(Duration.zero, () {
    //   getStatus.value = Get.find(tag: "getStatusLogin");
    // });
    //
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context) || Responsive.isTablet(context)) {
      return const HomeMain();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: Center(
          child: Image.asset('assets/logo.png', scale: 2.sp),
        ),
      ),
    );
    // return Obx(() {
    //   return getStatus.value == false ? const SplashView() : const HomeMain();
    // });
  }
}
