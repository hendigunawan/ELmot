import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';
import 'package:online_trading/view/tabbar_view/tradingView/controller/runningtrade.controller.dart';

updateRunningTrades() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  RunningTrades listD = RunningTrades();
  int SCL = getController.encrypt2(buf);
  String SC = getController.getAsciiString(buf, SCL);
  int LASTTT = getController.encrypt4(buf);
  int TRDID = getController.encrypt8(buf);
  int LASTP = getController.encrypt4(buf);
  int CHANGE = getController.getDouble(buf);
  int CHANGER = getController.getDouble(buf);
  int VLM = getController.encrypt4(buf);
  int tradeFLAGs = getController.encrypt1(buf);
  int sectorFLAGs = getController.encrypt1(buf);

  listD = RunningTrades(
    stockCodeL: SCL,
    stockCode: SC,
    lastTradedTime: LASTTT,
    tradeId: TRDID,
    lastPrice: LASTP,
    change: CHANGE,
    chgRate: CHANGER,
    volume: VLM,
    tradeFlag: tradeFLAGs,
    sectorFlag: sectorFLAGs,
  );

  final getRunning = Get.put(RunningTradeController());

  getRunning.addDatas(listD);
}
