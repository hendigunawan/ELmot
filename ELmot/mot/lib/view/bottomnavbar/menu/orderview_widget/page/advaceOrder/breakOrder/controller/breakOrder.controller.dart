import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_BreakOrder.massage.dart';
import 'package:online_trading/module/ordering/pkg/order/breakorderlist.pkg.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class BreakOrderContoller extends GetxController {
  TextEditingController idBreakContollerBreak = TextEditingController();
  TextEditingController priceContollerBreak = TextEditingController();
  TextEditingController qrtyControllerBreak = TextEditingController();
  RxInt cPriceType = 0.obs;
  RxInt cPriceCpn = 1.obs;
  TextEditingController cPriceContollerBreak = TextEditingController();
  RxInt cVolType = 0.obs;
  RxInt cVolCpn = 0.obs;
  TextEditingController cVolContollerBreak = TextEditingController();
  RxBool autoOrder = false.obs;
  RxBool command = true.obs;
  TextEditingController priceStap = TextEditingController();
  TextEditingController effectiveDateContollerBreak = TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(
      DateTime.now(),
    ),
  );
  TextEditingController dueDateContollerBreak = TextEditingController(
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

  void clearData() {
    listBreakorderList.clear();
    idBreakContollerBreak = TextEditingController();
    priceContollerBreak = TextEditingController();
    qrtyControllerBreak = TextEditingController();
    cPriceType = 0.obs;
    cPriceCpn = 1.obs;
    cPriceContollerBreak = TextEditingController();
    cVolType = 0.obs;
    cVolCpn = 0.obs;
    cVolContollerBreak = TextEditingController();
    autoOrder = false.obs;
    priceStap = TextEditingController();
    effectiveDateContollerBreak = TextEditingController(
      text: DateFormat('yyyy/MM/dd').format(
        DateTime.now(),
      ),
    );
    dueDateContollerBreak = TextEditingController(
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
  }

  void onSeadCancelBreak(int pin) {
    OrderMassage.reqCancelBreakOrder(
      breakID: idBreakContollerBreak.text,
      pin: pin,
    );
  }

  void onSendMassageBuy({
    required String stockCode,
    required bool type,
    required String pin,
  }) {
    var data = BreakOrderMassageModel(
      stockCode: stockCode,
      price: int.parse(
        priceContollerBreak.text.replaceAll(RegExp(r','), ''),
      ),
      volume: int.parse(
            qrtyControllerBreak.text.replaceAll(RegExp(r','), ''),
          ) *
          Get.find<LoginOrderController>().order!.value.lot!,
      command: type ? 0 : 1,
      conPriceType: cPriceType.value,
      conPriceCom: cPriceCpn.value,
      conPrice: cPriceContollerBreak.text == ''
          ? 0
          : int.parse(
              cPriceContollerBreak.text.replaceAll(RegExp(r','), ''),
            ),
      conVolType: cVolType.value,
      conVolCom: cVolCpn.value,
      conVol: cVolContollerBreak.text == ''
          ? 0
          : int.parse(
              cVolContollerBreak.text.replaceAll(RegExp(r','), ''),
            ),
      autoOrder: priceStap.text == '' ? 0 : int.parse(priceStap.text),
      dueDate: int.parse(
        dueDateContollerBreak.text.replaceAll(RegExp(r'/'), ''),
      ),
      effDate: int.parse(
        effectiveDateContollerBreak.text.replaceAll(RegExp(r'/'), ''),
      ),
      pin: pin == '' ? Get.find<PinSave>().pin.value : pin,
    );

    OrderMassage.reqBreakOrder(data: data);
  }
}
