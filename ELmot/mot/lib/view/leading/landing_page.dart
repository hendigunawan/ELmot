import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/leading/part/leading_desktop.dart';
import 'package:online_trading/view/leading/part/leading_mobile.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  // void _checkLoggedIn() async {
  void getStockList() {
    ActivityRequest.stockListRequest(packageId: Constans.PACKAGE_ID_STOCK_LIST);
  }

  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
      return const Scaffold(body: SafeArea(child: LeadingDesktop()));
    } else if (Responsive.isMobile(context)) {
      return const Scaffold(body: SafeArea(child: LeadingMobile()));
    } else {
      return Container(
        color: Colors.green,
      );
    }
  }
}
