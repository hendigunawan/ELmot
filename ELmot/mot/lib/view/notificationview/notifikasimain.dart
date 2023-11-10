import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/textsclae.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/view/notificationview/widget_notifikasi/card_notifikasi.dart';

class NotifikasiPage extends StatelessWidget {
  const NotifikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ConstantStyle.backgroundhitam,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ConstantStyle.backgroundhitam,
        title: const Text(
          "Notification",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.005,
                    left: size.width * 0.05,
                    right: size.width * 0.05),
                child: Text(
                  "New",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  textScaleFactor: ScaleSize.textScaleFactor(context) / 0.7,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.025,
                      right: size.width * 0.025),
                  child: SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      child: const WidgetCardNotification())),
              Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.025, right: size.width * 0.025),
                  child: SizedBox(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      child: const WidgetCardNotification())),
              Padding(
                padding: EdgeInsets.only(
                    top: size.height * 0.005,
                    left: size.width * 0.05,
                    right: size.width * 0.05),
                child: Text(
                  "Yesterday",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  textScaleFactor: ScaleSize.textScaleFactor(context) / 0.7,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.01,
                      left: size.width * 0.025,
                      right: size.width * 0.025),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 20,
                      itemBuilder: (context, index) {
                        return const WidgetCardNotification();
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
