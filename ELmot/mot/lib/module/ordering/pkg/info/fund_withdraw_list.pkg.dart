import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/fund_withdraw_list.model.dart';

RxList<FundWithDrawList> listFundWithDrawList = <FundWithDrawList>[].obs;
FundWithDrawList fundWithDrawListPKG(Uint8List buf) {
  listFundWithDrawList.clear();
  List<ArrayFundWithDrawList> listD = [];
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int Lref = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, Lref);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int status = getController.encrypt1(buf);
  int fromDate = getController.encrypt4(buf);
  int toDate = getController.encrypt4(buf);
  int arrayCount = getController.encrypt4(buf);
  for (int i = 0; i < arrayCount; i++) {
    int transferId = getController.encrypt8(buf);
    int subscribeDate = getController.encrypt4(buf);
    int subscribeTime = getController.encrypt4(buf);
    int transferDate = getController.encrypt4(buf);
    int executedDate = getController.encrypt4(buf);
    int amount = getController.encrypt8(buf);
    int fee = getController.encrypt4(buf);
    int rtgs = getController.encrypt1(buf);

    int bankIdL = getController.encrypt2(buf);
    String bankId = getController.getAsciiString(buf, bankIdL);
    int lbankaccount = getController.encrypt2(buf);
    String bankAccount = getController.getAsciiString(buf, lbankaccount);
    int status = getController.encrypt1(buf);
    int LinputBy = getController.encrypt2(buf);
    String inputBy = getController.getAsciiString(buf, LinputBy);
    int Lmessage = getController.encrypt2(buf);
    String message = getController.getAsciiString(buf, Lmessage);
    listD.add(ArrayFundWithDrawList()
      ..transferId = transferId
      ..subscribeDate = subscribeDate
      ..subscribeTime = subscribeTime
      ..transferDate = transferDate
      ..executedDate = executedDate
      ..amount = amount
      ..fee = fee
      ..rtgs = rtgs
      ..bankId = bankId
      ..bankAccount = bankAccount
      ..status = status
      ..inputBy = inputBy
      ..message = message);
  }
  listD.sort((b, a) => a.subscribeTime!.compareTo(b.subscribeTime!));
  FundWithDrawList data = FundWithDrawList()
    ..loginID = loginID
    ..reference = Ref
    ..accountId = accountId
    ..status = status
    ..fromDate = fromDate
    ..toDate = toDate
    ..array = listD;
  listFundWithDrawList.add(data);
  return data;
}
