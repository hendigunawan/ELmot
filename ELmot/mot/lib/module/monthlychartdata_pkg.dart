import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/monthlychartdata_model.dart';

updateMonthlyChartData() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  MonthlyChartDataModel listD = MonthlyChartDataModel();
  List<ArrayMonthlyChartData> addData = [];
  //  final object = ObjectBoxDatabase.orderBookBox;

  int scl = getController.encrypt2(buf);
  String sc = getController.getAsciiString(buf, scl);
  int bl = getController.encrypt2(buf);
  String bls = getController.getAsciiString(buf, bl);
  int command = getController.encrypt1(buf);
  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int DATE = getController.encrypt4(buf);
    int OPENP = getController.encrypt4(buf);
    int HIGHP = getController.encrypt4(buf);
    int LOWP = getController.encrypt4(buf);
    int CLOSEP = getController.encrypt4(buf);
    int FREG = getController.encrypt4(buf);
    int VOLUME = getController.encrypt8(buf);
    int VALUE = getController.encrypt8(buf);
    addData.add(
      ArrayMonthlyChartData()
        ..date = DATE
        ..openPrice = OPENP
        ..highPrice = HIGHP
        ..lowPrice = LOWP
        ..closePrice = CLOSEP
        ..freq = FREG
        ..volume = VOLUME
        ..value = VALUE,
    );
  }
  listD = MonthlyChartDataModel(
    stockCodeL: scl,
    stockCode: sc,
    boardL: bl.toInt(),
    board: bls.toString(),
    command: command,
    array: AR,
  );

  return listD;
}
