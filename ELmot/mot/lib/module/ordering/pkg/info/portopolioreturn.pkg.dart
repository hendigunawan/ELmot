import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/portopolioreturn.model.dart';

RxList<PortopolioReturn>? listPortopolioreturn = <PortopolioReturn>[].obs;

PortopolioReturn portopolioReturnPKG(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  List<ArrayPotopolioReturn> listD = [];
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int Lref = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, Lref);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int rType = getController.encrypt1(buf);
  int startDate = getController.encrypt4(buf);
  int endDate = getController.encrypt4(buf);
  int arrayCount = getController.encrypt4(buf);
  for (int i = 0; i < arrayCount; i++) {
    int date = getController.encrypt4(buf);
    int assetVal = getController.encrypt8(buf);
    int deposit = getController.encrypt8(buf);
    int withDraw = getController.encrypt8(buf);
    int unrealizedGainLoss = getController.encrypt8(buf);
    int yieldpercen = getController.getDouble(buf);
    listD.add(ArrayPotopolioReturn()
      ..date = date
      ..assetValue = assetVal
      ..deposit = deposit
      ..withdraw = withDraw
      ..unrealizedGainLoss = unrealizedGainLoss
      ..yieldPercentage = yieldpercen);
  }
  int totalAssetValue = getController.encrypt8(buf);
  int totalDeposit = getController.encrypt8(buf);
  int totalWD = getController.encrypt8(buf);
  int totalUnrealizedGainLoss = getController.encrypt8(buf);
  int totalYield = getController.getDouble(buf);
  listPortopolioreturn!.clear();
  PortopolioReturn data = PortopolioReturn()
    ..loginId = loginID
    ..reference = Ref
    ..accountId = accountId
    ..requestType = rType
    ..startDate = startDate
    ..endDate = endDate
    ..arrayPortoReturn = listD
    ..totalAssetValue = totalAssetValue
    ..totalDeposit = totalDeposit
    ..totalWithdraw = totalWD
    ..totalUnrealizedGainLoss = totalUnrealizedGainLoss
    ..totalYieldPercentage = totalYield;

  listPortopolioreturn!.add(data);
  listPortopolioreturn!.refresh();
  return data;
}
