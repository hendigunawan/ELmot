import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/view/bottomnavbar/bottomnavbarwidget.dart';
import 'package:online_trading/windowshome/widget/drawer/custom_drawer.dart';
import 'package:online_trading/windowshome/widget/home_dekstop/mainhome_desktop.dart';

class HomeMain extends StatelessWidget {
  const HomeMain({super.key});

  @override
  Widget build(BuildContext context) {
    if (Responsive.isTablet(context) || Responsive.isDesktop(context)) {
      return const Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                children: [
                  CustomDrawer(),
                  Expanded(
                    flex: 10,
                    child: MainHomeDesktop(),
                  ),
                ],
              ),
            ],
          ));
    } else {
      return const BottomNavbarWidget();
    }
  }
}
