import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolio.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolioreturn.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/portopoliowidget/portopolioreturnwidget.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/portopoliowidget/portopoliowidget.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:page_transition/page_transition.dart';

// ignore: must_be_immutable
class PortopolioMain extends StatelessWidget {
  PortopolioMain({super.key});
  RxString account = ''.obs;
  final RxInt _selectedIndex = 0.obs;
  void _onTabSelected(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<PinSave>().pin.value = '';
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: GestureDetector(
              onTap: () {
                Get.find<PinSave>().pin.value = '';
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
              "My Portopolio",
              style: TextStyle(
                fontSize: FontSizes.size16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 3.h, left: 5.w),
                    height: 45.h,
                    width: 0.88.sw,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Pin.show(
                      onSelect: () async {
                        Future.delayed(
                          const Duration(milliseconds: 51),
                          () async {
                            if (Get.find<PinSave>().pin.value != '') {
                              await OrderMassage.reqPortopolio(
                                  Get.find<PinSave>().pin.value,
                                  accountId.value == ""
                                      ? Get.find<LoginOrderController>()
                                          .order!
                                          .value
                                          .account!
                                          .first
                                          .accountId
                                          .toString()
                                      : accountId.value);
                              await OrderMassage.reqPortopolioReturn(
                                  Get.find<PinSave>().pin.value,
                                  accountId.value == ""
                                      ? Get.find<LoginOrderController>()
                                          .order!
                                          .value
                                          .account!
                                          .first
                                          .accountId
                                          .toString()
                                      : accountId.value);
                            }
                          },
                        );
                      },
                      onComplete: (text) async {
                        Get.find<PinSave>().pin.value = text;
                        await OrderMassage.reqPortopolio(
                            text,
                            accountId.value == ""
                                ? Get.find<LoginOrderController>()
                                    .order!
                                    .value
                                    .account!
                                    .first
                                    .accountId
                                    .toString()
                                : accountId.value);
                        await OrderMassage.reqPortopolioReturn(
                            text,
                            accountId.value == ""
                                ? Get.find<LoginOrderController>()
                                    .order!
                                    .value
                                    .account!
                                    .first
                                    .accountId
                                    .toString()
                                : accountId.value);
                        fokusNode.unfocus();
                      },
                      paddingcustom: EdgeInsets.zero,
                      color: bgabu,
                      border: Border.all(
                        width: 0,
                      ),
                      decoration1: BoxDecoration(
                        color: bgabu,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      decoration2: BoxDecoration(
                        color: bgabu,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      fontstyleNameaccount: TextStyle(
                        color: Colors.white,
                        fontSize: 11.5.sp,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Get.find<PinSave>().pin.value = '';
                      fokusNode = FocusNode();
                      listPortopolio!.clear();
                      listPortopolioreturn!.clear();
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(
                            milliseconds: 100,
                          ),
                          child: PortopolioMain(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 3.w),
                      child: FittedBox(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 35.h,
                    width: 0.97.sw,
                    decoration: BoxDecoration(
                      color: bgabu,
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(children: [
                      _customButton("Portopolio", 0),
                      _customButton("Portopolio Return", 1),
                    ]),
                  ),
                ],
              ),
              Obx(() {
                return Flexible(
                    child: Container(
                        margin: EdgeInsets.only(top: 7.h),
                        child: _selectedIndex.value == 0
                            ? SingleChildScrollView(
                                child: PortopolioWidget(),
                              )
                            : PortopolioReturnWidget()));
              })
            ],
          )),
    );
  }

  Widget _customButton(String title, int index) {
    return GestureDetector(
      onTap: () => _selectedIndex.value != index ? _onTabSelected(index) : null,
      child: Obx(() {
        return Column(
          children: [
            Container(
              height: 35.h,
              width: 0.485.sw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.r),
                  color: _selectedIndex.value == index
                      ? foregroundwidget.withOpacity(0.9)
                      : bgabu),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontWeight: _selectedIndex.value == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: _selectedIndex.value == index
                          ? Colors.white.withOpacity(0.85)
                          : Colors.grey,
                      fontSize: FontSizes.size13),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
