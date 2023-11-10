import 'package:get/get.dart';
import 'package:online_trading/core/getasync.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/objectbox/model/objectbox_model.dart';
import 'package:online_trading/objectbox.g.dart';

import '../core/rabbitmq/data_proses.dart';

HashKeyPKG() {
  HashKey listM;
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;

  int arrayL = getController.encrypt4(buf);
  for (int i = 0; i < arrayL; i++) {
    int hashReqCode = getController.encrypt1(buf);
    int hashkeyL = getController.encrypt2(buf);
    String hashKey = getController.getAsciiString(buf, hashkeyL);
    listM = HashKey(
      codeName: hashReqCode,
      hashKeyL: hashkeyL,
      hashKeyNEW: hashKey,
    );
    final openBox = ObjectBoxDatabase.hasKeyBox;
    final openQuery = openBox
        .query(HashKey_.codeName.equals(listM.codeName!.toInt()))
        .build()
        .findFirst();
    if (openQuery != null) {
      if (openQuery.hashKeyNEW == listM.hashKeyNEW &&
          ObjectBoxDatabase.stockList.getAll().isEmpty) {
        openQuery.hashKeyNEW = hashKey;
        openBox.put(openQuery);
        GetDataFirst(code: listM.codeName!);
        print('Jalan Get Data StockList');
      }
      if (openQuery.hashKeyNEW != listM.hashKeyNEW) {
        openQuery.hashKeyNEW = hashKey;
        openBox.put(openQuery);
        GetDataFirst(code: listM.codeName!);
        print('Jalan Get Data StockList');
      } else {
        openQuery.hashKeyNEW = hashKey;
        print('Update');
        openBox.put(openQuery);
      }
    } else {
      openBox.put(listM);
      GetDataFirst(code: listM.codeName!);
      print('Add HashKey');
    }
  }
}
