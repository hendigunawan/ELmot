import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';

AppFileHash pkgAppfileHAsh(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  List<ArrayAppFileHash> listD = [];
  int requestFlags = getController.encrypt1(buf);
  int array = getController.encrypt2(buf);
  for (int i = 0; i < array; i++) {
    int fileNameL = getController.encrypt2(buf);
    String fileName = getController.getAsciiString(buf, fileNameL);
    int filehashCodeL = getController.encrypt2(buf);
    String filehashCode = getController.getAsciiString(buf, filehashCodeL);
    listD.add(ArrayAppFileHash()
      ..fileName = fileName
      ..hashCodeD = filehashCode);
  }

  AppFileHash data = AppFileHash()
    ..array = listD
    ..requestFlag = requestFlags;
  return data;
}

class AppFileHash {
  int? requestFlag;
  List<ArrayAppFileHash>? array;
}

class ArrayAppFileHash {
  String? fileName;
  String? hashCodeD;

  ArrayAppFileHash({this.fileName, this.hashCodeD});
}
