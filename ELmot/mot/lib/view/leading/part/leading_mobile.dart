import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/register_page.dart';
import 'package:page_transition/page_transition.dart';

class LeadingMobile extends StatelessWidget {
  const LeadingMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 1.sh,
            width: 1.sw,
            child: Column(
              children: [
                Container(
                  width: 1.sw,
                  height: 0.5.sh,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background.jpg'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 270.h,
            child: Container(
              width: 1.sw,
              height: 1.sh,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Colors.blue,
                    Colors.black,
                    Colors.black,
                    Colors.black
                  ],
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.r),
                  topRight: Radius.circular(120.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 30.w, right: 30.w, top: 50.h),
                      child: Text(
                        "Digi",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        "Market",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: Text(
                        "with our mobile app, trade on the move. Now trade in Equity, Derivatives, Commodity from your smartphone. This share market app helps you in executing faster",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 235, 235, 235),
                            fontSize: 17.sp),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          left: 30.w,
                          right: 30.w,
                          top: 30.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                width: 130.w,
                                height: 40.h,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue),
                                    onPressed: () async {
                                      Navigator.of(context).push(
                                        PageTransition(
                                          child: const RegisterView(),
                                          type: PageTransitionType.rightToLeft,
                                          duration:
                                              const Duration(milliseconds: 500),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.sp),
                                    ))),
                            SizedBox(
                                width: 130.w,
                                height: 40.h,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.amber),
                                    onPressed: () async {
                                      Navigator.push(context, MaterialPageRoute(
                                        builder: (context) {
                                          return LoginView();
                                        },
                                      ));
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15.sp),
                                    ))),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
