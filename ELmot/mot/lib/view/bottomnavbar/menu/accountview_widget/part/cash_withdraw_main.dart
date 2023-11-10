// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/fund_withdraw_info.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/fund_withdraw_list.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/historical_orderlist.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/historical_tradeList.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cashwithdrawwidget/fund_withdraw_history.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cashwithdrawwidget/fund_withdraw_info.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:page_transition/page_transition.dart';

class CashWithDrawMain extends StatelessWidget {
  CashWithDrawMain({super.key});

  final RxInt _selectedIndex = 0.obs;
  void _onTabSelected(int index) {
    _selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    var controllerAmmount = Get.put(WithDrawInfoController());
    controllerAmmount;
    controllerAmmount.setFalseisactiveRTGS();
    var dateController = Get.put(DateController());
    dateController;
    dateController.setDateDefault();
    fokusNode = FocusNode();
    return WillPopScope(
      onWillPop: () async {
        controllerAmmount.setEmptyafteruse();
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              controllerAmmount.setEmptyafteruse();
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
            "Cash Withdraw",
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
                      await Future.delayed(const Duration(milliseconds: 51),
                          () {
                        dateController.requestupdateData();
                        dateController.requestNewList();
                      });
                      ammount_controller.clear();
                      controllerAmmount.lastTotalFee.value = 0;
                      controllerAmmount.isActiveRTGS.value = false;
                      controllerAmmount.selectedDate.value = '';
                    },
                    onComplete: (text) async {
                      Get.find<PinSave>().pin.value = text;
                      dateController.requestupdateData();
                      dateController.requestNewList();
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
                    controllerAmmount.setEmptyafteruse();

                    Navigator.pushReplacement(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        duration: const Duration(
                          milliseconds: 100,
                        ),
                        child: CashWithDrawMain(),
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
                    _customButton("Fund Withdrawal Info", 0),
                    _customButton("Fund Withdrawal History", 1),
                  ]),
                ),
              ],
            ),
            Obx(() {
              return Flexible(
                child: Container(
                  margin: EdgeInsets.only(top: 7.h),
                  child: _selectedIndex.value == 0
                      ? const SingleChildScrollView(
                          child: FundWithdrawInfoMain(),
                        )
                      : const FundWithdrawHistoryMain(),
                ),
              );
            }),
          ],
        ),
        bottomNavigationBar: Obx(() {
          if (_selectedIndex.value == 0) {
            return Container(
              width: 1.sw,
              height: 55.h,
              color: bgabu,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5.w),
                    width: 0.7.sw,
                    color: bgabu,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Selected Date : ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              listfundwithdrawInfo.isEmpty
                                  ? "-"
                                  : controllerAmmount.selectedDate.value == ''
                                      ? dateAjaGarisMiring(
                                          listfundwithdrawInfo.first.t1Date)
                                      : dateAjaGarisMiring(
                                          controllerAmmount.selectedDate.value),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total: ",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Rp.  ${formattaCurrun(controllerAmmount.lastTotalFee.toInt())}",
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.blue,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (listfundwithdrawInfo.isEmpty) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                                backgroundColor: foregroundwidget,
                                title: Center(
                                  child: Text(
                                    "Attention",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size14,
                                    ),
                                  ),
                                ),
                                content: SizedBox(
                                  height: 0.1.sh,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Please Insert PIN",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size12,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (ammount_controller.text == '') {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              backgroundColor: foregroundwidget,
                              title: Text(
                                "Attention!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14,
                                ),
                              ),
                              content: Text(
                                "Please input correct\namount value",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size12,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        );
                      } else {
                        int compare = controllerAmmount.selectedCash.value == 0
                            ? listfundwithdrawInfo.first.t1Cash!.toInt()
                            : controllerAmmount.selectedCash.value;
                        if (int.parse(ammount_controller.text) +
                                (listfundwithdrawInfo.first.clearingFee!
                                        .toInt() +
                                    listfundwithdrawInfo.first.pindahBukuFee!
                                        .toInt()) +
                                listfundwithdrawInfo.first.rtgsFee!.toInt() >
                            compare) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  backgroundColor: foregroundwidget,
                                  title: Text(
                                    "Attention!",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size14,
                                    ),
                                  ),
                                  content: Text(
                                    "Your cash on ${controllerAmmount.selectedTcash.value == '' ? 'T1' : controllerAmmount.selectedTcash.value} is not enough",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: FontSizes.size12,
                                    ),
                                  ),
                                );
                              });
                        } else if (int.parse(ammount_controller.text) <
                            listfundwithdrawInfo.first.minimumAmmount!
                                .toInt()) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.r),
                                  ),
                                  backgroundColor: foregroundwidget,
                                  title: Center(
                                    child: Text(
                                      "Attention!",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: FontSizes.size14,
                                      ),
                                    ),
                                  ),
                                  content: SizedBox(
                                    height: 0.1.sh,
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "Minimum transfer amount must \nbigger than Rp. ${formattaCurrun(listfundwithdrawInfo.first.minimumAmmount!)}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: FontSizes.size12,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    5.r,
                                  ),
                                ),
                                backgroundColor: putihop85,
                                title: Text(
                                  "Confirm to Withdraw\n${listfundwithdrawInfo.first.bankAccountName}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: FontSizes.size14,
                                      fontWeight: FontWeight.bold),
                                ),
                                content: Container(
                                  padding: EdgeInsets.all(8.w),
                                  height: 135.h,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 184, 182, 182),
                                    borderRadius: BorderRadius.circular(
                                      5.r,
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Account Id : ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                          Text(
                                            "${listfundwithdrawInfo.first.accountId}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bank Acc Id : ",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                          Text(
                                            "${listfundwithdrawInfo.first.bankAccountId}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Bank Name : ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                            maxLines: 1,
                                          ),
                                          Text(
                                            "${listfundwithdrawInfo.first.bankName}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Transfer Date : ",
                                            maxLines: 1,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                          Text(
                                            "${dateAjaGarisMiring(controllerAmmount.selectedDate.value == '' ? listfundwithdrawInfo.first.t1Date : controllerAmmount.selectedDate.value)} (${controllerAmmount.selectedTcash.value == '' ? 'T1' : controllerAmmount.selectedTcash.value})",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 4.h,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Amount : ",
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: FontSizes.size11,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            "Rp. ${formattaCurrun(int.parse(ammount_controller.text))}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: FontSizes.size11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actions: [
                                  SizedBox(
                                    height: 30.h,
                                    width: 0.24.sw,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: FontSizes.size10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                    width: 0.24.sw,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                            backgroundColor: Colors.blue),
                                        onPressed: () async {
                                          Navigator.pop(context);

                                          controllerAmmount.sendFundWithdrawing(
                                            accountId: accountId.value == ""
                                                ? Get.find<
                                                        LoginOrderController>()
                                                    .order!
                                                    .value
                                                    .account!
                                                    .first
                                                    .accountId
                                                    .toString()
                                                : accountId.value,
                                            transferDate:
                                                "${controllerAmmount.selectedDate.value == '' ? listfundwithdrawInfo.first.t1Date : controllerAmmount.selectedDate.value}",
                                            ammountTransfer: int.parse(
                                                ammount_controller.text),
                                            pin: Get.find<PinSave>().pin.value,
                                            rtgs: controllerAmmount
                                                        .isActiveRTGS.value ==
                                                    false
                                                ? 0
                                                : 1,
                                          );
                                        },
                                        child: Center(
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: FontSizes.size10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: Container(
                      width: 0.3.sw,
                      alignment: Alignment.center,
                      color: Colors.blue,
                      child: Text(
                        "Withdraw",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Text(" ");
          }
        }),
      ),
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

class WithDrawInfoController extends GetxController {
  RxInt lastTotalFee = 0.obs;
  RxInt ammountValue = 0.obs;
  RxInt rtgsValue = 0.obs;

  RxString selectedDate = ''.obs;

  // untuk selected
  RxInt selectedCash = 0.obs;
  RxString selectedTcash = ''.obs;
  RxBool isTabRTGS = false.obs;
  RxBool isActiveRTGS = false.obs;
  @override
  void onInit() {
    super.onInit();
    ever(
      listfundwithdrawInfo,
      (callback) => setAmmount(),
    );
  }

  void ontapRTGS() {
    if (isTabRTGS.value == false) {
      rtgsValue.value = 0;
    } else {
      rtgsValue.value = listfundwithdrawInfo.first.rtgsFee!.toInt();
    }
    lasttotalfee();
  }

  void setAmmount() {
    if (listfundwithdrawInfo.isEmpty) {
    } else {
      ammount_controller.text =
          listfundwithdrawInfo.first.minimumAmmount.toString();
      ammountValue.value = listfundwithdrawInfo.first.minimumAmmount!;
      lasttotalfee();
    }
  }

  void increaseCash(int val) {
    ammountValue.value = val;
    ammountValue.refresh();
    lasttotalfee();
  }

  void isActiveRTGSToggle(int val, bool isActive) {
    if (isActive == true) {
      rtgsValue.value = val;
      rtgsValue.refresh();
      lasttotalfee();
    } else {
      rtgsValue.value = 0;
      rtgsValue.refresh();
      lasttotalfee();
    }
  }

  void lasttotalfee() {
    lastTotalFee.value = ammountValue.value +
        rtgsValue.value +
        listfundwithdrawInfo.first.clearingFee!.toInt() +
        listfundwithdrawInfo.first.pindahBukuFee!.toInt();
    lastTotalFee.refresh();
  }

  void sendFundWithdrawing(
      {required String pin,
      required String accountId,
      required String transferDate,
      required int ammountTransfer,
      required int rtgs}) {
    OrderMassage.reqFundWithdrawMoneyy(
        accountId: accountId,
        pin: pin,
        ammountTransfer: ammountTransfer,
        rtgs: rtgs,
        transferDate: transferDate);
  }

  void setEmptyafteruse() {
    Future.delayed(const Duration(milliseconds: 50), () {
      listFundWithDrawList.clear();
      listfundwithdrawInfo.clear();
      ammount_controller.clear();
      selectedCash.value = 0;
      selectedTcash.value = '';
      lastTotalFee.value = 0;
      ammountValue.value = 0;
      rtgsValue.value = 0;
      selectedDate.value = '';
      isActiveRTGS.value = false;
      Get.find<PinSave>().pin.value = '';
      Get.find<DateController>().selectedStatus.value = '';
    });
  }

  void setFalseisactiveRTGS() {
    Future.delayed(const Duration(milliseconds: 50), () {
      isActiveRTGS.value = false;
    });
  }
}

class DateController extends GetxController {
  RxString selectedStatus = '5'.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  Rx<DateTime> selectedToDate = DateTime.now().obs;
  void selectDate(DateTime newDate) async {
    selectedDate.value = newDate;
    selectedDate.refresh();
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);
    await OrderMassage.reqFundWithdrawanListReq(
      pin: Get.find<PinSave>().pin.value,
      accountId: accountId.value == ""
          ? Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId
              .toString()
          : accountId.value,
      status: int.parse(selectedStatus.value),
      fromDate: int.parse(fromDate),
      toDate: int.parse(toDate),
    );
  }

  void fromHist(DateTime newDate) async {
    selectedDate.value = newDate;
    selectedDate.refresh();
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);

    await OrderMassage.historicalorderListReq(
        accountId: accountId.value == ''
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId!
            : accountId.value,
        pin: Get.find<PinSave>().pin.value,
        fromDate: int.parse(fromDate),
        toDate: int.parse(toDate));
  }

  void fromTrade(DateTime newDate) async {
    selectedDate.value = newDate;
    selectedDate.refresh();
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);

    await OrderMassage.historicaltradeListReq(
        accountId: accountId.value == ''
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId!
            : accountId.value,
        pin: Get.find<PinSave>().pin.value,
        fromDate: int.parse(fromDate),
        toDate: int.parse(toDate));
  }

  void selectToDate(DateTime newDate) async {
    selectedToDate.value = newDate;
    selectedToDate.refresh();
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);
    await OrderMassage.reqFundWithdrawanListReq(
      pin: Get.find<PinSave>().pin.value,
      accountId: accountId.value == ""
          ? Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId
              .toString()
          : accountId.value,
      status: int.parse(selectedStatus.value),
      fromDate: int.parse(fromDate),
      toDate: int.parse(toDate),
    );
  }

  void toHist(DateTime newDate) async {
    selectedToDate.value = newDate;
    selectedToDate.refresh();
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);
    await OrderMassage.historicalorderListReq(
        accountId: accountId.value == ''
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId!
            : accountId.value,
        pin: Get.find<PinSave>().pin.value,
        fromDate: int.parse(fromDate),
        toDate: int.parse(toDate));
  }

  void toTrade(DateTime newDate) async {
    selectedToDate.value = newDate;
    selectedToDate.refresh();
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);
    await OrderMassage.historicaltradeListReq(
        accountId: accountId.value == ''
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId!
            : accountId.value,
        pin: Get.find<PinSave>().pin.value,
        fromDate: int.parse(fromDate),
        toDate: int.parse(toDate));
  }

  Future<void> showFromDate(BuildContext context,
      {bool? ishostory, bool? isTradeList}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate.value) {
      if (ishostory == true) {
        fromHist(picked);
      }
      if (isTradeList == true) {
        fromTrade(picked);
      } else {
        selectDate(picked);
      }
    }
  }

  Future<void> showtoDate(BuildContext context,
      {bool? ishostory, bool? isTradeList}) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedToDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedToDate.value) {
      if (ishostory == true) {
        toHist(picked);
      }
      if (isTradeList == true) {
        toTrade(picked);
      } else {
        selectToDate(picked);
      }
    }
  }

  void setStatusDefault() {
    Future.delayed(const Duration(milliseconds: 20), () {
      selectedStatus.value =
          selectedStatus.value == '' ? '5' : selectedStatus.value;
    });
  }

  void setDateDefault() {
    Future.delayed(const Duration(milliseconds: 50), () {
      selectedDate.value = DateTime.now();
      selectedToDate.value = DateTime.now();
    });
  }

  void setDefaultListHistori() {
    listHistorical.clear();
  }

  void setDefaultTradeListHistori() {
    listtradeListHistory.clear();
  }

  String formatDateToyyyyMMdd(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return year + month + day;
  }

  void requestNewList() async {
    var pin = Get.find<PinSave>();
    if (pin.pin.value == '') return;
    String fromDate = formatDateToyyyyMMdd(selectedDate.value);
    String toDate = formatDateToyyyyMMdd(selectedToDate.value);

    await OrderMassage.reqFundWithdrawanListReq(
      pin: pin.pin.value,
      accountId: accountId.value == ""
          ? Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId
              .toString()
          : accountId.value,
      status:
          int.parse(selectedStatus.value == '' ? '5' : selectedStatus.value),
      fromDate: int.parse(fromDate),
      toDate: int.parse(toDate),
    );
  }

  void requestupdateData() async {
    var pin = Get.find<PinSave>();
    if (pin.pin.value == '') return;

    await OrderMassage.reqFundWithdrawanInfoReq(
      pin: pin.pin.value,
      accountId: accountId.value == ""
          ? Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId
              .toString()
          : accountId.value,
    );
  }
}
