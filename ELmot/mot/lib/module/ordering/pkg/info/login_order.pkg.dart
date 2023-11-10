import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/info/login_order.model.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

LoginOrder loginOrderPkg(Uint8List data) {
  List<LoginAccont> array = [];
  ValueNotifier<int> readPos = ValueNotifier(Constans.PACKAGE_HEADER_LENGTH);
  var e = Encrypt();
  ValueNotifier<int> lLogin = ValueNotifier(e.encrypt2(data, readPos.value));
  readPos.value = readPos.value + 2;
  ValueNotifier<String> loginId =
      ValueNotifier(e.getAsciiString(data, readPos.value, lLogin.value));
  readPos.value = readPos.value + lLogin.value;
  ValueNotifier<int> Lref = ValueNotifier(e.encrypt2(data, readPos.value));
  readPos.value = readPos.value + 2;
  ValueNotifier<String> Ref =
      ValueNotifier(e.getAsciiString(data, readPos.value, Lref.value));
  readPos.value = readPos.value + Lref.value;
  ValueNotifier<int> lot = ValueNotifier(e.encrypt4(data, readPos.value));
  readPos.value = readPos.value + 4;
  ValueNotifier<int> LoginType = ValueNotifier(e.get(data, readPos.value));
  readPos.value = readPos.value + 1;

  ValueNotifier<int> Permissions =
      ValueNotifier(e.encrypt4(data, readPos.value));
  readPos.value = readPos.value + 4;
  ValueNotifier<int> AR = ValueNotifier(e.encrypt4(data, readPos.value));
  readPos.value = readPos.value + 4;
  for (int i = 0; i < AR.value; i++) {
    ValueNotifier<int> LAccount =
        ValueNotifier(e.encrypt2(data, readPos.value));
    readPos.value = readPos.value + 2;
    ValueNotifier<String> AccountId =
        ValueNotifier(e.getAsciiString(data, readPos.value, LAccount.value));
    readPos.value = readPos.value + LAccount.value;
    ValueNotifier<int> LAccountName =
        ValueNotifier(e.encrypt2(data, readPos.value));
    readPos.value = readPos.value + 2;
    ValueNotifier<String> AccountName = ValueNotifier(
        e.getAsciiString(data, readPos.value, LAccountName.value));
    readPos.value = readPos.value + LAccountName.value;

    ValueNotifier<int> OnlineFBUY = ValueNotifier(
        ByteData.sublistView(data).getInt16(readPos.value, Endian.big));
    readPos.value = readPos.value + 2;
    ValueNotifier<int> OnlineFSELL = ValueNotifier(
        ByteData.sublistView(data).getInt16(readPos.value, Endian.big));
    readPos.value = readPos.value + 2;

    array.add(
      LoginAccont()
        ..accountIdLen = LAccount.value
        ..accountId = AccountId.value
        ..accountNameLen = LAccountName.value
        ..accountName = AccountName.value
        ..onlineFeeBuy = OnlineFBUY.value / 10000
        ..onlineFeeSell = OnlineFSELL.value / 10000,
    );
  }

  LoginOrder order = LoginOrder()
    ..loginIdLen = lLogin.value
    ..loginId = loginId.value
    ..referenceLen = Lref.value
    ..reference = Ref.value
    ..lot = lot.value
    ..loginType = LoginType.value
    ..permissions = Permissions.value
    ..array = AR.value
    ..account = array;

  Get.put(LoginOrderController(), permanent: true).order!.value = order;
  accountId.value = order.account!.first.accountId!;
  listlogin.clear();
  listlogin.add(order);
  return order;
}

RxList<LoginOrder> listlogin = <LoginOrder>[].obs;
