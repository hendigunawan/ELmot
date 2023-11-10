// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/heart_bit.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/cash_ledger.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/change_password.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/exercise_list.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/exercise_righ_warrant_info.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/financial_history.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/fund_withdraw_info.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/fund_withdraw_list.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/login_order.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/monthly_balance.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/trade_list.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/transaction_n_holidays.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/breakorderlist.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/historical_orderlist.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/historical_tradeList.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/orderListReq.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/rejectedOrderMassage.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolio.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolioreturn.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/realized_gainlost.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/requestGTCList.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/requestTralingList.pkg.dart';
import 'package:online_trading/module/ordering/pkg/order/validate_pin.pkg.dart';
import 'package:online_trading/module/ordering/pkg/realtime/login_realtime.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/req_accountinfo.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/stock_balance.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/tax_report.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/tradeconfirmation.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/trading_limit.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/transactionreport.pkg.dart';
import 'package:online_trading/module/ordering/pkg/realtime/order_BuyAndSell.realtime.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cash_withdraw_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/rightwarrant_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/list_break_order.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/controller/newGTC.controller.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/list_trailing/main_list_trailing.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

class DataProses {
  static order(
    Uint8List buf, {
    required String routingKey,
    required int idPackage,
  }) {
    if (idPackage == Constans.PACKAGE_ID_LOGIN_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_LOGIN_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_LOGIN_ORDER}");
      return loginOrderPkg(buf);
    } else if (idPackage == Constans.PACKAGE_ID_LOGOUT_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_LOGOUT_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_LOGOUT_ORDER}");

