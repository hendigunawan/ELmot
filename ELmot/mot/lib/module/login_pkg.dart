import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/loginrply_package.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';

getLoginResponse() async {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  ByteData bb = buf.buffer.asByteData();
  loginObject login = loginObject();
  login.errorCode = bb.getUint16(12); // Error Code	Unsigned Short	2
  int pos = Constans.PACKAGE_HEADER_LENGTH;
  login.loginIdL = bb.getUint16(pos); // Login Id Len	Unsigned Short	2
  pos += 2;
  login.loginId = getController.getAsciiString(
      buf, login.loginIdL!); // Login Id	char	30	Max 30 chars
  pos += login.loginIdL!.toInt();
  login.lotSize =
      bb.getUint32(pos); // LOT SIZE	Unsigned int 	4	Current 1 LOT = 100 Shares
  print(
      "LoginID: ${login.loginId}, ErrorCode: ${login.errorCode}, LoT: ${login.lotSize}");

  final object = ObjectBoxDatabase.loginBox;
  object.removeAll();

  object.put(login);

  return login;
}
