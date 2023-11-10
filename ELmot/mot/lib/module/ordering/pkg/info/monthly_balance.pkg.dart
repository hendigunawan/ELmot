import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/monthly_balance.model.dart';

RxList<MonthlyBalanceByYear> listmonthlybalanceBYYEAR =
    <MonthlyBalanceByYear>[].obs;
RxList<MonthlyBalanceRemainYear> listmonthlybalanceREMAINYEAR =
    <MonthlyBalanceRemainYear>[].obs;

monthlyBalancePKG(Uint8List buf) {
  List<ArrayMonthlyBalanceRemainYear> listRemain = [];
  List<ArrayMonthlyBalanceByYear> listD = [];
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
    listmonthlybalanceREMAINYEAR.clear();

    int AR = getController.encrypt4(buf);
    for (int i = 0; i < AR; i++) {
      int date = getController.encrypt4(buf);
      listRemain.add(ArrayMonthlyBalanceRemainYear()..remainyearData = date);
    }

    MonthlyBalanceRemainYear data = MonthlyBalanceRemainYear()
      ..loginId = loginID
      ..reference = Ref
      ..accountId = accountId
      ..requestType = reqType
      ..array = listRemain;
    listmonthlybalanceREMAINYEAR.add(data);
    return data;
  } else {
    listmonthlybalanceBYYEAR.clear();
    int date = getController.encrypt4(buf);

    int array = getController.encrypt4(buf);
    for (int i = 0; i < array; i++) {
      int stockCL = getController.encrypt2(buf);
      String stockCode = getController.getAsciiString(buf, stockCL);
      int avgPrice = getController.encrypt4(buf);
      int closeprice = getController.encrypt4(buf);
      int balanceqty = getController.encrypt8(buf);
      int marketValue = getController.encrypt8(buf);
      int potentialGainLoss = getController.encrypt8(buf);
      int potentialGainLossPercentage = getController.encrypt4(buf);
      listD.add(ArrayMonthlyBalanceByYear()
        ..stockcode = stockCode
        ..avgPrice = avgPrice
        ..closePrice = closeprice
        ..balanceQty = balanceqty
        ..marketValue = marketValue
        ..potentialGainLoss = potentialGainLoss
        ..potentialGainLossPercentage = potentialGainLossPercentage);
    }
    int totalMarketValue = getController.encrypt8(buf);
    int totalPotentialGainLoss = getController.encrypt8(buf);
    int totalPotentialGainLossPercentage = getController.encrypt4(buf);
    int totalCash = getController.encrypt8(buf);
    int totalAsset = getController.encrypt8(buf);

    MonthlyBalanceByYear data = MonthlyBalanceByYear()
      ..loginId = loginID
      ..reference = Ref
      ..accountId = accountId
      ..requestType = reqType
      ..yearDate = date
      ..array = listD
      ..totalMarketValue = totalMarketValue
      ..totalPotentialGainLoss = totalPotentialGainLoss
      ..totalPotentialGainLossPercentage = totalPotentialGainLossPercentage
      ..totalCash = totalCash
      ..totalAsset = totalAsset;
    listmonthlybalanceBYYEAR.clear();
    listmonthlybalanceBYYEAR.add(data);
    return data;
  }
}
