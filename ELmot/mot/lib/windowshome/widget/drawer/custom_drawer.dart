import 'package:flutter/material.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/windowshome/widget/drawer/bottom_user_info.dart';
import 'package:online_trading/windowshome/widget/drawer/custom_list_tile.dart';
import 'package:online_trading/windowshome/widget/drawer/header.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

bool isCollapsed = false;

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedContainer(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 500),
        width: isCollapsed ? 300 : 70,
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: bgabu,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomDrawerHeader(isColapsed: isCollapsed),
              const Divider(
                color: Colors.grey,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.home_outlined,
                title: 'Home',
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.calendar_today,
                title: 'Calender',
                infoCount: 0,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.pin_drop,
                title: 'Destinations',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.message_rounded,
                title: 'Messages',
                infoCount: 8,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.cloud,
                title: 'Weather',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.airplane_ticket,
                title: 'Flights',
                infoCount: 0,
                doHaveMoreOptions: Icons.arrow_forward_ios,
              ),
              const Divider(color: Colors.grey),
              const Spacer(),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.notifications,
                title: 'Notifications',
                infoCount: 2,
              ),
              CustomListTile(
                isCollapsed: isCollapsed,
                icon: Icons.settings,
                title: 'Settings',
                infoCount: 0,
              ),
              const SizedBox(height: 10),
              BottomUserInfo(isCollapsed: isCollapsed),
              Align(
                alignment: isCollapsed
                    ? Alignment.bottomRight
                    : Alignment.bottomCenter,
                child: IconButton(
                  splashColor: Colors.transparent,
                  icon: Icon(
                    isCollapsed
                        ? Icons.arrow_back_ios
                        : Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                  onPressed: () {
                    setState(() {
                      isCollapsed = !isCollapsed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
