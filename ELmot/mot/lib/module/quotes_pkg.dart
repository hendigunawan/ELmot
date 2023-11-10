import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

QuotesReplay() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  final object = ObjectBoxDatabase.quotesBox;

  int stockCodeL = getController.encrypt2(buf);
  String stockCode = getController.getAsciiString(buf, stockCodeL);
  int boardL = getController.encrypt2(buf);
  String board = getController.getAsciiString(buf, boardL);
  int lastTradedTime = getController.encrypt4(buf);
  int prevPrice = getController.encrypt4(buf);
  int prevChg = getController.encrypt4(buf);
  int prevChgRate = getController.encrypt4(buf);
  int lastPrice = getController.encrypt4(buf);
  int change = getController.getDouble(buf);
  int chgRate = getController.getDouble(buf);
  int openPrice = getController.encrypt4(buf);
  int hiPrice = getController.encrypt4(buf);
  int loPrice = getController.encrypt4(buf);
  int avgPrice = getController.getDouble(buf);
  int freq = getController.encrypt4(buf);
  int volume = getController.encrypt8(buf);
  int value = getController.encrypt8(buf);
  int fgNetValue = getController.encrypt8(buf);
  int marketCaps = getController.encrypt8(buf);
  int bestBidPrice = getController.encrypt4(buf);
  int bestBidVol = getController.encrypt8(buf);
  int bestOfferPrice = getController.encrypt4(buf);
  int bestOfferVol = getController.encrypt8(buf);
  int IEP = getController.encrypt4(buf);
  int IEV = getController.encrypt8(buf);

  Quotes quotes = Quotes(
    stockCode: stockCode,
    board: board,
    lastTradedTime: lastTradedTime,
    prevPrice: prevPrice,
    prevChg: prevChg,
    prevChgRate: prevChgRate,
    lastPrice: lastPrice,
    change: change,
    chgRate: chgRate,
    openPrice: openPrice,
    hiPrice: hiPrice,
    loPrice: loPrice,
    avgPrice: avgPrice,
    freq: freq,
    volume: volume,
    value: value,
    fgNetValue: fgNetValue,
    marketCaps: marketCaps,
    bestBidPrice: bestBidPrice,
    bestBidVol: bestBidVol,
    bestOfferPrice: bestOfferPrice,
    bestOfferVol: bestOfferVol,
    IEPrice: IEP,
    IEVolume: IEV,
  );

  final existingPerson = object
      .query(
        Quotes_.stockCode.equals(quotes.stockCode.toString()) &
            Quotes_.board.equals(quotes.board.toString()),
      )
      .build()
      .findFirst();

  if (existingPerson != null) {
    existingPerson.stockCode = stockCode;
    existingPerson.board = board;
    existingPerson.lastTradedTime = lastTradedTime;
    existingPerson.prevPrice = prevPrice;
    existingPerson.prevChg = prevChg;
    existingPerson.prevChgRate = prevChgRate;
    existingPerson.lastPrice = lastPrice;
    existingPerson.change = change;
    existingPerson.chgRate = chgRate;
    existingPerson.openPrice = openPrice;
    existingPerson.hiPrice = hiPrice;
    existingPerson.loPrice = loPrice;
    existingPerson.avgPrice = avgPrice;
    existingPerson.freq = freq;
    existingPerson.volume = volume;
    existingPerson.value = value;
    existingPerson.fgNetValue = fgNetValue;
    existingPerson.marketCaps = marketCaps;
    existingPerson.bestBidPrice = bestBidPrice;
    existingPerson.bestBidVol = bestBidVol;
    existingPerson.bestOfferPrice = bestOfferPrice;
    existingPerson.bestOfferVol = bestOfferVol;
    if (existingPerson.IEPrice == null) {
      existingPerson.IEPrice = 0;
    } else {
      existingPerson.IEVolume ??= 0;
    }
    existingPerson.IEPrice = IEP;
    existingPerson.IEVolume = IEV;
    object.put(existingPerson);
    print('UPDATE');
  } else {
    object.put(quotes);
    print('ADD');
  }
}
