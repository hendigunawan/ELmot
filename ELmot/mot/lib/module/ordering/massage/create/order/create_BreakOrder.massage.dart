import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

Uint8List createBreakOrderMassage(BreakOrderMassageModel massageModel) {
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
        encodeLength(massageModel.pin.toString().length),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(massageModel.pin.toString()),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(
          accountId.value == ''
              ? controll.order!.value.account!.first.accountId!.length
              : accountId.value.length,
        ),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(
          accountId.value == ''
              ? controll.order!.value.account!.first.accountId!
              : accountId.value,
        ),
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
        massageModel.command ?? 0,
      ),
  );

  //PRICE
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(
          massageModel.price ?? 0,
        ),
      ),
  );

  //VOLUME
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set64(
          massageModel.volume ?? 0,
        ),
      ),
  );

  //Conditional Price Type
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        massageModel.conPriceType ?? 0,
      ),
  );

  //Conditional Price Comparation
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        massageModel.conPriceCom ?? 0,
      ),
  );

  //Conditional Price
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(massageModel.conPrice ?? 0),
      ),
  );

  //Conditional Volume Type
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        massageModel.conVolType ?? 0,
      ),
  );

  //Conditional Volume Comparation
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        massageModel.conVolCom ?? 0,
      ),
  );

  //Conditional Volume
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set64(massageModel.conVol ?? 0),
      ),
  );

  //Automatic Order
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(massageModel.autoOrder ?? 0),
      ),
  );

  //EffectiveDate
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(massageModel.effDate ?? 0),
      ),
  );

  //DueDate
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set32(massageModel.dueDate ?? 0),
      ),
  );

  //STOCK CODE
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeLength(
          massageModel.stockCode.length,
        ),
      ),
  );

  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(
          massageModel.stockCode,
        ),
      ),
  );

  createHeader = Uint8List.fromList(
    createHeader.toList()
      ..addAll(
        createPackageHeader(
          createBody.length + Constans.PACKAGE_HEADER_LENGTH,
          Constans.PACKAGE_ID_REQUEST_NEW_BREAK_OERDER,
        ),
      ),
  );

  data = Uint8List.fromList(data.toList()..addAll(createHeader + createBody));

  return data;
}

class BreakOrderMassageModel {
  String? pin;
  int? command;
  int? price;
  int? volume;
  int? conPriceType;
  int? conPriceCom;
  int? conPrice;
  int? conVolType;
  int? conVolCom;
  int? conVol;
  int? autoOrder;
  int? effDate;
  int? dueDate;
  String stockCode;

  BreakOrderMassageModel({
    this.pin,
    this.command,
    this.price,
    this.volume,
    this.conPriceType,
    this.conPriceCom,
    this.conPrice,
    this.conVolType,
    this.conVolCom,
    this.conVol,
    this.autoOrder,
    this.effDate,
    this.dueDate,
    required this.stockCode,
  });
}
