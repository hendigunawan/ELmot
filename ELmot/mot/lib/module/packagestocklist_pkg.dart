import 'package:get/get.dart';
import 'package:online_trading/core/getasync.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/model/packagestocklist_model.dart';

StockList() async {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  final object = ObjectBoxDatabase.stockList;
  List<PackageStockList> lisD = [];
  int Array = getController.encrypt4(buf);
  print("ARRAY L: $Array");
  for (int x = 0; x < Array; x++) {
    int SCL = getController.encrypt2(buf);
    String SC = getController.getAsciiString(buf, SCL);
    int SNL = getController.encrypt2(buf);
    String SN = getController.getAsciiString(buf, SNL);
    int instrumenL = getController.encrypt2(buf);
    String instrumen = getController.getAsciiString(buf, instrumenL);
    int remake2L = getController.encrypt2(buf);
    String remake2 = getController.getAsciiString(buf, remake2L);
    int sector = getController.encrypt4(buf);

    lisD.add(
      PackageStockList()
        ..stockCodeL = SCL
        ..stcokCode = SC
        ..stockNameL = SNL
        ..stockName = SN
        ..instrumenL = instrumenL
        ..instrumen = instrumen
        ..remake2L = remake2L
        ..remake2 = remake2
        ..sector = sector,
    );
  }
  if (Array.toInt() == 0) {
    print('NULL');
    null;
  } else {
    object.removeAll();
    object.putMany(lisD);
    final getDataController = Get.put(GetDataController());
    getDataController.onDoneMember.toggle();
    print('UPDATE');
  }
}
