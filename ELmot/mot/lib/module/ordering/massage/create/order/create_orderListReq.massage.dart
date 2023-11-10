import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';

Uint8List createOrderListReqMassage(String pin, String accountId) {
  var data = Uint8List(0);
  final openBox = ObjectBoxDatabase.infoMobile;
  var controll = Get.find<LoginOrderController>();

  var query = openBox.query(InfoMobile_.id.equals(1)).build().findFirst();
  Uint8List createBody = Uint8List(0);
  Uint8List createHeader = Uint8List(0);

  var ip = '';
  var loginId = '';
  var reference = '';

  if (query != null) {
    if (query.ipAddressMobile == null) ip = query.ipAddressWifi!;
    if (query.ipAddressMobile != null) ip = query.ipAddressMobile!;
    if (controll.order!.value.loginId != null) {
      loginId = controll.order!.value.loginId!;
    }
    if (query.clientTag != null) reference = '${query.clientTag!}.ORDER';
  }

  //IP
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(ip.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(ip),
      ),
  );

  //LOGIN ID
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(loginId.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(loginId),
      ),
  );

  //PIN
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(pin.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(pin),
      ),
  );

  //ACCOUNT ID
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(accountId.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(accountId),
      ),
  );

  //REFERENCE
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(reference.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(reference),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        reference.contains('ANDROID') && Responsive.isTablet(Get.context!)
            ? 7
            : reference.contains('ANDROID')
                ? 6
                : reference.contains('IOS') && Responsive.isTablet(Get.context!)
                    ? 9
                    : reference.contains('IOS')
                        ? 8
                        : 5,
      ),
  );

  Uint8List createHeaderData = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    Constans.PACKAGE_ID_ORDER_LIST_REQUEST,
  );

  createHeader = Uint8List.fromList(
    createHeader.toList()
      ..addAll(
        createHeaderData,
      ),
  );

  data = Uint8List.fromList(
    data.toList()
      ..addAll(
        createHeader + createBody,
      ),
  );

  return data;
}
