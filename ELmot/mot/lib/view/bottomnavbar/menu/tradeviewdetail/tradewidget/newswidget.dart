import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';

class NewsWidget extends StatelessWidget {
  const NewsWidget({super.key});

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
                          "BCA gelontorkan dana 1 triliun",
                          style: TextStyle(
                              color: Colors.white, fontSize: FontSizes.size13),
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Source : Bisnis.com",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size12),
                            ),
                            Text(
                              "AM 9:10, 4 Des 2023",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ));
          }),
    );
  }
}
