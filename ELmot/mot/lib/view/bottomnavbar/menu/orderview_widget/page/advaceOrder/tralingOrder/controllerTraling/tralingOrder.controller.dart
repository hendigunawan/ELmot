import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_NewTralingOrder.massage.dart';
import 'package:online_trading/module/ordering/pkg/order/requestTralingList.pkg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/newTralingOrder/newTralingOrder.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class TralingOrderController extends GetxController {
  var getBodyContoller = Get.put(BodyController());
  RxBool typeComment = false.obs;
  RxInt buyAt = 0.obs;
  RxInt priceType = 0.obs;
  final TextEditingController qtyControllerTraling =
      TextEditingController(text: '0');
  final TextEditingController lowThanTraling = TextEditingController(text: '');
  final TextEditingController upThanTraling = TextEditingController(text: '');
  final TextEditingController effectiveDateContollerTraling =
      TextEditingController(
    text: DateFormat('yyyy/MM/dd').format(
      DateTime.now(),
    ),
  );
  final TextEditingController dueDateContollerTraling = TextEditingController(
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
  final TextEditingController priceStapControllerTraling =
      TextEditingController();
  final RxBool autoTraling = false.obs;

  void clearData() {
    listTrailingOrder.clear();
    buyAt.value = 0;
    priceType.value = 0;
    qtyControllerTraling.text = '0';
    lowThanTraling.text = '';
    upThanTraling.text = '';
    effectiveDateContollerTraling.text = DateFormat('yyyy/MM/dd').format(
      DateTime.now(),
    );
    dueDateContollerTraling.text = DateFormat('yyyy/MM/dd').format(
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
    priceStapControllerTraling.text = '';
    if (autoTraling.value == true) autoTraling.toggle();
    if (typeComment.value == false) typeComment.toggle();
    indexTabTraling.value = 0;
  }

  int getBuyAtValue({required String stockCode, bool? type = true}) {
    var bestPrice = ObjectBoxDatabase.quotesBox
        .query(Quotes_.stockCode.equals(stockCode) &
            Quotes_.board.equals(Get.find<ControllerBoard>().boards.value))
        .build()
        .findFirst();
    if (bestPrice != null) {
      if (type!) {
        if (bestPrice.bestBidPrice == 0) {
          if (bestPrice.lastPrice == 0) {
            return bestPrice.prevPrice!;
          } else {
            return bestPrice.lastPrice!;
          }
        } else {
          return bestPrice.bestBidPrice!;
        }
      } else {
        if (bestPrice.bestOfferPrice == 0) {
          if (bestPrice.lastPrice == 0) {
            return bestPrice.prevPrice!;
          } else {
            return bestPrice.lastPrice!;
          }
        } else {
          return bestPrice.bestOfferPrice!;
        }
      }
    } else {
      return 0;
    }
  }

  int getFraksiPlus({required String stockCode, bool? type = true}) {
    int data = 0;
    if (buyAt.value != 0) {
      for (var i = 0; i < buyAt.value; i++) {
        int frac = getBodyContoller.fraksiPrice(
          (getBuyAtValue(stockCode: stockCode, type: type) + 1).toString(),
        );

        if (buyAt.value > 1) {
          data = frac +
              (data == 0
                  ? getBuyAtValue(stockCode: stockCode, type: type)
                  : data);
        } else {
          data = frac + getBuyAtValue(stockCode: stockCode, type: type);
        }
      }
    } else {
      data = getBuyAtValue(stockCode: stockCode, type: type);
    }
    return data;
  }

  void confirmBUYTraling(String stockCode) {
    var data = TralingModelReq(
      pin: Get.find<PinSave>().pin.value,
      command: 0,
      volume: int.parse(
        qtyControllerTraling.text.replaceAll(
          RegExp(r','),
          '',
        ),
      ),
      trailingStep: int.parse(upThanTraling.text),
      priceType: 5,
      stockCode: stockCode,
      accountId: accountId.value == ''
          ? Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId!
          : accountId.value,
      autoOrder:
          autoTraling.value ? int.parse(priceStapControllerTraling.text) : 0,
      board: Get.find<ControllerBoard>().boards.value == 'RG' ? 0 : 1,
      buyorsellAT: buyAt.value,
      dropPrice: int.parse(
        lowThanTraling.text.replaceAll(
          RegExp(r','),
          '',
        ),
      ),
      dueDate: int.parse(
        dueDateContollerTraling.text.replaceAll(
          RegExp(r'/'),
          '',
        ),
      ),
      effDate: int.parse(
        effectiveDateContollerTraling.text.replaceAll(
          RegExp(r'/'),
          '',
        ),
      ),
    );
    OrderMassage.reqTralingOrder(data: data);
  }

  void confirmSELLTraling(String stockCode) {
    var data = TralingModelReq(
      pin: Get.find<PinSave>().pin.value,
      command: 1,
      volume: int.parse(
        qtyControllerTraling.text.replaceAll(
          RegExp(r','),
          '',
        ),
      ),
      trailingStep: int.parse(upThanTraling.text),
      priceType: priceType.value,
      stockCode: stockCode,
      accountId: accountId.value == ''
          ? Get.find<LoginOrderController>()
              .order!
              .value
              .account!
              .first
              .accountId!
          : accountId.value,
      autoOrder:
          autoTraling.value ? int.parse(priceStapControllerTraling.text) : 0,
      board: Get.find<ControllerBoard>().boards.value == 'RG' ? 0 : 1,
      buyorsellAT: buyAt.value,
      dropPrice: 0,
      dueDate: int.parse(
        dueDateContollerTraling.text.replaceAll(
          RegExp(r'/'),
          '',
        ),
      ),
      effDate: int.parse(
        effectiveDateContollerTraling.text.replaceAll(
          RegExp(r'/'),
          '',
        ),
      ),
    );
    OrderMassage.reqTralingOrder(data: data);
  }

  void cancleTralingOrder(String tralingID) {
    OrderMassage.reqCancelTralingOrder(
      pin: int.parse(
        Get.find<PinSave>().pin.value,
      ),
      tralingID: tralingID,
    );
  }
}
