import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/intradaychartdata_model.dart';

updateIntradayChartData() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  IntradayChartDataModel listD = IntradayChartDataModel();
  List<ArrayIntradayChartData> addData = [];
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

    addData.add(ArrayIntradayChartData()
      ..date = DATE
      ..openPrice = OPENP
      ..highPrice = HIGHP
      ..lowPrice = LOWP
      ..closePrice = CLOSEP
      ..freq = FREG
      ..volume = VOLUME
      ..value = VALUE);
  }
  listD = IntradayChartDataModel(
      stockCodeL: scl,
      stockCode: sc,
      boardL: bl.toInt(),
      board: bls.toString(),
      command: command,
      array: AR);

  return listD;
}
