import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/tax_report.model.dart';

RxList<TaxReportData> listTaxReport = <TaxReportData>[].obs;
RxList<TaxReportDataBYYear> listtaxreportBYYEAR = <TaxReportDataBYYear>[].obs;
taxReportOrderMassage(Uint8List buf) {
  List<TaxReportArrayList> listd = [];
  List<ArrayTaxReportDataBYYear> listarrayByYear = [];
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int lRef = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, lRef);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int REQType = getController.encrypt1(buf);
  if (REQType == 0) {
    listTaxReport.clear();
    int AR = getController.encrypt4(buf);
    for (int i = 0; i < AR; i++) {
      int TAXRYEAR = getController.encrypt4(buf);

      listd.add(
        TaxReportArrayList()..taxReportYearlist = TAXRYEAR,
      );
    }
    TaxReportData taxData = TaxReportData()
      ..loginId = loginID
      ..reference = Ref
      ..requestType = REQType
      ..accountId = accountId
      ..taxReportArrayy = listd;
    listTaxReport.add(taxData);
    return taxData;
  } else {
    listtaxreportBYYEAR.clear();
    int taxReportYear = getController.encrypt4(buf);
    int AR = getController.encrypt4(buf);
    for (int i = 0; i < AR; i++) {
      int date = getController.encrypt4(buf);
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
      int netAmount = getController.encrypt8(buf);
      listarrayByYear.add(ArrayTaxReportDataBYYear()
        ..date = date
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
        ..netAmount = netAmount);
    }
    int totalGrossAmount = getController.encrypt8(buf);
    int totalBrokerFee = getController.encrypt8(buf);
    int totalLevy = getController.encrypt8(buf);
    int totalWht = getController.encrypt8(buf);
    int totalVAT = getController.encrypt8(buf);
    int totalSalesTax = getController.encrypt8(buf);
    int totalNetAmount = getController.encrypt8(buf);
    TaxReportDataBYYear data = TaxReportDataBYYear()
      ..loginId = loginID
      ..reference = Ref
      ..accountId = accountId
      ..requestType = REQType
      ..taxReportYear = taxReportYear
      ..taxReportArrayybyyear = listarrayByYear
      ..totalGrossAmount = totalGrossAmount
      ..totalBrokerFee = totalBrokerFee
      ..totalLevy = totalLevy
      ..totalWht = totalWht
      ..totalVAT = totalVAT
      ..totalSalesTax = totalSalesTax
      ..totalNetAmount = totalNetAmount;
    listtaxreportBYYEAR.add(data);
    return data;
  }
}
