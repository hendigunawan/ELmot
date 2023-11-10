import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/stock_balance.model.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';

StockBalance stockBalancePkg(Uint8List data) {
  ValueNotifier<int> readPos = ValueNotifier(Constans.PACKAGE_HEADER_LENGTH);
  List<StockBalanceARRAY> listD = [];
  var e = Encrypt();
  ValueNotifier<int> lLogin = ValueNotifier(e.encrypt2(data, readPos.value));
  readPos.value = readPos.value + 2;
  ValueNotifier<String> loginID =
      ValueNotifier(e.getAsciiString(data, readPos.value, lLogin.value));
  readPos.value = readPos.value + lLogin.value;
  ValueNotifier<int> Lref = ValueNotifier(e.encrypt2(data, readPos.value));
  readPos.value = readPos.value + 2;
  ValueNotifier<String> Ref =
      ValueNotifier(e.getAsciiString(data, readPos.value, Lref.value));
  readPos.value = readPos.value + Lref.value;
  ValueNotifier<int> LAccount = ValueNotifier(e.encrypt2(data, readPos.value));
  readPos.value = readPos.value + 2;
  ValueNotifier<String> AccountId =
      ValueNotifier(e.getAsciiString(data, readPos.value, LAccount.value));
  readPos.value = readPos.value + LAccount.value;
  ValueNotifier<int> AR = ValueNotifier(e.encrypt4(data, readPos.value));
  readPos.value = readPos.value + 4;

  for (int i = 0; i < AR.value; i++) {
    ValueNotifier<int> LStock = ValueNotifier(e.encrypt2(data, readPos.value));
    readPos.value = readPos.value + 2;
    ValueNotifier<String> StockCode =
        ValueNotifier(e.getAsciiString(data, readPos.value, LStock.value));
    readPos.value = readPos.value + LStock.value;
    ValueNotifier<int> AVGP = ValueNotifier(e.encrypt4(data, readPos.value));
    readPos.value = readPos.value + 4;
    ValueNotifier<int> LASTP = ValueNotifier(e.encrypt4(data, readPos.value));
    readPos.value = readPos.value + 4;
    ValueNotifier<int> VOL =
        ValueNotifier(e.getLong(data.buffer, readPos.value));
    readPos.value = readPos.value + 8;
    ValueNotifier<int> BALANCE =
        ValueNotifier(e.getLong(data.buffer, readPos.value));
    readPos.value = readPos.value + 8;
    ValueNotifier<int> POTENSIALGL =
        ValueNotifier(e.getLong(data.buffer, readPos.value));
    readPos.value = readPos.value + 8;
    ValueNotifier<int> POTPERCEN = ValueNotifier(
        ByteData.sublistView(data).getInt32(readPos.value, Endian.big));
    readPos.value = readPos.value + 4;

    listD.add(StockBalanceARRAY()
      ..stockCodeLen = LStock.value
      ..stockCode = StockCode.value
      ..avgPrice = AVGP.value
      ..lastPrice = LASTP.value
      ..volume = VOL.value
      ..balance = BALANCE.value
      ..potentialGainLoss = POTENSIALGL.value
      ..potentialGainLossPercentage = POTPERCEN.value);
  }
  StockBalance stockBalance = StockBalance()
    ..loginId = loginID.value
    ..reference = Ref.value
    ..accountId = AccountId.value
    ..stocks = listD;
  Get.put(BodyController()).stockBalance.value = [stockBalance];
  Get.find<BodyController>().stockBalance.refresh();
  return stockBalance;
}
