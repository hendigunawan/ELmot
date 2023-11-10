import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'model/stockgrouplist_model.dart';

updateStockGroupList() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  StockGroupListModel listD = StockGroupListModel();
  List<ArrayStockGroupList> addData = [];
  final object = ObjectBoxDatabase.stockgroupListAja;

  int cidL = getController.encrypt2(buf);
  String cid = getController.getAsciiString(buf, cidL);
  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int GNLen = getController.encrypt2(buf);
    String GN = getController.getAsciiString(buf, GNLen);
    int ISDef = getController.encrypt1(buf);
    addData.add(
      ArrayStockGroupList()
        ..groupNameL = GNLen
        ..groupName = GN
        ..isDefault = ISDef,
    );
  }

  listD = StockGroupListModel(
    clientIdL: cidL.toInt(),
    clientId: cid,
    array: AR,
  );

  final existingPerson = object
      .query(StockGroupListModel_.clientId.equals(listD.clientId.toString()))
      .build()
      .findFirst();
  if (existingPerson != null) {
    existingPerson.arrayList.clear();
    existingPerson.arrayList.addAll(addData);
    object.put(existingPerson);
    print('Data person diperbarui: ${existingPerson.clientId}');
  } else {
    print('Data person dengan ${listD.clientId}   yang sama tidak ditemukan');
    object.put(listD);
  }

  print(listD.clientId);
  // // print(listD.arrayList.first.groupName);
  // FavoritController controller = Get.put(FavoritController());
  // controller.dataStockGroupList1.assign(listD);
  return (listD);
}
