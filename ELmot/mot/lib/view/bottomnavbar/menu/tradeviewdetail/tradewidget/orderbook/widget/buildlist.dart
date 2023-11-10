import 'package:online_trading/module/model/orderbook_model.dart';

class GetDataListOrderBook {
  static late List<Bid> dataBid;
  static late List<Offer> dataOFTER;

  static List<Bid> getDataBID(int lenght, List<Bid> data) {
    return dataBid = List.generate(
      lenght,
      (index) {
        if (index < data.length) {
          return data[index];
        } else {
          return Bid()
            ..bidNqueue = 0
            ..bidPrice = 0
            ..bidNqueue = 0
            ..bidVolume = 0;
        }
      },
    );
  }

  static List<Offer> getDataOFTER(int lenght, List<Offer> data) {
    return dataOFTER = List.generate(
      lenght,
      (index) {
        if (index < data.length) {
          return data[index];
        } else {
          return Offer()
            ..offerPrice = 0
            ..offerPrice = 0
            ..offerNqueue = 0
            ..offerVolume = 0;
        }
      },
    );
  }
}
