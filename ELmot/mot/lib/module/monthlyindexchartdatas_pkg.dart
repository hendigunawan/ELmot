import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/monthlyindexchartdatas_model.dart';

updateMonthlyIndexChartDatas() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  MonthlyIndexChartDatasModel listD = MonthlyIndexChartDatasModel();
  List<ArrayMonthlyIndexChartDatasModel> addDataB = [];

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
      ArrayMonthlyIndexChartDatasModel()
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
  listD = MonthlyIndexChartDatasModel(
    indexCodeL: idxL,
    indexCode: ic,
    command: command,
    array: Ar,
  );

  return listD;
}