      NotifikasiPopup.showSUCCESS(
        'SUCCESS\nLOGOUT',
        onClose: () {
          Get.find<LogoutController>().onLogoutSuccess();
        },
        onTap: () {
          Get.find<LogoutController>().onLogoutSuccess();
        },
      );
    } else if (idPackage == Constans.PACKAGE_ID_VALIDATE_PIN_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_VALIDATE_PIN_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_VALIDATE_PIN_ORDER}");
      return validatePINREQ(buf);
    } else if (idPackage == Constans.PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER}");
      return changepasswordPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER}");
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_TRADING_LIMIT_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_TRADING_LIMIT_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_TRADING_LIMIT_ORDER}");
      return tradingLimitPKGorder(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_STOCK_BALENCE_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_STOCK_BALENCE_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_STOCK_BALENCE_ORDER}");
      return stockBalancePkg(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_ACCOUNT_INFO_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_ACCOUNT_INFO_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_ACCOUNT_INFO_ORDER}");
      return accountInfo(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_REALIZED_GAID_OR_LOST_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_REALIZED_GAID_OR_LOST_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_REALIZED_GAID_OR_LOST_ORDER}");
      return realizedPKGORDer(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_TRADE_CONFIRMATION_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_TRADE_CONFIRMATION_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_TRADE_CONFIRMATION_ORDER}");

      return tradeconfirmationPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_TAX_INFO_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_TAX_INFO_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_TAX_INFO_ORDER}");
      return taxReportOrderMassage(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_PORTFOLIO_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_PORTFOLIO_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_PORTFOLIO_ORDER}");
      return portopolio(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_PORTFOLIO_RETURN_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_PORTFOLIO_RETURN_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_PORTFOLIO_RETURN_ORDER}");
      return portopolioReturnPKG(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_INFO_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_INFO_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_INFO_ORDER}");
      return fundwithdrawInfoPKG(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_LIST_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_LIST_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_LIST_ORDER}");
      return fundWithDrawListPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_TRADE_LIST_REQUEST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_TRADE_LIST_REQUEST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_TRADE_LIST_REQUEST}");
      return tradeListPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_ORDER}");
      NotifikasiPopup.showSUCCESS('CASH WITHDRAWAL\nSUCCESSFUL');
      Get.find<DateController>().requestupdateData();
      Get.find<DateController>().requestNewList();
    } else if (idPackage == Constans.PACKAGE_ID_CANCEL_FUND_WITHDRAWAL_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_CANCEL_FUND_WITHDRAWAL_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_CANCEL_FUND_WITHDRAWAL_ORDER}");
      NotifikasiPopup.showSUCCESS('CANCEL WITHDRAWAL\nSUCCESSFUL');
      Get.find<DateController>().requestupdateData();
      Get.find<DateController>().requestNewList();
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_FINANCIAL_HISTORY_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_FINANCIAL_HISTORY_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_FINANCIAL_HISTORY_ORDER}");
      return financialHistoryPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_HISTORICAL_ORDER_LIST_REQUEST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_HISTORICAL_ORDER_LIST_REQUEST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_HISTORICAL_ORDER_LIST_REQUEST}");
      return historicalorderListReq(buf);
    } else if (idPackage == Constans.PACKAGE_ID_HISTORICAL_TRADE_LIST_REQUEST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_HISTORICAL_TRADE_LIST_REQUEST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_HISTORICAL_TRADE_LIST_REQUEST}");
      return historicaltradeListReq(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_CASH_LEDGER_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_CASH_LEDGER_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_CASH_LEDGER_ORDER}");
      return cashledgerPKG(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_SINGLE_STOCK_BALENCE_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_SINGLE_STOCK_BALENCE_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_SINGLE_STOCK_BALENCE_ORDER}");
    } else if (idPackage == Constans.PACKAGE_ID_VALIDATE_LOGIN_PASSWORD_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_VALIDATE_LOGIN_PASSWORD_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_VALIDATE_LOGIN_PASSWORD_ORDER}");
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_INFO_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_INFO_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_INFO_ORDER}");
      return exerciseWarrantInfoPKG(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_LIST_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_LIST_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_LIST_ORDER}");
      return exerciseWarrantListPKG(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_ORDER}");
      NotifikasiPopup.showSUCCESS('EXERCISE\nRIGHT/WARRANT\nSUCCESSFUL');
      Get.find<requestnewValController>().reqNewVal();
    } else if (idPackage ==
        Constans.PACKAGE_ID_CANCEL_EXERCISE_RIGH_OR_WARRANT_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_CANCEL_EXERCISE_RIGH_OR_WARRANT_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_CANCEL_EXERCISE_RIGH_OR_WARRANT_ORDER}");
      NotifikasiPopup.showSUCCESS('CANCEL\nEXERCISE\nSUCCESSFUL');
      Get.find<requestnewValController>().reqNewVal();
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_STOCK_COLLATERAL_INFO_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_STOCK_COLLATERAL_INFO_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_STOCK_COLLATERAL_INFO_ORDER}");
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_TRANSACTION_AND_HOLIDAYS_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_TRANSACTION_AND_HOLIDAYS_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_TRANSACTION_AND_HOLIDAYS_ORDER}");
      return transactionnholidaysPKG(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_CORPORATE_ACTION_INFORMATION_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_CORPORATE_ACTION_INFORMATION_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_CORPORATE_ACTION_INFORMATION_ORDER}");
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_TRANSACTIONS_REPORT_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_TRANSACTIONS_REPORT_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_TRANSACTIONS_REPORT_ORDER}");
      return transactionreportPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_MONTHLY_BALANCE_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_MONTHLY_BALANCE_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_MONTHLY_BALANCE_ORDER}");
      return monthlyBalancePKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_SPEED_ORDER_BOOK_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_SPEED_ORDER_BOOK_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_SPEED_ORDER_BOOK_ORDER}");
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_ORDER}");
      NotifikasiPopup.showSUCCESS('NEW ORDER SUCCESS');
      Get.find<BodyController>().onClear();
    } else if (idPackage == Constans.PACKAGE_ID_ORDER_LIST_REQUEST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_ORDER_LIST_REQUEST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_ORDER_LIST_REQUEST}");
      return orderListReq(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_REQUEST_REJECTED_ORDER_MASSAGE) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_REJECTED_ORDER_MASSAGE");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_REJECTED_ORDER_MASSAGE}");
      return rejectedOrderMassagePkg(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_WITHDRAW) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_WITHDRAW");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_WITHDRAW}");
      NotifikasiPopup.showSUCCESS('WITHDRAW SUCCESS');
      OrderMassage.orderListReq(
        Get.find<PinSave>().pin.value,
        accountId.value == ''
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId!
            : accountId.value,
      );
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_AMEND) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_AMEND");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_AMEND}");
      NotifikasiPopup.showSUCCESS('AMEND SUCCESS');
      OrderMassage.orderListReq(
        Get.find<PinSave>().pin.value,
        accountId.value == ''
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId!
            : accountId.value,
      );
    } else if (idPackage == Constans.PACKAGE_ID_LOGIN_REPLY_ORDER_REALTIME) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_LOGIN_REPLY_ORDER_REALTIME");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_LOGIN_REPLY_ORDER_REALTIME}");
      return loginOrderRealtime(buf);
    } else if (idPackage ==
        Constans.PACKAGE_ID_NEW_ORDER_REPLY_ORDER_REALTIME) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_NEW_ORDER_REPLY_ORDER_REALTIME");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_NEW_ORDER_REPLY_ORDER_REALTIME}");
      return orderStatusRealtime(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_GTC_ORDER_LIST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_GTC_ORDER_LIST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_GTC_ORDER_LIST}");
      return requestGTCListPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_NEW_BREAK_OERDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_NEW_BREAK_OERDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_NEW_BREAK_OERDER}");
      NotifikasiPopup.showSUCCESS('New BREAK Order SUCCESS');
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_CANCLE_BREAKE_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_CANCLE_BREAKE_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_CANCLE_BREAKE_ORDER}");
      NotifikasiPopup.showSUCCESS('Cancel BREAK Order SUCCESS');
      OrderMassage.reqBreakOrderList(
        accountId: accountId.value == ""
            ? Get.find<LoginOrderController>()
                .order!
                .value
                .account!
                .first
                .accountId
                .toString()
            : accountId.value,
        pin: int.parse(Get.find<PinSave>().pin.value),
        status: int.parse(selectedTypeBreak.value),
      );
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_BREAK_OERDER_LIST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_BREAK_OERDER_LIST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_BREAK_OERDER_LIST}");
      return requestBreakOrderListPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_NEW_GTC_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_NEW_GTC_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_NEW_GTC_ORDER}");
      NotifikasiPopup.showSUCCESS('New GTC Order SUCCESS');
      // return loginOrderRealtime(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_CANCEL_GTC_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_CANCEL_GTC_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_CANCEL_GTC_ORDER}");
      NotifikasiPopup.showSUCCESS('GTC CANCEL SUCCESS');
      Get.put(NewGTCController()).getList();
      // return loginOrderRealtime(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_NEW_TRAILING_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_NEW_TRAILING_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_NEW_TRAILING_ORDER}");
      NotifikasiPopup.showSUCCESS('New Traling Order SUCCESS');
      // return loginOrderRealtime(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_CANCLE_TRAILING_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_CANCLE_TRAILING_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_CANCLE_TRAILING_ORDER}");
      NotifikasiPopup.showSUCCESS('Cancle Traling Order SUCCESS');
      OrderMassage.reqListTrailingList(
          accountId: accountId.value == ""
              ? Get.find<LoginOrderController>()
                  .order!
                  .value
                  .account!
                  .first
                  .accountId
                  .toString()
              : accountId.value,
          pin: int.parse(Get.find<PinSave>().pin.value),
          status: int.parse(selectedType.value));
      // return loginOrderRealtime(buf);
    } else if (idPackage == Constans.PACKAGE_ID_REQUEST_TRAILING_ORDER_LIST) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REQUEST_TRAILING_ORDER_LIST");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REQUEST_TRAILING_ORDER_LIST}");
      return requestTralingOrderListPKG(buf);
    } else if (idPackage == Constans.PACKAGE_ID_HEARTBIT_ORDER) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_HEARTBIT_ORDER");
      print("ROUTING_KEY: $routingKey");
      print("ORDER_ID: $idPackage");
      print("NAME: ${getName(buf)}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_HEARTBIT_ORDER}");
      print(
        'TIME FEEDBACK: ${DateTime.now().difference(Get.find<HeartLove>().timestampStartFeedBack!.value).inSeconds} SECONDS',
      );
      Get.find<HeartLove>().timestampStartFeedBack = DateTime.now().obs;
    } else {
      print(
          "DATA DENGAN: ROUTING_KEY: $routingKey, ORDER_ID: $idPackage DAN NAME: ${getName(buf)} TIDAK DITEMUKAN");
    }
  }

  static String getName(Uint8List buff) {
    int pos = Constans.PACKAGE_HEADER_LENGTH;
    String name = '';
    if (pos <= buff.length) {
      int len = Encrypt().encrypt2(buff, pos);
      if (len < 100) {
        name = Encrypt().getAsciiString(buff, pos + 2, len);
      }
    }
    return name;
  }
}
