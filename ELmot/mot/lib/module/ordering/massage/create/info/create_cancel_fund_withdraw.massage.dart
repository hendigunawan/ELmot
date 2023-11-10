import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:online_trading/core/responsive/breakpoints.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';

createCancelFundWithdrawMassage(
    {required dynamic pin,
    required dynamic accountId,
    required int funwithdrawId}) {
  final openBox = ObjectBoxDatabase.infoMobile;
  var query = openBox.query(InfoMobile_.id.equals(1)).build().findFirst();
  Uint8List create = Uint8List(0);
  Uint8List createBody = Uint8List(0);
  Uint8List createHeader = Uint8List(0);
  String ip = '';
  String clientTag =
      Get.find<LoginOrderController>().order!.value.reference.toString();
  String userName =
      Get.find<LoginOrderController>().order!.value.loginId.toString();

  if (query != null) {
    if (query.ipAddressMobile == null) {
      ip = query.ipAddressWifi!;
    }
    ip = query.ipAddressMobile!;
  }
  if (query != null) clientTag = '${query.clientTag}.ORDER';

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
        encodeLength(userName.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(userName),
      ),
  );
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
        encodeLength(clientTag.length),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        encodeString(clientTag),
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..add(
        clientTag.contains('ANDROID') && Responsive.isTablet(Get.context!)
            ? 7
            : clientTag.contains('ANDROID')
                ? 6
                : clientTag.contains('IOS') && Responsive.isTablet(Get.context!)
                    ? 9
                    : clientTag.contains('IOS')
                        ? 8
                        : 5,
      ),
  );
  createBody = Uint8List.fromList(
    createBody.toList()
      ..addAll(
        set64(funwithdrawId),
      ),
  );
  createHeader = Uint8List.fromList(
    createHeader.toList()
      ..addAll(
        createPackageHeader(
          Constans.PACKAGE_HEADER_LENGTH + createBody.length,
          Constans.PACKAGE_ID_CANCEL_FUND_WITHDRAWAL_ORDER,
        ),
      ),
  );

  create = Uint8List.fromList(create.toList()..addAll(createHeader));
  create = Uint8List.fromList(create.toList()..addAll(createBody));
  return create;
}
