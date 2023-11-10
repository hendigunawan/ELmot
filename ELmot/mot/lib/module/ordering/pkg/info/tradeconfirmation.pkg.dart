import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/trade_confirmation.model.dart';

// LIST BY DATE
RxList<TradeConfirmationBYDATE> listtradeconfirmationBYDATE =
    <TradeConfirmationBYDATE>[].obs;
// BATAS

// LIST REMAIN DATE
RxList<TradeConfirmationRemainDate> listtradeconfirmationREMAINDATE =
    <TradeConfirmationRemainDate>[].obs;
// BATAS
tradeconfirmationPKG(Uint8List buf) {
  List<ArrayTradeConfirmationRemainDate> listRemain = [];
  // ARRAY BY DATE
  List<ArrayCountPertama> listBUY = [];
  List<ArrayCountSell> listSELL = [];
  // BATAS BAWAH
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
    listtradeconfirmationREMAINDATE.clear();

    // BACA ARRAY REMAIN
    int AR = getController.encrypt4(buf);
    for (int i = 0; i < AR; i++) {
      int tcDateList = getController.encrypt4(buf);
      listRemain
          .add(ArrayTradeConfirmationRemainDate()..tcDateList = tcDateList);
    }
    // BATAS

    TradeConfirmationRemainDate data = TradeConfirmationRemainDate()
      ..loginId = loginID
      ..reference = Ref
      ..accountId = accountId
      ..requestType = reqType
      ..array = listRemain;
    listtradeconfirmationREMAINDATE.add(data);
    return data;
  } else {
    listtradeconfirmationBYDATE.clear();
    int tcDate = getController.encrypt4(buf);
    // BACA ARRAY BUY
    int ArrayBUY = getController.encrypt4(buf);
    for (int i = 0; i < ArrayBUY; i++) {
      int stockCL = getController.encrypt2(buf);
      String stockCode = getController.getAsciiString(buf, stockCL);
      int price = getController.encrypt4(buf);
      int qty = getController.encrypt8(buf);
      int grossAmount = getController.encrypt8(buf);
      int brokerFee = getController.encrypt8(buf);
      int levy = getController.encrypt8(buf);
      int wht = getController.encrypt8(buf);
      int vat = getController.encrypt8(buf);
      int netAmount = getController.encrypt8(buf);
      listBUY.add(ArrayCountPertama()
        ..stockcode = stockCode
        ..price = price
        ..qty = qty
        ..grossAmount = grossAmount
        ..brokerFee = brokerFee
        ..levy = levy
        ..wht = wht
        ..vat = vat
        ..netAmount = netAmount);
    }
    // BATAS BACA ARRAY BUY
    int totalGrossAmount = getController.encrypt8(buf);
    int totalBrokerFee = getController.encrypt8(buf);
    int totalLevy = getController.encrypt8(buf);
    int totalWht = getController.encrypt8(buf);
    int totalVAT = getController.encrypt8(buf);
    int totalNetAmount = getController.encrypt8(buf);

    // BACA ARRAY SELL
    int arraySELL = getController.encrypt4(buf);
    for (int i = 0; i < arraySELL; i++) {
      int stockCLSELL = getController.encrypt2(buf);
      String stockCodeSELL = getController.getAsciiString(buf, stockCLSELL);
      int priceSELL = getController.encrypt4(buf);
      int qtySELL = getController.encrypt8(buf);
      int grossAmountSELL = getController.encrypt8(buf);
      int brokerFeeSELL = getController.encrypt8(buf);
      int levySELL = getController.encrypt8(buf);
      int whtSELL = getController.encrypt8(buf);
      int vatSELL = getController.encrypt8(buf);
      int salesTaxSELL = getController.encrypt8(buf);
      int netAmountSELL = getController.encrypt8(buf);

      listSELL.add(ArrayCountSell()
        ..stockcode = stockCodeSELL
        ..price = priceSELL
        ..qty = qtySELL
        ..grossAmount = grossAmountSELL
        ..brokerFee = brokerFeeSELL
        ..levy = levySELL
        ..wht = whtSELL
        ..vat = vatSELL
        ..salesTax = salesTaxSELL
        ..netAmount = netAmountSELL);
    }
    int totalGrossAmountSELL = getController.encrypt8(buf);
    int totalBrokerFeeSELL = getController.encrypt8(buf);
    int totalLevySELL = getController.encrypt8(buf);
    int totalWhtSELL = getController.encrypt8(buf);
    int totalVATSELL = getController.encrypt8(buf);
    int totalSalestaxSELL = getController.encrypt8(buf);
    int totalNetAmountSELL = getController.encrypt8(buf);

    // BATAS BACA ARRAY SELL

    //  AKHIR
    int netPurchaseSELL = getController.encrypt8(buf);
    int grandtotalBrokerFEE = getController.encrypt8(buf);
    int grandtotalLevy = getController.encrypt8(buf);
    int grandtotalWHT = getController.encrypt8(buf);
    int grandtotalVAT = getController.encrypt8(buf);
    int salesTaxAKHIR = getController.encrypt8(buf);
    int grandTotal = getController.encrypt8(buf);
    int otherFee = getController.encrypt8(buf);

    TradeConfirmationBYDATE data = TradeConfirmationBYDATE()
      ..loginId = loginID
      ..reference = Ref
      ..accountId = accountId
      ..requestType = reqType
      ..tcDate = tcDate
      ..arraycountpertama = listBUY
      ..totalGrossAmount = totalGrossAmount
      ..totalBrokerFee = totalBrokerFee
      ..totalLevy = totalLevy
      ..totalWht = totalWht
      ..totalVAT = totalVAT
      ..totalNetAmount = totalNetAmount
      ..arraycountkedua = listSELL
      ..totalGrossAmountAR2 = totalGrossAmountSELL
      ..totalBrokerFeeAR2 = totalBrokerFeeSELL
      ..totalLevyAR2 = totalLevySELL
      ..totalWhtAR2 = totalWhtSELL
      ..totalVATAR2 = totalVATSELL
      ..totalSalesTaxAR2 = totalSalestaxSELL
      ..totalNetAmountAR2 = totalNetAmountSELL
      ..netPurchaseSELL = netPurchaseSELL
      ..grandtotalBrokerFEE = grandtotalBrokerFEE
      ..grandtotalLevy = grandtotalLevy
      ..grandtotalWHT = grandtotalWHT
      ..grandtotalVAT = grandtotalVAT
      ..salesTax = salesTaxAKHIR
      ..grandTotal = grandTotal
      ..otherFee = otherFee;
    listtradeconfirmationBYDATE.clear();
    listtradeconfirmationBYDATE.add(data);
    return data;
    // BATAS AKHIR
  }
}
