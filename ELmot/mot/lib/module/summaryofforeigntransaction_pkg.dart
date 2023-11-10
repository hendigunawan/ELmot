import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/subscribesummaryofforeignT_model.dart';

updateSummaryofForeignTransaction() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  SubscribeSummaryForeignTModel listD = SubscribeSummaryForeignTModel();
  List<ArraySubscribeSummaryForeignT> addData = [];

  int scl = getController.encrypt2(buf);
  String sc = getController.getAsciiString(buf, scl);
  int bl = getController.encrypt2(buf);
  String bls = getController.getAsciiString(buf, bl);
  int TGL = getController.encrypt4(buf);
  int PREVP = getController.encrypt4(buf);
  int LASTP = getController.encrypt4(buf);
  int fgAVGPriceBUY = getController.encrypt4(buf);
  int fgAVGPriceSELL = getController.encrypt4(buf);
  int fgBUYVOLUME = getController.encrypt8(buf);
  int fgSELLVOLUME = getController.encrypt8(buf);
  int fgNETTVOLUME = getController.encrypt8(buf);
  int fgBUYVALUE = getController.encrypt8(buf);
  int fgSELLVALUE = getController.encrypt8(buf);
  int fgNETTVALUE = getController.encrypt8(buf);
  int AR = getController.encrypt4(buf);
  for (int i = 0; i < AR; i++) {
    int ATGL = getController.encrypt4(buf);
    int APREVP = getController.encrypt4(buf);
    int ACLOSEDP = getController.encrypt4(buf);
    int AfgAVGPriceBUY = getController.encrypt4(buf);
    int AfgAVGPriceSELL = getController.encrypt4(buf);
    int AfgBUYVOLUME = getController.encrypt8(buf);
    int AfgSELLVOLUME = getController.encrypt8(buf);
    int AfgNETTVOLUME = getController.encrypt8(buf);
    int AfgBUYVALUE = getController.encrypt8(buf);
    int AfgSELLVALUE = getController.encrypt8(buf);
    int AfgNETTVALUE = getController.encrypt8(buf);
    addData.add(
      ArraySubscribeSummaryForeignT()
        ..tanggal = ATGL
        ..prevPrice = APREVP
        ..closedPrice = ACLOSEDP
        ..fgAvgPriceBuy = AfgAVGPriceBUY
        ..fgAvgPriceSell = AfgAVGPriceSELL
        ..fgBuyVolume = AfgBUYVOLUME
        ..fgSellVolume = AfgSELLVOLUME
        ..fgNettVolume = AfgNETTVOLUME
        ..fgBuyValue = AfgBUYVALUE
        ..fgSellValue = AfgSELLVALUE
        ..fgNettValue = AfgNETTVALUE,
    );
  }
  listD = SubscribeSummaryForeignTModel(
      stockCodeL: scl,
      stockCode: sc,
      boardL: bl.toInt(),
      board: bls.toString(),
      tanggal: TGL,
      prevPrice: PREVP,
      lastPrice: LASTP,
      fgAvgPriceBuy: fgAVGPriceBUY,
      fgAvgPriceSell: fgAVGPriceSELL,
      fgBuyVolume: fgBUYVOLUME,
      fgSellVolume: fgSELLVOLUME,
      fgNettVolume: fgNETTVOLUME,
      fgBuyValue: fgBUYVALUE,
      fgSellValue: fgSELLVALUE,
      fgNettValue: fgNETTVALUE,
      array: AR);
  print("Ini datanya ==========");
  print(listD.stockCode);
  print(listD.stockCodeL);
}
