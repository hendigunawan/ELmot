import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

import 'model/tradebook_model.dart';

TradBook() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  TradeBookModel listD = TradeBookModel();
  List<ArrayTradeBook> addData = [];
  final object = ObjectBoxDatabase.tradebookaja;

  int scl = getController.encrypt2(buf);
  String sc = getController.getAsciiString(buf, scl);
  int bl = getController.encrypt2(buf);
  String bls = getController.getAsciiString(buf, bl);
  int PREVPPP = getController.encrypt4(buf);
  int ar = getController.encrypt4(buf);
  for (int i = 0; i < ar; i++) {
    int PRICE = getController.encrypt4(buf);
    int FREG = getController.encrypt4(buf);
    int VLM = getController.encrypt8(buf);
    int VALUE = getController.encrypt8(buf);
    addData.add(
      ArrayTradeBook()
        ..price = PRICE
        ..freq = FREG
        ..volume = VLM
        ..value = VALUE,
    );
  }
  print("Ini data prevP : $PREVPPP");

  listD = TradeBookModel(
      stockCodeL: scl,
      stockCode: sc.toString(),
      boardL: bl.toInt(),
      board: bls.toString(),
      prevPrice: PREVPPP.toInt(),
      array: ar.toInt());
  listD.arrayList.addAll(addData);
  final existingPerson = object
      .query(TradeBookModel_.stockCode.equals(listD.stockCode.toString()) &
          TradeBookModel_.board.equals(listD.board.toString()))
      .build()
      .findFirst();
  if (existingPerson != null) {
    existingPerson.arrayList.clear();
    existingPerson.arrayList.addAll(addData);
    object.put(existingPerson);
    print(
        'Data person diperbarui: ${existingPerson.stockCode}, jumlah array: ${listD.array}');
  } else {
    print(
        'Data person dengan ${listD.stockCode} yang sama tidak ditemukan, jumlah array: ${listD.array}');
    object.put(listD);
  }

  return listD;
}
