import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/transaction_report.model.dart';

RxList<TransactionReportModelRemainYear> listTransactionreportRemainyear =
    <TransactionReportModelRemainYear>[].obs;
RxList<TransactionReportModel> listTransactionreportBYYEAR =
    <TransactionReportModel>[].obs;
transactionreportPKG(Uint8List buf) {
  List<ArrayTransactionReport> listD = [];
  List<ArrayTransactionReportModelRemainYear> remainYear = [];
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int lRef = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, lRef);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int reqType = getController.encrypt1(buf);
  if (reqType == 0) {
    listTransactionreportRemainyear.clear();
    int AR = getController.encrypt4(buf);
    for (int i = 0; i < AR; i++) {
      int year = getController.encrypt4(buf);

      remainYear.add(
        ArrayTransactionReportModelRemainYear()..remainYear = year,
      );
    }
    TransactionReportModelRemainYear data = TransactionReportModelRemainYear()
      ..loginId = loginID
      ..reference = Ref
      ..requestType = reqType
      ..accountId = accountId
      ..array = remainYear;
    listTransactionreportRemainyear.add(data);
    return data;
  } else {
    listTransactionreportBYYEAR.clear();
    int transactionReportPeriod = getController.encrypt4(buf);
    int arrayCount = getController.encrypt4(buf);
    for (int i = 0; i < arrayCount; i++) {
      int date = getController.encrypt4(buf);
      int command = getController.encrypt1(buf);
      int boardL = getController.encrypt2(buf);
      String board = getController.getAsciiString(buf, boardL);
      int produkstockcodeL = getController.encrypt2(buf);
      String productStockCode =
          getController.getAsciiString(buf, produkstockcodeL);
      int price = getController.encrypt4(buf);
      int qty = getController.encrypt8(buf);
      int grossAmount = getController.encrypt8(buf);
      int brokerFee = getController.encrypt8(buf);
      int levy = getController.encrypt8(buf);
      int wht = getController.encrypt8(buf);
      int vat = getController.encrypt8(buf);
      int salesTax = getController.encrypt8(buf);
      int subTotalFees = getController.encrypt8(buf);
      int netAmount = getController.encrypt8(buf);
      listD.add(
        ArrayTransactionReport()
          ..date = date
          ..command = command
          ..board = board
          ..productStockCode = productStockCode
          ..price = price
          ..qty = qty
          ..grossAmount = grossAmount
          ..brokerFee = brokerFee
          ..levy = levy
          ..wht = wht
          ..vat = vat
          ..salesTax = salesTax
          ..subTotalFees = subTotalFees
          ..netAmount = netAmount,
      );
    }
    int totalGrossAmount = getController.encrypt8(buf);
    int totalBrokerFee = getController.encrypt8(buf);
    int totalLevy = getController.encrypt8(buf);
    int totalWht = getController.encrypt8(buf);
    int totalVAT = getController.encrypt8(buf);
    int totalSalesTax = getController.encrypt8(buf);
    int totalFees = getController.encrypt8(buf);
    int totalNetAmount = getController.encrypt8(buf);
    TransactionReportModel data = TransactionReportModel()
      ..loginId = loginID
      ..reference = Ref
      ..accountId = accountId
      ..requestType = reqType
      ..transactionReportPeriod = transactionReportPeriod
      ..arrayTransReport = listD
      ..totalGrossAmount = totalGrossAmount
      ..totalBrokerFee = totalBrokerFee
      ..totalLevy = totalLevy
      ..totalWht = totalWht
      ..totalVAT = totalVAT
      ..totalSalesTax = totalSalesTax
      ..totalFees = totalFees
      ..totalNetAmount = totalNetAmount;
    listTransactionreportBYYEAR.add(data);
    return data;
  }
}
