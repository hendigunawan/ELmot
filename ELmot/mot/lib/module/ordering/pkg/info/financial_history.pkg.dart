import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/financial_history.model.dart';

RxList<FinancialHistoryModel> listFinancialHistory =
    <FinancialHistoryModel>[].obs;
financialHistoryPKG(Uint8List buf) {
  listFinancialHistory.clear();
  var getController = Get.find<EncryptControll>();
  List<ArrayFinancialhistoryModel> listD = [];
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int Lref = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, Lref);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int period = getController.encrypt4(buf);
  int rdnBalance = getController.encrypt8(buf);
  int arrayCount = getController.encrypt4(buf);
  for (int i = 0; i < arrayCount; i++) {
    int transactionDate = getController.encrypt4(buf);
    int descriptionsLength = getController.encrypt2(buf);
    String descriptions = getController.getAsciiString(buf, descriptionsLength);
    int debit = getController.encrypt8(buf);
    int credit = getController.encrypt8(buf);
    int balance = getController.encrypt8(buf);
    listD.add(ArrayFinancialhistoryModel()
      ..transactionDate = transactionDate
      ..descriptions = descriptions
      ..debit = debit
      ..credit = credit
      ..balance = balance);
  }
  FinancialHistoryModel data = FinancialHistoryModel()
    ..loginID = loginID
    ..reference = Ref
    ..accountId = accountId
    ..period = period
    ..rdnBalance = rdnBalance
    ..array = listD;

  listFinancialHistory.add(data);
  return data;
}
