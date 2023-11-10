// ignore_for_file: must_be_immutable

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/mainaccountSettings.dart';
import 'package:online_trading/view/bottomnavbar/maincheckout_frombotttomview.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'menu/homeview_widget/homeview.dart';

RxInt bottomindex = 0.obs;

Widget bottomNavBarItems(int index) {
  // Clear Anything bout checkout

  // end
  if (index == 0) {
    return const HomeView();
  } else if (index == 1) {
    var a = previousRouteObserver.lastCode;
    var query = ObjectBoxDatabase.StockCodeRangking.query(
      StockData_.reqType.equals(1) & StockData_.iBoard.equals(0),
    ).build().findFirst();
    var stockCode = a ??
        (query == null || query.arrayData.isEmpty
            ? 'ANTM'
            : query.arrayData.first.stockCode);

    fokusNode = FocusNode();
    return MainCheckOutFromBottomView(
      title: stockCode!,
      subtitle: "",
      typeCheckout: "BUY",
      prevP: 0,
    );
  } else {
    return const AccountView();
  }
}

class BottomNavbarWidget extends StatelessWidget {
  const BottomNavbarWidget({super.key});

  void ontapIndex(int index) async {
    if (index != bottomindex.value) {
      bottomindex.value = index;

      if (index != 1) {
        if (!Get.isRegistered<BodyController>()) {
          Get.put(BodyController()).onClear();
          Get.put(PinSave()).onPop();
        } else {
          Get.find<BodyController>().onClear();
          Get.find<PinSave>().onPop();
        }

        isMore.value = false;
        listTradeList.clear();
      } else if (index == 1 || index == 2) {
        Get.find<ControllerHandelSUB>().unBind();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () {
            return bottomNavBarItems(bottomindex.value);
          },
        ),
        bottomNavigationBar: Obx(() {
          return ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 10.0,
                sigmaY: 10.0,
              ),
              child: Opacity(
                opacity: 0.8,
                child: BottomNavigationBar(
                  elevation: 0,
                  currentIndex: bottomindex.value,
                  selectedItemColor: ConstantStyle.oren,
                  unselectedItemColor: foregroundwidget2,
                  backgroundColor: Colors.black,
                  type: BottomNavigationBarType.shifting,
                  selectedFontSize: 13.sp,
                  unselectedFontSize: 12.sp,
                  onTap: (int index) {
                    ontapIndex(index);
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      icon: Icon(Icons.home, size: 23.sp),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      icon: Icon(Icons.shopping_basket, size: 22.sp),
                      label: 'Order',
                    ),
                    BottomNavigationBarItem(
                      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                      icon: Icon(Icons.person, size: 23.sp),
                      label: 'Account',
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:online_trading/core/rabbitmq/connection.controller.dart';
// import 'package:online_trading/helper/constant_style.dart';
// import 'package:online_trading/helper/constants.dart';
// import 'package:online_trading/module/request/activity/acty_request.dart';
// import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/mainaccountSettings.dart';
// import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/myorderview.dart';
// import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
// import 'menu/homeview_widget/homeview.dart';

// class BottomNavbarWidget extends StatefulWidget {
//   const BottomNavbarWidget({super.key});

//   @override
//   State<BottomNavbarWidget> createState() => _BottomNavbarWidgetState();
// }

// class _BottomNavbarWidgetState extends State<BottomNavbarWidget> {
//   final RxInt _currentPage = 0.obs;
//   final _pageController = PageController();
//   String getClientTag = Get.find(tag: "buildClientTag");
//   ConnectionsController getConnect = Get.find();
//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => WillPopScope(
//         onWillPop: () async => false,
//         child: Stack(
//           clipBehavior: Clip.antiAliasWithSaveLayer,
//           fit: StackFit.expand,
//           children: [
//             Scaffold(
//               backgroundColor: Colors.black,
//               body: SafeArea(
//                 child: PageView(
//                   physics: const NeverScrollableScrollPhysics(),
//                   controller: _pageController,
//                   children: [
//                     const HomeView(),
//                     const MyOrder(),
//                     TradeViewMain(
//                       title: 'BUMI',
//                       subTitle: 'BUMI',
//                       board: 'RG',
//                       onTap: () {
//                         ActivityRequest.quoteRequest(
//                           packageId: Constans.PACKAGE_ID_QUOTES,
//                           commant: 1,
//                           arrayStockCode: [
//                             ArrayStockCode(
//                               stockCode: "BUMI",
//                               board: "RG",
//                             )
//                           ],
//                         );
//                       },
//                     ),
//                     const AccountView(),
//                   ],
//                   onPageChanged: (index) {
//                     setState(() => _currentPage.value = index);
//                   },
//                 ),
//               ),
//               bottomNavigationBar: BottomNavigationBar(
//                 currentIndex: _currentPage.value,
//                 selectedItemColor: ConstantStyle.oren,
//                 unselectedItemColor: foregroundwidget2,
//                 backgroundColor: Colors.black,
//                 selectedFontSize: 15.sp,
//                 unselectedFontSize: 15.sp,
//                 onTap: (int index) {
//                   _pageController.jumpToPage(index);
//                   setState(() => _currentPage.value = index);

//                   if (index == 1) Get.put(MyOrderController());
//                 },
//                 items: <BottomNavigationBarItem>[
//                   BottomNavigationBarItem(
//                     backgroundColor: Colors.black,
//                     icon: Icon(Icons.home, size: 25.sp),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     backgroundColor: Colors.black,
//                     icon: Icon(Icons.shopping_basket, size: 25.sp),
//                     label: 'My Orders',
//                   ),
//                   BottomNavigationBarItem(
//                     backgroundColor: Colors.black,
//                     icon: Icon(Icons.leaderboard_rounded, size: 25.sp),
//                     label: 'Trade',
//                   ),
//                   BottomNavigationBarItem(
//                     backgroundColor: Colors.black,
//                     icon: Icon(Icons.person, size: 25.sp),
//                     label: 'Account',
//                   ),
//                 ],
//               ),
//             ),
//             getConnect.onError()
//                 ? GestureDetector(
//                     onTap: () {
//                       getConnect.onErrors.toggle();
//                     },
//                     child: Scaffold(
//                       backgroundColor: Colors.transparent,
//                       body: Container(
//                         alignment: Alignment.center,
//                         color: Colors.black.withOpacity(0.9),
//                         height: Get.height,
//                         width: Get.width,
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: foregroundwidget,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           padding: EdgeInsets.all(20.w),
//                           height: 0.425.sh,
//                           width: 0.7.sw,
//                           alignment: Alignment.center,
//                           child: Text(
//                             'ERROR CONNECT \n PLEASE TURN ON INTERNET OR CHECK VPN',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 20.sp,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 : Container(),
//           ],
//         ),
//       ),
//     );
//   }
// }
