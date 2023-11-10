// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/model/indexmember_model.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:synchronized/synchronized.dart';

class StockMemberIndexController extends GetxController
    with StateMixin<List<Quotes>> {
  final _objectMember = ObjectBoxDatabase.indexMembers;
  final RxList<Quotes> tempQoutes = RxList<Quotes>();
  final RxList<IndexMember> tempMember = RxList<IndexMember>();
  final RxList<Quotes> dataQuotesselected = RxList<Quotes>();
  RxString indecc = ''.obs;
  RxString boardc = ''.obs;
  final lock = Lock();
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void getAllmemberWithQuery(String indexCode, String board) {
    tempMember.assignAll(
      _objectMember
          .query(IndexMember_.indexCode.equals(indexCode))
          .build()
          .find(),
    );
    indecc.value = indexCode;
    boardc.value = board;
    getQuotes();
  }

  void getQuotes() async {
    for (int i = 0; i < tempMember.first.array.length; i++) {
      await lock.synchronized(() {
        ActivityRequest.quoteRequest(
          packageId: Constans.PACKAGE_ID_QUOTES,
          arrayStockCode: [
            ArrayStockCode(
              stockCode: tempMember.first.array[i].stockCode,
              board: boardc.value,
            )
          ],
          commant: 1,
        );
      });
    }
    getMemberQuotes();
  }

  List<Quotes> getMemberQuotes() {
    final data = _objectMember
        .query(IndexMember_.indexCode.equals(indecc.value))
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
                Quotes_.board.equals(
                  boardc.value,
                ),
          )
          .build()
          .findFirst();
      if (dataq != null) {
        dataQuotesselected.add(dataq);
      }
      change(dataQuotesselected, status: RxStatus.success());
    }
    Future.delayed(const Duration(milliseconds: 5), () {
      getMemberQuotes();
    });
    return dataQuotesselected;
  }
}
