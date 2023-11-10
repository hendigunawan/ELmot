import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/req_accountinfo.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:page_transition/page_transition.dart';

class AccountInfoMain extends StatelessWidget {
  const AccountInfoMain({super.key});

  @override
  Widget build(BuildContext context) {
    // var controller = Get.put<PinPopController>(PinPopController());
    void showPininput() async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
              ),
              title: Center(
                child: Text(
                  "Please input PIN",
                  style: TextStyle(
                      color: Colors.white, fontSize: FontSizes.size15),
                ),
              ),
              backgroundColor: bgabu,
              content: SizedBox(
                width: 0.25.sw,
                height: 50.h,
                child: PinCodeFields(
                  autofocus: true,
                  length: 6,
                  keyboardType: TextInputType.number,
                  textStyle: TextStyle(
                    fontSize: FontSizes.size12,
                    color: Colors.white,
                  ),
                  borderWidth: 0,
                  obscureCharacter: '•',
                  obscureText: true,
                  margin: EdgeInsets.only(
                    left: 2.w,
                    right: 2.w,
                  ),
                  padding: EdgeInsets.zero,
                  autofillHints: Get.put(PinSave()).pin.value == ''
                      ? null
                      : Get.put(PinSave()).pin.value.split(''),
                  onComplete: (text) async {
                    // controller.pins = text.obs;
                    await OrderMassage.reqAccountInfo(
                      text,
                      accountId.value == ''
                          ? Get.find<LoginOrderController>()
                              .order!
                              .value
                              .account!
                              .first
                              .accountId!
                          : accountId.value,
                    );
                    Get.back();
                  },
                ),
              ),
            );
          });
    }

    return WillPopScope(
      onWillPop: () async {
        Get.find<PinSave>().onPop();
        return true;
      },
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            centerTitle: true,
            leading: GestureDetector(
              onTap: () {
                Get.find<PinSave>().onPop();
                Navigator.pop(context);
                listAccountInfo.clear();
              },
              child: Icon(
                Icons.arrow_back,
                size: IconSizes.backArrowSize,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.black,
            title: Text(
              "Account Info",
              style: TextStyle(
                color: Colors.white,
                fontSize: FontSizes.size16,
              ),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
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
                      onSelect: () => Future.delayed(
                        const Duration(milliseconds: 51),
                        () => OrderMassage.reqAccountInfo(
                          Get.find<PinSave>().pin.value,
                          accountId.value == ""
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId
                                  .toString()
                              : accountId.value,
                        ),
                      ),
                      onComplete: (text) async {
                        Get.find<PinSave>().pin.value = text;
                        await OrderMassage.reqAccountInfo(
                          text,
                          accountId.value == ""
                              ? Get.find<LoginOrderController>()
                                  .order!
                                  .value
                                  .account!
                                  .first
                                  .accountId
                                  .toString()
                              : accountId.value,
                        );
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
                      listAccountInfo.clear();
                      fokusNode = FocusNode();
                      Navigator.pushReplacement(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(
                            milliseconds: 100,
                          ),
                          child: const AccountInfoMain(),
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
              Obx(() {
                if (listAccountInfo.isEmpty) {
                  return Container();
                } else {
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Account Info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size13,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Divider(
                                color: putihop85,
                                height: 3.h,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Id",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.accountId.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account Status",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.accountStatus
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Login Id",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.loginId.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "SID",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.sid.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "KSEI Account No.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.kseiAccountNo
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Id No.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.idNo.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Id expiry",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.idExpiry.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Customer type",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.customerType
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Divider(
                                color: putihop85,
                                height: 3.h,
                              ),
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size13,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Divider(
                                color: putihop85,
                                height: 3.h,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Id type",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.idType.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nationality",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.nationality
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mother name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.mothersName
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.email.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Phone",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.phone.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Handphone",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.handPhone.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Office phone",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.officePhone
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Home address",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.homeAddress
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Job",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.job.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Company name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.companyName
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Office address",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.officeAddress
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Office phone",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.officePhone
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Divider(
                                color: putihop85,
                                height: 3.h,
                              ),
                            ),
                            Text(
                              "Bank Info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: FontSizes.size13,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 5.h, bottom: 5.h),
                              child: Divider(
                                color: putihop85,
                                height: 3.h,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Opening Account Date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    dateAja(
                                      listAccountInfo.first.openingAccountDate,
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Managing Branch",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.managingBranch
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bank Code",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.bankCode.toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bank Account No.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.bankAccountNo
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Bank Account Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.bankAccountName
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RDN Bank Code",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.rdnBankCode
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RDN Bank Account No.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.rdnBankAccountNo
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RDN Bank Account Name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    listAccountInfo.first.rdnBankAccountName
                                        .toString(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 3.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "RDN Bank Account Open Date",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                  Text(
                                    dateAja(
                                      listAccountInfo
                                          .first.rdnBankAccountOpenDate,
                                    ),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              })
            ],
          )),
    );
  }
}

// class PinPopController extends GetxController {
//   RxString pins = ''.obs;
//   RxBool onFist = false.obs;
//   @override
//   void onInit() {
//     super.onInit();
//     ever(
//       listAccountInfo,
//       (callback) => pushPage(),
//     );
//   }

//   void pushPage() {
//     if (listAccountInfo.isNotEmpty && onFist.value == false) {
//       Get.toNamed('/personalinfoView');
//       onFist.toggle();
//       Get.delete();
//     }
//   }
// }
