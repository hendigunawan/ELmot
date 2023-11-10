import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

Uint8List createRequestOrderMassage({
  required String stockCode,
  required int price,
  required int volume,
  required int command,
  required int pin,
  int? rendomSplit = 0,
  int? nSplit = 0,
  int? activPriceStep = 0,
  int? priceStep = 0,
  int? activAutoOrder = 0,
  int? autoOrderPriceStep = 0,
  int? prevSameOrder = 0,
  int? board = 0,
}) {
  var data = Uint8List(0);
  final openBox = ObjectBoxDatabase.infoMobile;
  var controll = Get.find<LoginOrderController>();

  var query = openBox.query(InfoMobile_.id.equals(1)).build().findFirst();
  Uint8List createBody = Uint8List(0);
  Uint8List createHeader = Uint8List(0);

  var ip = '';
  var loginId = '';
  var reference = '';
  var accountIds = '';

  if (query != null) {
    if (query.ipAddressMobile == null) ip = query.ipAddressWifi!;
    if (query.ipAddressMobile != null) ip = query.ipAddressMobile!;
    if (controll.order!.value.loginId != null) {
      loginId = controll.order!.value.loginId!;
    }
    if (controll.order!.value.account!.isNotEmpty) {
      accountIds = accountId.value == ''
          ? controll.order!.value.account!.first.accountId!
          : accountId.value;
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
        encodeLength(accountIds.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(accountIds),
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

  //RENDOMIZE SPLIT
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        rendomSplit ?? 0,
      ),
  );

  //N SPLIT
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          nSplit ?? 0,
        ),
      ),
  );

  //ACTIVATE PRICE STEP
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        activPriceStep ?? 0,
      ),
  );

  //PRICE STEP
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          priceStep ?? 0,
        ),
      ),
  );

  //ACTIVATE AUTOMATIC ORDER
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        activAutoOrder ?? 0,
      ),
  );

  //AUTOMATIC ORDER PRICE STEP
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          autoOrderPriceStep ?? 0,
        ),
      ),
  );

  //PREVATE SAME ORDER
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        prevSameOrder ?? 0,
      ),
  );

  Uint8List createHederHelper = createPackageHeader(
    Constans.PACKAGE_HEADER_LENGTH + createBody.length,
    Constans.PACKAGE_ID_REQUEST_ORDER,
  );
  createHeader = Uint8List.fromList(
    createHeader.toList()..addAll(createHederHelper),
  );

  data = Uint8List.fromList(
    data.toList()
      ..addAll(
        createHeader + createBody,
      ),
  );

  return data;
}
