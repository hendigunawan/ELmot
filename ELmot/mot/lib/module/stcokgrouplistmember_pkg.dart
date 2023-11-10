import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/stockgrouplistmember_model.dart';

updateStockGroupListMember() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  StockGroupListMemberModel listD = StockGroupListMemberModel();
  List<ArrayOFGroupname> addData = [];
  List<ArrayOFStockCode> addData2 = [];
  // final object = ObjectBoxDatabase.stockgrouplist;
  int lidL = getController.encrypt2(buf);
  String lid = getController.getAsciiString(buf, lidL);
  int AR1 = getController.encrypt4(buf);
  for (int i = 0; i < AR1; i++) {
    int GNLen = getController.encrypt2(buf);
    String GN = getController.getAsciiString(buf, GNLen);
    int AR2 = getController.encrypt4(buf);
    for (int i = 0; i < AR2; i++) {
      int Scl = getController.encrypt2(buf);
      String Sc = getController.getAsciiString(buf, Scl);
      addData2.add(
        ArrayOFStockCode()
          ..stockCL = Scl
          ..stockC = Sc,
      );
    }
    addData.add(
      ArrayOFGroupname()
        ..groupNameL = GNLen
        ..groupName = GN
        ..arraystockCD = AR2,
    );
  }

  listD = StockGroupListMemberModel(
    clientIdL: lidL,
    clientId: lid,
    array1: AR1,
  );

  print(listD);
  return (listD);
}
