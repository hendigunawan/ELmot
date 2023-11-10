import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';

import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/indexlist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';

Index() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  IndexListTop45 listD = IndexListTop45();
  List<ArrayIndexListTop45> addData = [];
  final object = ObjectBoxDatabase.Indexlisttop45Aja;

  int arrayL = getController.encrypt4(buf);
  for (int i = 0; i < arrayL; i++) {
    int icl = getController.encrypt2(buf);
    String ic = getController.getAsciiString(buf, icl);
    int inl = getController.encrypt2(buf);
    String iN = getController.getAsciiString(buf, inl);
    addData.add(
      ArrayIndexListTop45(
        IndexCode: ic,
        IndexCodeL: icl,
        HashKeyL: inl,
        HashKey: iN,
      ),
    );
  }
  listD = IndexListTop45(arrayL: arrayL);
  listD.array.addAll(addData);
  object.removeAll();
  object.put(listD);
  print("Data person diperbaharui");
}
