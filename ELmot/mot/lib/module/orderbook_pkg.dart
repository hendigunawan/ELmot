import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/model/orderbook_model.dart';
// import 'package:online_trading/module/model/orderbook_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

RxList<OrderBook> listOrderBook = <OrderBook>[].obs;
updateOrder() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  OrderBook listD = OrderBook();
  List<Bid> addDataB = [];
  List<Offer> addDataF = [];
  final object = ObjectBoxDatabase.orderBookBox;
  // object.removeAll();
  int scl = getController.encrypt2(buf);
  String sc = getController.getAsciiString(buf, scl);
  int bl = getController.encrypt2(buf);
  String bls = getController.getAsciiString(buf, bl);
  int Ar = getController.encrypt4(buf);
  for (int x = 0; x < Ar; x++) {
    int addBidPrice = getController.encrypt4(buf);
    int addBidVolume = getController.encrypt8(buf);
    int addBidNqueue = getController.encrypt4(buf);
    // izin edit ini
    if (Ar == 0 || Ar < 0) {
      addDataB.add(Bid()
        ..bidPrice = 0
        ..bidVolume = 0
        ..bidNqueue = 0);
    } else if (Ar != 0) {
      addDataB.add(
        Bid()
          ..bidPrice = addBidPrice
          ..bidVolume = addBidVolume
          ..bidNqueue = addBidNqueue,
      );
    }
    // Sampe sini
  }
  int Arf = getController.encrypt4(buf);
  for (int x = 0; x < Arf; x++) {
    int OP = getController.encrypt4(buf);
    int OV = getController.encrypt8(buf);
    int ON = getController.encrypt4(buf);

    addDataF.add(
      Offer()
        ..offerPrice = OP
        ..offerVolume = OV
        ..offerNqueue = ON,
    );
  }

  listD = OrderBook(
    stockCL: scl,
    stockC: sc.toString(),
    boardL: bl.toInt(),
    board: bls.toString(),
    arrayOFBID: Ar.toInt(),
    arrayOFOffer: Arf.toInt(),
    lastUpdated: DateTime.now().millisecondsSinceEpoch,
  );

  final existingPerson = object
      .query(
        OrderBook_.stockC.equals(listD.stockC.toString()) &
            OrderBook_.board.equals(listD.board.toString()),
      )
      .build()
      .findFirst();
  listD.arrayOOffer.addAll(addDataF);
  listD.arrayOBID.addAll(addDataB);

  if (existingPerson != null) {
    existingPerson.arrayOBID.clear();
    existingPerson.arrayOBID.addAll(addDataB);
    existingPerson.arrayOOffer.clear();
    existingPerson.arrayOOffer.addAll(addDataF);
    existingPerson.lastUpdated = listD.lastUpdated;
    object.put(existingPerson);
    print(
        'Data person diperbarui: ${existingPerson.stockC}.${existingPerson.board}, ${addDataB.length} & ${addDataF.length}');
  } else {
    print(
        'Data person dengan ${listD.board} dan ${listD.stockC}  yang sama tidak ditemukan, ${addDataB.length} & ${addDataF.length}');
    object.put(listD);
  }
  var order = object.getAll();
  order;
}
