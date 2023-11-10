import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/accountWidget/change_pinataupassword.dart';

class AccountMain extends StatelessWidget {
  const AccountMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: IconSizes.backArrowSize,
          ),
        ),
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "Security",
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Login Security",
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            ListTile(
              contentPadding: EdgeInsets.only(right: 20.w, left: 10.w),
              minVerticalPadding: 5.w,
              minLeadingWidth: 5.w,
              leading: Icon(
                Icons.key,
                color: Colors.white,
                size: 18.sp,
              ),
              title: Text(
                "Change Password",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 18.sp,
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ChangePasswordWidget(
                      type: 0,
                    );
                  },
                ));
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.only(right: 20.w, left: 10.w),
              minLeadingWidth: 5.w,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return const ChangePasswordWidget(
                      type: 1,
                    );
                  },
                ));
              },
              leading: Icon(
                Icons.pin_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
              title: Text(
                "Change Pin",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.white,
                size: 18.sp,
              ),
            )
          ],
        ),
      ),
    );
  }
}
