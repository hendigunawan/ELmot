import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/portopolio.model.dart';

RxList<Portopolio>? listPortopolio = <Portopolio>[].obs;

Portopolio portopolio(Uint8List buf) {
  List<ArrayPotopolio> listD = [];
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int loginIdLen = getController.encrypt2(buf);
  String loginId = getController.getAsciiString(buf, loginIdLen);
  int referenceLen = getController.encrypt2(buf);
  String reference = getController.getAsciiString(buf, referenceLen);
  int accountIdLen = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, accountIdLen);
  int currentCash = getController.encrypt8(buf);
  int cashOnTPlus3 = getController.encrypt8(buf);
  int remainTradingLimit = getController.encrypt8(buf);
  int currentRatio = getController.getDouble(buf);
  int marketRatio = getController.getDouble(buf);
  int potentialRatio = getController.getDouble(buf);

  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int LStock = getController.encrypt2(buf);
    String stockCode = getController.getAsciiString(buf, LStock);
    int avgPrice = getController.encrypt4(buf);
    int lastPrice = getController.encrypt4(buf);
    int volume = getController.encrypt8(buf);
    int balance = getController.encrypt8(buf);
    int openSellVolume = getController.encrypt8(buf);
    int openBuyVolume = getController.encrypt8(buf);
    int marketValue = getController.encrypt8(buf);
    int haircut = getController.encrypt4(buf);
    int potentialGainLoss = getController.encrypt8(buf);
    int potentialGainLossPercentage = getController.getDouble(buf);
    int marginableStock = getController.encrypt1(buf);
    int containCAInformation = getController.encrypt1(buf);

    listD.add(
      ArrayPotopolio()
        ..stockCode = stockCode
        ..avgPrice = avgPrice
        ..lastPrice = lastPrice
        ..volume = volume
        ..balance = balance
        ..openSellVolume = openSellVolume
        ..openBuyVolume = openBuyVolume
        ..marketValue = marketValue
        ..haircut = haircut
        ..potentialGainLoss = potentialGainLoss
        ..potentialGainLossPercentage = potentialGainLossPercentage
        ..marginableStock = marginableStock
        ..containCAInformation = containCAInformation,
    );
  }

  int totalMarketValue = getController.encrypt8(buf);
  int totalPotentialGainLoss = getController.encrypt8(buf);
  int totalPotentialGainLossPercentage = getController.getDouble(buf);
  int t0Date = getController.encrypt4(buf);
  int t0AR = getController.encrypt8(buf);
  int t0AP = getController.encrypt8(buf);
  int t0FundTransferRequest = getController.encrypt8(buf);
  int t0NetCash = getController.encrypt8(buf);
  int t1Date = getController.encrypt4(buf);
  int t1AR = getController.encrypt8(buf);
  int t1AP = getController.encrypt8(buf);
  int t1FundTransferRequest = getController.encrypt8(buf);
  int t1NetCash = getController.encrypt8(buf);
  int t2Date = getController.encrypt4(buf);
  int t2AR = getController.encrypt8(buf);
  int t2AP = getController.encrypt8(buf);
  int t2FundTransferRequest = getController.encrypt8(buf);
  int t2NetCash = getController.encrypt8(buf);
  int t3Date = getController.encrypt4(buf);
  int t3AR = getController.encrypt8(buf);
  int t3AP = getController.encrypt8(buf);
  int t3FundTransferRequest = getController.encrypt8(buf);
  int t3NetCash = getController.encrypt8(buf);
  int interest = getController.encrypt8(buf);
  listPortopolio!.clear();
  Portopolio data = Portopolio()
    ..loginId = loginId
    ..reference = reference
    ..accountId = accountId
    ..currentCash = currentCash
    ..cashOnTPlus3 = cashOnTPlus3
    ..remainTradingLimit = remainTradingLimit
    ..currentRatio = currentRatio
    ..marketRatio = marketRatio
    ..potentialRatio = potentialRatio
    ..arrayPorto = listD
    ..totalMarketValue = totalMarketValue
    ..totalPotentialGainLoss = totalPotentialGainLoss
    ..totalPotentialGainLossPercentage = totalPotentialGainLossPercentage
    ..t0Date = t0Date
    ..t0AR = t0AR
    ..t0AP = t0AP
    ..t0FundTransferRequest = t0FundTransferRequest
    ..t0NetCash = t0NetCash
    ..t1Date = t1Date
    ..t1AR = t1AR
    ..t1AP = t1AP
    ..t1FundTransferRequest = t1FundTransferRequest
    ..t1NetCash = t1NetCash
    ..t2Date = t2Date
    ..t2AR = t2AR
    ..t2AP = t2AP
    ..t2FundTransferRequest = t2FundTransferRequest
    ..t2NetCash = t2NetCash
    ..t3Date = t3Date
    ..t3AR = t3AR
    ..t3AP = t3AP
    ..t3FundTransferRequest = t3FundTransferRequest
    ..t3NetCash = t3NetCash
    ..interest = interest;

  listPortopolio!.add(data);
  listPortopolio!.refresh();
  return data;
}
