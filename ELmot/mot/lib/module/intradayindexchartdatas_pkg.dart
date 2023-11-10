import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/intradayindexchartdatas_model.dart';

updateIntradayIndexChartDatas() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  IntradayIndexChartDatasModel listD = IntradayIndexChartDatasModel();
  List<ArrayIntradayIndexChartDatasModel> addDataB = [];

  int idxL = getController.encrypt2(buf);
  String ic = getController.getAsciiString(buf, idxL);
  int command = getController.encrypt1(buf);
  int Ar = getController.encrypt4(buf);
  for (int x = 0; x < Ar; x++) {
    int DATE = getController.encrypt4(buf);
    int OPENP = getController.encrypt4(buf);
    int HIGHP = getController.encrypt4(buf);
    int LOWP = getController.encrypt4(buf);
    int CLOSEP = getController.encrypt4(buf);
    int FREG = getController.encrypt4(buf);
    int VOLUME = getController.encrypt8(buf);
    int VALUE = getController.encrypt8(buf);

    addDataB.add(
      ArrayIntradayIndexChartDatasModel()
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
  listD = IntradayIndexChartDatasModel(
    indexCodeL: idxL,
    indexCode: ic,
    command: command,
    array: Ar,
  );

  return listD;
}
