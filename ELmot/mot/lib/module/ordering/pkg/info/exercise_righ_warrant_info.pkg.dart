import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/exercise_warrant_info.model.dart';

RxList<ExerciseWarrantInfo> listExerciseWarrantInfo =
    <ExerciseWarrantInfo>[].obs;
exerciseWarrantInfoPKG(Uint8List buf) {
  listExerciseWarrantInfo.clear();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  List<ArrayInfoWarrant> listD = [];
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int lRef = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, lRef);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int t0Date = getController.encrypt4(buf);
  int t0Cash = getController.encrypt8(buf);
  int t1Date = getController.encrypt4(buf);
  int t1Cash = getController.encrypt8(buf);
  int t2Date = getController.encrypt4(buf);
  int t2Cash = getController.encrypt8(buf);
  int t3Date = getController.encrypt4(buf);
  int t3Cash = getController.encrypt8(buf);
  int arraycount = getController.encrypt4(buf);
  for (int i = 0; i < arraycount; i++) {
    int stockCL = getController.encrypt2(buf);
    String stockcode = getController.getAsciiString(buf, stockCL);
    int exercisePrice = getController.encrypt4(buf);
    int volumeBalance = getController.encrypt8(buf);
    int oldShares = getController.encrypt4(buf);
    int newShares = getController.encrypt4(buf);
    int exerciseDateBegin = getController.encrypt4(buf);
    int exerciseDateEnd = getController.encrypt4(buf);
    listD.add(ArrayInfoWarrant()
      ..stockCode = stockcode
      ..exercisePrice = exercisePrice
      ..volumeBalance = volumeBalance
      ..oldShares = oldShares
      ..newShares = newShares
      ..exerciseDateBegin = exerciseDateBegin
      ..exerciseDateEnd = exerciseDateEnd);
  }
  ExerciseWarrantInfo data = ExerciseWarrantInfo()
    ..loginId = loginID
    ..reference = Ref
    ..accountId = accountId
    ..t0Date = t0Date
    ..t0Cash = t0Cash
    ..t1Date = t1Date
    ..t1Cash = t1Cash
    ..t2Date = t2Date
    ..t2Cash = t2Cash
    ..t3Date = t3Date
    ..t3Cash = t3Cash
    ..array = listD;
  listExerciseWarrantInfo.add(data);
  return data;
}
