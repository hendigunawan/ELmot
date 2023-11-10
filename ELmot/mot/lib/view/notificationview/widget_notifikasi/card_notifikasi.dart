import 'package:flutter/material.dart';
import 'package:online_trading/core/responsive/textsclae.dart';

class WidgetCardNotification extends StatelessWidget {
  const WidgetCardNotification({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int length = 70;
    return SizedBox(
      width: size.width * 0.9,
      height: size.height * length / 700,
      child: ClipRRect(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.2,
            child: const CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/background.jpg'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  SizedBox(
                    width: size.width * 0.65,
                    child: Text(
                      "Your account need to verify before use",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      textScaleFactor: ScaleSize.textScaleFactor(context) / 0.9,
                    ),
                  ),
                  SizedBox(
                    width: size.width * 0.65,
                    child: Text(
                      "Please verify your account, use valid gmail to send verification code. click link below",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                      textScaleFactor: ScaleSize.textScaleFactor(context) / 1,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
