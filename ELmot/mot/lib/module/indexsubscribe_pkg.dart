import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

import 'model/index_model.dart';

IndexSubscribe() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  IndexModelS listD = IndexModelS();
  final object = ObjectBoxDatabase.indexaja;
  int indexCodeLs = getController.encrypt2(buf);
  String indexCodes = getController.getAsciiString(buf, indexCodeLs);
  int LASTUPTIME = getController.encrypt4(buf);
  int CURRINDEX = getController.encrypt4(buf);
  int PREVI = getController.encrypt4(buf);
  int OPENI = getController.encrypt4(buf);
  int HIGHI = getController.encrypt4(buf);
  int LOWI = getController.encrypt4(buf);
  int CHANGE = getController.getDouble(buf);
  int CHANGER = getController.getDouble(buf);
  int FREG = getController.encrypt4(buf);
  int VOLUME = getController.encrypt8(buf);
  int VALUE = getController.encrypt8(buf);
  int UP = getController.encrypt4(buf);
  int DOWN = getController.encrypt4(buf);
  int UNCHANGE = getController.encrypt4(buf);
  int NOTRANSACTION = getController.encrypt4(buf);
  int BASEVALUE = getController.encrypt8(buf);
  int MARKETVALUE = getController.encrypt8(buf);
  int FGBUYFREQ = getController.encrypt4(buf);
  int FGSELLFREG = getController.encrypt4(buf);
  int FGBUYVOLUME = getController.encrypt8(buf);
  int FGSELLVOLUME = getController.encrypt8(buf);
  int FGBUYVALUE = getController.encrypt8(buf);
  int FGSELLVALUE = getController.encrypt8(buf);
  listD = IndexModelS(
    indexCodeL: indexCodeLs,
    indexCode: indexCodes,
    lastUpdateT: LASTUPTIME,
    currentI: CURRINDEX,
    prevI: PREVI,
    openI: OPENI,
    highI: HIGHI,
    lowI: LOWI,
    change: CHANGE,
    changeR: CHANGER,
    freq: FREG,
    volume: VOLUME,
    value: VALUE,
    up: UP,
    down: DOWN,
    unChange: UNCHANGE,
    noTransaksi: NOTRANSACTION,
    baseValue: BASEVALUE,
    marketValue: MARKETVALUE,
    fgBuyFreq: FGBUYFREQ,
    fgSellFreq: FGSELLFREG,
    fgBuyVol: FGBUYVOLUME,
    fgSellVol: FGSELLVOLUME,
    fgBuyVal: FGBUYVALUE,
    fgSellVal: FGSELLVALUE,
  );

  final existingPerson = object
      .query(IndexModelS_.indexCode.equals(listD.indexCode.toString()))
      .build()
      .findFirst();

  if (existingPerson != null) {
    // penambahan, remove object terlebih dahulu baru dimasukkan lagi data kedalam object box yang baru
    object.remove(existingPerson.id!);
    existingPerson.indexCodeL = listD.indexCodeL;
    existingPerson.indexCode = listD.indexCode;
    existingPerson.lastUpdateT = listD.lastUpdateT;
    existingPerson.currentI = listD.currentI;
    existingPerson.prevI = listD.prevI;
    existingPerson.openI = listD.openI;
    existingPerson.highI = listD.highI;
    existingPerson.lowI = listD.lowI;
    existingPerson.change = listD.change;
    existingPerson.changeR = listD.changeR;
    existingPerson.freq = listD.freq;
    existingPerson.volume = listD.volume;
    existingPerson.value = listD.value;
    existingPerson.up = listD.up;
    existingPerson.down = listD.down;
    existingPerson.unChange = listD.unChange;
    existingPerson.noTransaksi = listD.noTransaksi;
    existingPerson.baseValue = listD.baseValue;
    existingPerson.marketValue = listD.marketValue;
    existingPerson.fgBuyFreq = listD.fgBuyFreq;
    existingPerson.fgSellFreq = listD.fgSellFreq;
    existingPerson.fgBuyVol = listD.fgBuyVol;
    existingPerson.fgSellVol = listD.fgSellVol;
    existingPerson.fgBuyVal = listD.fgBuyVal;
    existingPerson.fgSellVal = listD.fgSellVal;
    object.put(existingPerson);
    print('Data person diperbarui: ${existingPerson.indexCode}');
  } else {
    print('Data person dengan ${listD.indexCode}   yang sama tidak ditemukan');
    object.put(listD);
  }
  var ob = object.getAll();
  ob;
}
