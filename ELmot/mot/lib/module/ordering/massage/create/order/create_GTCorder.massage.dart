import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

Uint8List createGTCOrderMassage({
  required int price,
  required int volume,
  required int command,
  required int pin,
  required String stockCode,
  int? effDate = 0,
  int? dueDate = 0,
  int? priceStap = 0,
  int? autoOrder = 0,
  int? board = 0,
}) {
  Uint8List data = Uint8List(0);
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

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(pin.toString().length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(pin.toString()),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(accountId.value.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(accountId.value),
      ),
  );

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

  //SOURCE ID
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

  //BOARD
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        0,
      ),
  );

  //COMMAND
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        command,
      ),
  );

  //STOCK CODE
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(
          stockCode.length,
        ),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(
          stockCode,
        ),
      ),
  );

  //PRICE
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          price,
        ),
      ),
  );

  //VOLUME
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set64(
          volume,
        ),
      ),
  );

  //AUTO ORDER
  createBody = Uint8List.fromList(createBody.toList()..add(autoOrder ?? 0));

  //PRICE STEP
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(priceStap),
      ),
  );

  //EFFECTIVE DATE (YYYYMMDD)
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          effDate == 0
              ? int.parse(DateFormat('yyyyMMdd').format(DateTime.now()))
              : effDate,
        ),
      ),
  );

  //DUE DATE (YYYYMMDD)
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          dueDate == 0
              ? int.parse(DateFormat('yyyyMMdd').format(DateTime.now()))
              : dueDate,
        ),
      ),
  );

  createHeader = Uint8List.fromList(
    createHeader.toList()
      ..addAll(
        createPackageHeader(
          createBody.length + Constans.PACKAGE_HEADER_LENGTH,
          Constans.PACKAGE_ID_REQUEST_NEW_GTC_ORDER,
        ),
      ),
  );

  data = Uint8List.fromList(data.toList()..addAll(createHeader + createBody));

  return data;
}
