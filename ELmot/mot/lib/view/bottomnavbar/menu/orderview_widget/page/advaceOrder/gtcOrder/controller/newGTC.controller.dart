import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class NewGTCController extends GetxController {
  final TextEditingController priceContollerGTC =
      TextEditingController(text: '');
  final TextEditingController qtyContollerGTC = TextEditingController(text: '');
  final TextEditingController priceStapControllerGTC = TextEditingController();
  final RxBool autoGTC = false.obs;
  final TextEditingController effectiveDateContollerGTC = TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(
      DateTime.now(),
    ),
  );
  final TextEditingController dueDateContollerGTC = TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day +
            DateUtils.getDaysInMonth(
              DateTime.now().year,
              DateTime.now().month,
            ),
      ),
    ),
  );
  RxBool comment = true.obs;
  RxString accountId = ''.obs;
  RxString filterData = 'All'.obs;

  void confirm({
    bool type = false,
    required String stockCode,
    required int pin,
  }) {
    OrderMassage.reqGTCOrder(
      stockCode: stockCode,
      price: int.parse(priceContollerGTC.text == ''
          ? '0'
          : priceContollerGTC.text.replaceAll(RegExp(r','), '')),
      volume: int.parse(qtyContollerGTC.text == ''
              ? '0'
              : qtyContollerGTC.text.replaceAll(RegExp(r','), '')) *
          Get.find<LoginOrderController>().order!.value.lot!,
      command: type ? 0 : 1,
      pin: pin,
      effDate: int.parse(
        effectiveDateContollerGTC.text.replaceAll(
          RegExp(r'/'),
          '',
        ),
      ),
      dueDate: int.parse(
        dueDateContollerGTC.text.replaceAll(
          RegExp(r'/'),
          '',
        ),
      ),
      priceStap: int.parse(
        priceStapControllerGTC.text.replaceAll(
          RegExp(r','),
          '',
        ),
      ),
      autoOrder: autoGTC.value == true ? 1 : 0,
      board: Get.find<ControllerBoard>().boards.value == 'RG' ? 0 : 1,
    );
  }

  void getList() {
    OrderMassage.reqListAdvaceOrder(
      pin: int.parse(Get.find<PinSave>().pin.value),
      packageID: Constans.PACKAGE_ID_REQUEST_GTC_ORDER_LIST,
      status: filterData.value == 'All'
          ? 0
          : filterData.value == 'Open'
              ? 1
              : filterData.value == 'Executed'
                  ? 2
                  : filterData.value == 'Withdrawn'
                      ? 3
                      : 4,
    );
  }

  void clear() {
    priceContollerGTC.text = '';
    qtyContollerGTC.text = '';
    priceStapControllerGTC.text = '';
    autoGTC.value = false;
    effectiveDateContollerGTC.text = DateFormat('yyyy/MM/dd').format(
      DateTime.now(),
    );
    dueDateContollerGTC.text = DateFormat('yyyy/MM/dd').format(
      DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day +
            DateUtils.getDaysInMonth(
              DateTime.now().year,
              DateTime.now().month,
            ),
      ),
    );
    filterData.value = 'Open';
  }
}
