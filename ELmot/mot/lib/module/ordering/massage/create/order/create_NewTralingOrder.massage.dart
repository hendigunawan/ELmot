import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';

class TralingModelReq {
  String pin;
  int command;
  int volume;
  int trailingStep;
  int priceType;
  String stockCode;
  String accountId;
  int effDate;
  int dueDate;
  int autoOrder;
  int dropPrice;
  int board;
  int buyorsellAT;

  TralingModelReq({
    required this.pin,
    required this.command,
    required this.volume,
    required this.trailingStep,
    required this.priceType,
    required this.stockCode,
    required this.accountId,
    this.effDate = 0,
    this.dueDate = 0,
    this.autoOrder = 0,
    this.dropPrice = 0,
    this.board = 0,
    this.buyorsellAT = 0,
  });
}

Uint8List createTralingOrder({
  required String pin,
  required int command,
  required int volume,
  required int trailingStep,
  required int priceType,
  required String stockCode,
  required String accountId,
  int? effDate = 0,
  int? dueDate = 0,
  int? autoOrder = 0,
  int? dropPrice = 0,
  int? board = 0,
  int buyorsellAT = 0,
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
        encodeLength(accountId.length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(accountId),
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

//BUY OR SELL AT
  createBody = Uint8List.fromList(
    createBody.toList()..add(buyorsellAT),
  );

  //VOLUME
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set64(
          volume * Get.find<LoginOrderController>().order!.value.lot!,
        ),
      ),
  );

  //DROP PRICE (BUY ONLY)
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          dropPrice,
        ),
      ),
  );

  //TRALING STAP
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          int.parse('${trailingStep}00'),
        ),
      ),
  );

  //PRICE TYPE
  createBody = Uint8List.fromList(
    createBody.toList()..add(priceType),
  );

  //AUTOMATIC ORDER
  createBody = Uint8List.fromList(
    createBody.toList()..addAll(set32(autoOrder ?? 0)),
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

  createHeader = Uint8List.fromList(
    createHeader.toList()
      ..addAll(
        createPackageHeader(
          createBody.length + Constans.PACKAGE_HEADER_LENGTH,
          Constans.PACKAGE_ID_REQUEST_NEW_TRAILING_ORDER,
        ),
      ),
  );

  data = Uint8List.fromList(data.toList()..addAll(createHeader + createBody));

  return data;
}
