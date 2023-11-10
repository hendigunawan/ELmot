import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

import 'model/todaytrades_model.dart';

updateTodayTradesData() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  TodayTradesDataModel listD = TodayTradesDataModel();
  List<ArrayTodayTRadesData> addData = [];
  final object = ObjectBoxDatabase.todayTrade;

  int SCL = getController.encrypt2(buf);
  String SC = getController.getAsciiString(buf, SCL);
  int boardL = getController.encrypt2(buf);
  String board = getController.getAsciiString(buf, boardL);
  int command = getController.encrypt1(buf);
  int prevPrice = getController.encrypt4(buf);
  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int TRDID = getController.encrypt4(buf);
    int TIME = getController.encrypt4(buf);
    int LPRICE = getController.encrypt4(buf);
    int CHANGE = getController.encrypt4(buf);
    int CHANGER = getController.encrypt4(buf);
    int VLM = getController.encrypt8(buf);
    String BUYB = getController.getAsciiString(buf, 2);
    String BUYT = getController.getAsciiString(buf, 1);
    String SELB = getController.getAsciiString(buf, 2);
    String SELT = getController.getAsciiString(buf, 1);
    addData.add(
      ArrayTodayTRadesData()
        ..tradeId = TRDID
        ..time = TIME
        ..lastPrice = LPRICE
        ..change = CHANGE
        ..changeRate = CHANGER
        ..volume = VLM
        ..buyBroker = BUYB
        ..buyerType = BUYT
        ..sellBroker = SELB
        ..sellerType = SELT,
    );
  }
  listD = TodayTradesDataModel(
      stockC: SC.toString(),
      stockCL: SCL,
      boardL: boardL.toInt(),
      board: board.toString(),
      command: command,
      prevPrice: prevPrice,
      array: AR);

  final existingPerson = object
      .query(
        TodayTradesDataModel_.stockC.equals(listD.stockC.toString()) &
            TodayTradesDataModel_.board.equals(listD.board.toString()),
      )
      .build()
      .findFirst();

  if (existingPerson != null) {
    object.remove(existingPerson.id.toInt());
    object.put(listD);
    print("update");
  } else {
    object.put(listD);
    print("ADD");
  }
  print("Ini datanya ==========");
  print(listD.stockC);
  print(listD.stockCL);
  return TodayTradesDataModel();
}
