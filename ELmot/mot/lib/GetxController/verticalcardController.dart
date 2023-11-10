import 'package:get/get.dart';
import 'package:online_trading/module/model/indexmember_model.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:synchronized/synchronized.dart';

class VerticalCardController extends GetxController
    with StateMixin<List<Quotes>> {
  final lock = Lock();
  final getObjectBox = ObjectBoxDatabase.indexMembers;
  final getObjectQoute = ObjectBoxDatabase.quotesBox;
  RxList<IndexMember> listmember = <IndexMember>[].obs;
  final RxList<IndexMember> tempMember = RxList<IndexMember>();
  RxList<Quotes> listquotes = <Quotes>[].obs;
  final RxList<Quotes> dataQuotesselected = RxList<Quotes>();
  @override
  void onInit() async {
    super.onInit();
    // ever(dataQuotesselected, (callback) => getMemberQuotes());
    await lock.synchronized(() {
      // getAllIndexmembers();
      getAllMember();
    });
  }

  void getAllMember() {
    tempMember.assignAll(
      getObjectBox.query(IndexMember_.indexCode.equals("LQ45")).build().find(),
    );
    subscribeQuotesAll();
  }

  void subscribeQuotesAll() async {
    // for (int i = 0; i < tempMember.first.array.length; i++) {
    //   await lock.synchronized(() {
    //     ActivityRequest.quoteRequest(
    //         packageId: Constans.PACKAGE_ID_QUOTES,
    //         arrayStockCode: [
    //           ArrayStockCode(
    //             board: "RG",
    //             stockCode: tempMember.first.array[i].stockCode.toString(),
    //           )
    //         ],
    //         commant: 1);
    //   });
    // }
    getMemberQuotes();
  }

  void getMemberQuotes() {
    final data = getObjectBox
        .query(IndexMember_.indexCode.equals("LQ45"))
        .build()
        .findFirst();
    final openQuotes = ObjectBoxDatabase.quotesBox;

    dataQuotesselected.clear();
    for (int i = 0; i < data!.array.length; i++) {
      Quotes? dataq = openQuotes
          .query(
            Quotes_.stockCode.equals(
                  data.array[i].stockCode.toString(),
                ) &
                Quotes_.board.equals("RG"),
          )
          .build()
          .findFirst();
      if (dataq != null) {
        dataQuotesselected.add(dataq);
      }
      change(dataQuotesselected, status: RxStatus.success());
    }

    Future.delayed(const Duration(milliseconds: 50), () {
      getMemberQuotes();
    });
    // return dataQuotesselected;
  }
}
