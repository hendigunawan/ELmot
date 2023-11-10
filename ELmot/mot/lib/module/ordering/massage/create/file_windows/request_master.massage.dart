import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';

createreqMasterMassage() {
  final openBox = ObjectBoxDatabase.infoMobile;

  var query = openBox.query(InfoMobile_.id.equals(1)).build().findFirst();
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  Uint8List createHeader = Uint8List(0);
  String clientTag =
      Get.find<LoginOrderController>().order!.value.reference.toString();

  if (query != null) clientTag = '${query.clientTag}.ORDER';

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );

  createBody = Uint8List.fromList(createBody.toList()..add(0));
  createHeader = Uint8List.fromList(
    createHeader.toList()
      ..addAll(
        createPackageHeader(
          createBody.length + Constans.PACKAGE_HEADER_LENGTH,
          0x0031,
        ),
      ),
  );

  create = Uint8List.fromList(
    create.toList()
      ..addAll(
        createHeader + createBody,
      ),
  );

  return create;
}
