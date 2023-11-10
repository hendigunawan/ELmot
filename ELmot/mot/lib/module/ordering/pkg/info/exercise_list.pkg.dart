import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/exercise_list.model.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/right_warrant/exercise_list.dart';

RxList<ExerciseListModel> listExerciseList = <ExerciseListModel>[].obs;
exerciseWarrantListPKG(Uint8List buf) {
  listExerciseList.clear();
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  List<ArrayExerciseList> listD = [];
  int lLogin = getController.encrypt2(buf);
  String loginID = getController.getAsciiString(buf, lLogin);
  int lRef = getController.encrypt2(buf);
  String Ref = getController.getAsciiString(buf, lRef);
  int lAccountId = getController.encrypt2(buf);
  String accountId = getController.getAsciiString(buf, lAccountId);
  int arraycount = getController.encrypt4(buf);
  for (int i = 0; i < arraycount; i++) {
    int exerciseId = getController.encrypt8(buf);
    int subscribeDate = getController.encrypt4(buf);
    int subscribeTime = getController.encrypt4(buf);
    int exerciseDate = getController.encrypt4(buf);
    int executedDate = getController.encrypt4(buf);
    int stockCL = getController.encrypt2(buf);
    String stockcode = getController.getAsciiString(buf, stockCL);
    int exercisePrice = getController.encrypt4(buf);
    int exerciseQty = getController.encrypt8(buf);
    int exerciseAmount = getController.encrypt8(buf);
    int exerciseFee = getController.encrypt4(buf);
    int sourceId = getController.encrypt1(buf);
    int status = getController.encrypt1(buf);
    int inputByL = getController.encrypt2(buf);
    String inputBy = getController.getAsciiString(buf, inputByL);
    int messageL = getController.encrypt2(buf);
    String message = getController.getAsciiString(buf, messageL);
    listD.add(ArrayExerciseList()
      ..exerciseId = exerciseId
      ..subscribeDate = subscribeDate
      ..subscribeTime = subscribeTime
      ..exerciseDate = exerciseDate
      ..executedDate = executedDate
      ..stockcode = stockcode
      ..exercisePrice = exercisePrice
      ..exerciseQty = exerciseQty
      ..exerciseAmount = exerciseAmount
      ..exerciseFee = exerciseFee
      ..sourceId = sourceId
      ..status = status
      ..inputBy = inputBy
      ..message = message);
  }
  var a = listD.reversed.toList();
  ExerciseListModel data = ExerciseListModel()
    ..loginID = loginID
    ..reference = Ref
    ..accountId = accountId
    ..array = a;

  listExerciseList.add(data);
  return data;
}
