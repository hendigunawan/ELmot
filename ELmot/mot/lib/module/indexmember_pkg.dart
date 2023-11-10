import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/indexmember_model.dart';
import 'package:online_trading/objectbox.g.dart';

import 'objectbox/crud/crud_.dart';

indexMember() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  final object = ObjectBoxDatabase.indexMembers;
  IndexMember listM;
  List<ListMember> member = [];

  int indexCodeL = getController.encrypt2(buf);
  String indexCode = getController.getAsciiString(buf, indexCodeL);
  int arrayL = getController.encrypt4(buf);
  for (int i = 0; i < arrayL; i++) {
    int stockCodeL = getController.encrypt2(buf);
    String stockCode = getController.getAsciiString(buf, stockCodeL);

    member.add(
      ListMember()
        ..stockCode = stockCode
        ..stockCodeL = stockCodeL,
    );
  }
  listM = IndexMember()
    ..indexCodeL = indexCodeL
    ..indexCode = indexCode
    ..arrayL = arrayL;

  final existingPerson = object
      .query(IndexMember_.indexCode.equals(listM.indexCode.toString()))
      .build()
      .findFirst();

  listM.array.addAll(member);

  if (existingPerson != null) {
    object.remove(existingPerson.id);
    object.put(listM);
    print("update");
  } else {
    object.put(listM);
    print("add");
  }

  // print(listM);
}
