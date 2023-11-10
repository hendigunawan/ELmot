import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/ordering/massage/create/info/craete_HeartBeat.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_LogoutOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_cancel_exercised.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_cancel_fund_withdraw.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_cashledger.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_changepassnpin.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_exercise_list.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_exercise_warrant_info.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_financialhistory.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_fund_withdraw.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_fundwithdrawhistory.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_fundwithdrawinfo.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_monthly_balance.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_req_exercising.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_transaction_and_holidays.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_transaction_repport.massage.dart';
import 'package:online_trading/module/ordering/massage/create/info/create_trade_confirmation.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_BreakOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_CancelBreakOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_CancelGTCOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_CancelTralingOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_GTCorder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_ListAdvaceOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_NewTralingOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_TrailingListOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_historical_orderlist_massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_historicaltradelist.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_orderListReq.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_rejectedOrder.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_reqAmend.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_reqBreakOrderList.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_reqOrder.masage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_reqWithdraw.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/create_tradeListReq.massage.dart';
import 'package:online_trading/module/ordering/massage/create/order/validate_pin.massage.dart';
import 'package:online_trading/view/checkoutview/mainAmend.view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/textfield_controller/textcontroller.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:synchronized/synchronized.dart';
import 'create/info/create_realizedgainlost.massage.dart';
import 'create/info/create_reqAccountinfo.massage.dart';
import 'create/info/create_reqPortopolioreturn.massage.dart';
import 'create/info/create_requestportopolio.massage.dart';
import 'create/info/create_taxreport.massage.dart';
import 'create/info/create_tradinglimit.massage.dart';
import 'create/info/create_login.massage.dart';
import 'create/info/create_stokbalance.massage.dart';

