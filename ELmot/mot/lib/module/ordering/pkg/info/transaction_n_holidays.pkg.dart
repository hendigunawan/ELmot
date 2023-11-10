import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/ordering/model/info/transaction_n_holidays.model.dart';

RxList<TransactionNHolidaysModel> listRemainTransactionnHolidays =
    <TransactionNHolidaysModel>[].obs;
RxList<TransactionNHolidaysDATAModel> listHoliday =
    <TransactionNHolidaysDATAModel>[].obs;
transactionnholidaysPKG(Uint8List buf) {
  var getController = Get.find<EncryptControll>();
  List<ArrayRemain> listD = [];
  List<ArrayHolidayByDate> listData = [];
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  int Lref = getController.encrypt2(buf);
  // ignore: unused_local_variable
  String reference = getController.getAsciiString(buf, Lref);
  int reqType = getController.encrypt1(buf);

  if (reqType == 0) {
    listRemainTransactionnHolidays.clear();
    int array = getController.encrypt4(buf);
    for (int i = 0; i < array; i++) {
      int tradingDate = getController.encrypt4(buf);
      listD.add(ArrayRemain()..tradingDate = tradingDate);
    }
    TransactionNHolidaysModel data = TransactionNHolidaysModel()
      ..reqType = reqType
      ..array = listD;
    listRemainTransactionnHolidays.add(data);
    return data;
  } else {
    listHoliday.clear();
    int array = getController.encrypt4(buf);
    for (int i = 0; i < array; i++) {
      int holiday = getController.encrypt4(buf);
      int descriptionLength = getController.encrypt2(buf);
      String description = getController.getAsciiString(buf, descriptionLength);
      listData.add(ArrayHolidayByDate()
        ..holiday = holiday
        ..description = description);
    }
    TransactionNHolidaysDATAModel data = TransactionNHolidaysDATAModel()
      ..reqType = reqType
      ..array = listData;
    listHoliday.add(data);
    return data;
  }
}
