import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/model/rangkingstock_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';

class GetDataRangkingController extends GetxController
    with StateMixin<List<Quotes>> {
  Rx<HandelReqRangkinModel> code = HandelReqRangkinModel().obs;
  RxList<ArrayData> data = <ArrayData>[].obs;
  RxList<Quotes> dataQ = <Quotes>[].obs;
  Rx<StockData> stockData = StockData().obs;
  RxBool isDelate = false.obs;
  RxBool isFirst = false.obs;
  RxInt index = 1.obs;
  late final ControllerHandelSUB getHandel;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      getHandel = Get.put(ControllerHandelSUB());
      ever(code, (callback) => getDataReq());
      addDataToList();
    });
  }

  void add(HandelReqRangkinModel data, {int? indexs}) {
    code.update((val) {
      val!.board = data.board;
      val.code = data.code;
      val.nRequest = data.nRequest;
    });
    indexs == null ? 1 : index.value = indexs;
  }

  void getDataReq() {
    ActivityRequest.stockRangkingRequest(
      packageId: Constans.PACKAGE_ID_STOCK_RANGKING,
      reqType: code.value.code!,
      board: code.value.board!,
      nRequest: code.value.nRequest!,
    );
  }

  void quoteReq() {
    final getConnect = Get.put(ConnectionsController());
    if (getConnect.onReadys.value == true) {
      final getDataList = ObjectBoxDatabase.StockCodeRangking;
      var queryData = getDataList
          .query(StockData_.reqType.equals(code.value.code!) &
              StockData_.iBoard.equals(code.value.board! == 'RG' ? 0 : 1))
          .build()
          .findFirst();
      for (var x = 0;
          (x < 10 ? x < queryData!.arrayData.length : x < 10);
          x++) {
        if (queryData != null) {
          ActivityRequest.quoteRequest(
            packageId: Constans.PACKAGE_ID_QUOTES,
            arrayStockCode: [
              ArrayStockCode(
                stockCode: queryData.arrayData[x].stockCode,
                board: queryData.iBoard! == 0 ? 'RG' : 'TN',
              ),
            ],
          );
        } else {
          ActivityRequest.quoteRequest(
            packageId: Constans.PACKAGE_ID_QUOTES,
            arrayStockCode: [
              ArrayStockCode(
                stockCode: data[x].stockCode,
                board: code.value.board,
              ),
            ],
          );
        }
      }
    }
  }

  void addDataToList() {
    final getDataList = ObjectBoxDatabase.StockCodeRangking;
    var queryData = getDataList
        .query(StockData_.reqType.equals(code.value.code!) &
            StockData_.iBoard.equals(code.value.board! == 'RG' ? 0 : 1))
        .build()
        .findFirst();
    if (queryData != null) {
      // if (data.isNotEmpty) {
      //   if (isDelate.value == true) {
      //     for (int i = 0; i < 10; i++) {
      //       getHandel.addOrUpdateToSubList(
      //         ModelSUB(
      //           routingKey: "QT.${data[i].stockCode}.BR",
      //           isRun: false,
      //         ),
      //       );
      //     }
      //     isDelate.toggle();
      //   }
      // }

      data.clear();
      data.addAll(queryData.arrayData.toList());
      stockData.value = queryData;
      stockData.refresh();
      data.refresh();
    } else {
      data = <ArrayData>[].obs;
      stockData.value = StockData();
      stockData.refresh();
      data.refresh();
    }
    if (isFirst.value == false) {
      if (data.isNotEmpty) {
        quoteReq();
        isFirst.toggle();
      }
    }
    addQoutes();
  }

  void addQoutes() {
    final qoutes = ObjectBoxDatabase.quotesBox;
    List<Quotes> list = [];
    dataQ.clear();
    for (var i in data) {
      var query = qoutes
          .query(
            Quotes_.stockCode.equals(i.stockCode!) & Quotes_.board.equals('RG'),
          )
          .build()
          .findFirst();
      if (query != null) {
        list.add(query);
      }
    }
    if (list.isNotEmpty) {
      dataQ.addAll(list);
      list.clear();
    }
    handelState();
  }

  void handelState() {
    try {
      if (dataQ.isNotEmpty) {
        change(dataQ, status: RxStatus.success());
        dataQ.refresh();
      } else {
        change(null, status: RxStatus.empty());
        // ActivityRequest.stockRangkingRequest(
        //   packageId: Constans.PACKAGE_ID_STOCK_RANGKING,
        //   reqType: code.value.code!,
        //   board: code.value.board!,
        //   nRequest: code.value.nRequest!,
        // );
        dataQ.refresh();
      }
      Future.delayed(
        const Duration(milliseconds: 5),
        () {
          for (int i = 0; i < 1;) {
            addDataToList();
            break;
          }
        },
      );
    } catch (e) {
      change(null, status: RxStatus.error('ERROR GET DATA: $e'));
      Future.delayed(
        const Duration(milliseconds: 5),
        () {
          for (int i = 0; i < 1;) {
            addDataToList();
            break;
          }
        },
      );
    }
  }
}

class HandelReqRangkinModel {
  int? code;
  String? board;
  int? nRequest;

  HandelReqRangkinModel({
    this.code = 1, //1~9
    this.board = 'RG', //RG DAN TN
    this.nRequest = 0,
  });
}