class OrderMassage {
  static final order = Get.put(ControllerHandelOrder());
  static heardBeats() {
    Uint8List massage = createHeartBeatOrder();

    order.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static loginOrder({String? userName, String? passWord}) {
    Uint8List massage = createLoginMassageOrder(userName!, passWord!);

    order.addMassage(ModelMassage(massage: massage));
  }

  static validatePIN({required String pin}) {
    Uint8List massage = validatePINMASSAGE(pin: pin);

    order.addMassage(ModelMassage(massage: massage));
  }

  static logoutOrder() async {
    final SecureStorage store = SecureStorage();

    final lock = Lock();
    NotifikasiPopup.hide();
    Uint8List massage = createLogoutOrder();
    order.addMassage(ModelMassage(massage: massage));
    NotifikasiPopup.showLOADING();
    Get.put<bool>(false, tag: "getStatusLogin");
    await store.setPassWord('');
    await store.resetPassWord();
    username_login.text = (await store.getUserName())!;
    // Get.put(LogoutController()).onLogoutSuccess();
    await Future.delayed(
      const Duration(milliseconds: 500),
      () {
        lock.synchronized(
          () {
            NotifikasiPopup.hide();
            NotifikasiPopup.showSUCCESS(
              'SUCCESS\nLOGOUT',
              onTap: () {
                Get.offAllNamed('/splashView');
              },
              onClose: () {
                Get.offAllNamed('/splashView');
              },
              isEnable: false,
            );
          },
        );
      },
    );
  }

  static stockBalance({
    required String pin,
    required String accountId,
  }) {
    {
      Uint8List massage = createStockBalanceMassageOrder(
        pin: pin,
        accountId: accountId,
      );
      order.addMassage(ModelMassage(massage: massage));
    }
  }

  static reqAccountInfo(String pin, String accountIds) {
    Uint8List massage = createReqAccountInfoMassageOrder(pin, accountIds);
    order.addMassage(ModelMassage(massage: massage));
  }

  static taxReport(String pin, String tahun, String accountId) {
    Uint8List massage = createTaxReportMassageOrder(pin, tahun, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqPortopolio(String pin, String accountId) {
    Uint8List massage = createRequestPortopolioMassageOrder(pin, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqPortopolioReturn(String pin, String accountId) {
    Uint8List massage = createPortopolioReturnMassageOrder(pin, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqTradinglimit({String pin = '', String stockCode = ''}) {
    Uint8List massage = reqTradinglimitMessageOrder(
      pin: pin,
      stockCode: stockCode,
    );
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqRealizedGainLost(String pin, String date, String accountId) {
    Uint8List massage = reqRealizedGainLostMassageorder(pin, date, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqTransactionReport(String pin, String tahun, String accountId) {
    Uint8List massage =
        createTransactionReportMassageOrder(pin, tahun, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqTradeConfirmation(String pin, String tanggal, String accountId) {
    Uint8List massage = createTradeConfirmationmassage(pin, tanggal, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqFinancialHistory(String pin, String accountId, String date) {
    Uint8List massage = createFinancialHistory(pin, accountId, date);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqCashLedger(String pin, String accountId, String date) {
    Uint8List massage = createCashledger(pin, accountId, date);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqMonthlyBalance(
      {required String pin, required String accountId, required String tahun}) {
    Uint8List massage = createMonthlyBalanceMassageOrder(
        accountId: accountId, pin: pin, tahun: tahun);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqOrderMassage({required BuildingMassageOrderModel data}) {
    Uint8List massage = createRequestOrderMassage(
      stockCode: data.stockCode,
      price: data.price,
      volume: data.volume,
      command: data.command,
      pin: data.pin,
      prevSameOrder: data.prevSameOrder,
      rendomSplit: data.rendomSplit,
      nSplit: data.nSplit,
      activPriceStep: data.activPriceStep,
      priceStep: data.priceStep,
      activAutoOrder: data.activAutoOrder,
      autoOrderPriceStep: data.autoOrderPriceStep,
    );
    order.addMassage(ModelMassage(massage: massage));
  }

  static orderListReq(String pin, String accountId) {
    Uint8List massage = createOrderListReqMassage(pin, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static historicalorderListReq(
      {required String pin,
      required String accountId,
      required int fromDate,
      required int toDate}) {
    Uint8List massage = createHistoricalOrderListmassage(
        pin: pin, accountId: accountId, fromDate: fromDate, toDate: toDate);
    order.addMassage(ModelMassage(massage: massage));
  }

  static historicaltradeListReq(
      {required String pin,
      required String accountId,
      required int fromDate,
      required int toDate}) {
    Uint8List massage = createHistoricalTradeListmassage(
        pin: pin, accountId: accountId, fromDate: fromDate, toDate: toDate);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqExerciseRighwarrantInfo(
      {required String pin, required String accountId}) {
    Uint8List massage =
        createExerciseWarrantInfoMassageOrder(accountId: accountId, pin: pin);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqExerciseRighwarrantList(
      {required String pin, required String accountId}) {
    Uint8List massage =
        createExerciseWarrantListMassageOrder(accountId: accountId, pin: pin);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqExercisingData({
    required String pin,
    required String accountId,
    required int exerciseDate,
    required int exerciseVolume,
    required String stockcode,
  }) {
    Uint8List massage = createExercisingDataMassageOrder(
        accountId: accountId,
        pin: pin,
        exerciseDate: exerciseDate,
        stockcode: stockcode,
        exerciseVolume: exerciseVolume);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqCancelExercisedData(
      {required String pin,
      required String accountId,
      required int exerciseId}) {
    Uint8List massage = createCancelExercisedDataMassageOrder(
        accountId: accountId, pin: pin, exerciseId: exerciseId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqFundWithdrawanInfoReq(
      {required String pin, required String accountId}) {
    Uint8List massage = createfundwithdrawinfomassage(pin, accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqFundWithdrawanListReq(
      {required String pin,
      required String accountId,
      required int status,
      required int fromDate,
      required int toDate}) {
    Uint8List massage = createfundwithdrawListsmassage(
      pin: pin,
      accountId: accountId,
      status: status,
      toDate: toDate,
      fromDate: fromDate,
    );
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqCancelWithdraw({
    required String pin,
    required String accountId,
    required int funwithdrawid,
  }) {
    Uint8List massage = createCancelFundWithdrawMassage(
        accountId: accountId, funwithdrawId: funwithdrawid, pin: pin);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqTransactionnHolidays({
    required int reqType,
  }) {
    Uint8List massage = createTransactionAndHolidaysMassageOrder(
      reqType: reqType,
    );
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqFundWithdrawMoneyy(
      {required String pin,
      required String accountId,
      required String transferDate,
      required int ammountTransfer,
      required int rtgs}) {
    Uint8List massage = createFundWithDrawMoneyMassage(
        pin, accountId, transferDate, ammountTransfer, rtgs);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqTradeList({
    required String pin,
    required String accountId,
  }) {
    Uint8List massage =
        createTradeListReqMassage(accountId: accountId, pin: pin);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqChangePassPin(
      {required String oldPasin, required String newPasin, required int type}) {
    Uint8List massage = createmassgeChangePinpassmassage(
        newPasin: newPasin, oldPasin: oldPasin, type: type);
    order.addMassage(ModelMassage(massage: massage));
  }

  static amendReqMassage({required AmendReqMassageModel data}) {
    Uint8List massage = createRequestAmendMassage(
      orderID: data.orderID!,
      stockCode: data.stockCode!,
      idxID: data.idxID!,
      newPrice: data.newPrice!,
      newVol: data.newVol!,
      pin: data.pin!,
      accountId: data.accountId!,
      board: data.board!,
      command: data.command!,
    );

    order.addMassage(ModelMassage(massage: massage));
  }

  static withdrawReqMassage({required AmendReqMassageModel data}) {
    Uint8List massage = createRequestWithdrawMassage(
      orderID: data.orderID!,
      stockCode: data.stockCode!,
      idxID: data.idxID!,
      orderPrice: data.newPrice!,
      pin: data.pin!,
      accountId: data.accountId!,
      board: data.board!,
      command: data.command!,
    );

    order.addMassage(ModelMassage(massage: massage));
  }

  static reqRejectedOrderMassage({
    required String orderID,
    required String pin,
    required String accountId,
  }) {
    Uint8List massage = createRejectedOrderMassage(
      orderID: orderID,
      pin: pin,
      accountId: accountId,
    );

    order.addMassage(ModelMassage(massage: massage));
  }

  static reqGTCOrder({
    required String stockCode,
    required int price,
    required int volume,
    required int command,
    required int pin,
    int? priceStap = 0,
    int? autoOrder = 0,
    int? effDate = 0,
    int? dueDate = 0,
    int? board = 0,
  }) {
    Uint8List massage = createGTCOrderMassage(
      stockCode: stockCode,
      price: price,
      volume: volume,
      command: command,
      pin: pin,
      priceStap: priceStap,
      autoOrder: autoOrder,
      effDate: effDate,
      dueDate: dueDate,
      board: board,
    );

    order.addMassage(ModelMassage(massage: massage));
  }

  static createGTCCancel({required int pin, required String gtcId}) {
    Uint8List massage = createCancelGTCOrderMassage(pin: pin, gtcId: gtcId);

    order.addMassage(ModelMassage(massage: massage));
  }

  static reqListAdvaceOrder(
      {int? status,
      required int pin,
      required int packageID,
      String? accountId}) {
    Uint8List massage = createListAdvaceOrderMassage(
      pin: pin,
      packageID: packageID,
      status: status,
    );
    order.addMassage(ModelMassage(massage: massage));
  }

//START BREAK ORDER
  // acountId not change
  static reqBreakOrderList(
      {required int status, required int pin, required String accountId}) {
    Uint8List massage = createBreakOrderListMassage(
        pin: pin, status: status, accountId: accountId);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqBreakOrder({required BreakOrderMassageModel data}) {
    Uint8List massage = createBreakOrderMassage(data);

    order.addMassage(ModelMassage(massage: massage));
  }

  static reqCancelBreakOrder({required String breakID, required int pin}) {
    Uint8List massage = createCancelBreakOrderMassage(
      pin: pin,
      breakID: breakID,
    );

    order.addMassage(ModelMassage(massage: massage));
  }

//END BREAK ORDER

  static reqTralingOrder({required TralingModelReq data}) {
    Uint8List massage = createTralingOrder(
      pin: data.pin,
      command: data.command,
      volume: data.volume,
      trailingStep: data.trailingStep,
      priceType: data.priceType,
      stockCode: data.stockCode,
      accountId: data.accountId,
      autoOrder: data.autoOrder,
      board: data.board,
      buyorsellAT: data.buyorsellAT,
      dropPrice: data.dropPrice,
      dueDate: data.dueDate,
      effDate: data.effDate,
    );

    order.addMassage(ModelMassage(massage: massage));
  }

  // acountId not change
  static reqListTrailingList(
      {required int status, required int pin, required String accountId}) {
    Uint8List massage = createListTrailingMassage(pin: pin, status: status);
    order.addMassage(ModelMassage(massage: massage));
  }

  static reqCancelTralingOrder({required int pin, required String tralingID}) {
    Uint8List massage = createCancelTralingOrderMassage(
      pin: pin,
      tralingID: tralingID,
    );

    order.addMassage(ModelMassage(massage: massage));
  }
}
