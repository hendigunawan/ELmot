import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 5.w,
        right: 5.w,
      ),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 10,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return SizedBox(
                height: 80.h,
                child: Card(
                  color: bgabu,
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Roy ${index + 1}",
                          style: TextStyle(
                              color: Colors.white, fontSize: FontSizes.size13),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Text(
                          "This platform is good",
                          style: TextStyle(
                              color: Colors.white, fontSize: FontSizes.size13),
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
