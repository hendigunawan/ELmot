import 'package:get/get.dart';

import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/model/index_model.dart';
import 'package:online_trading/module/model/indexlist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:synchronized/synchronized.dart';

class IndexListTopController extends GetxController
    with StateMixin<List<IndexListTop45>> {
  final lock = Lock();
  final _myObjectBoxIndex = ObjectBoxDatabase.Indexlisttop45Aja;
  final _myObjectQuotesIndex = ObjectBoxDatabase.indexaja;
  final RxList<IndexListTop45> tempDataList = RxList<IndexListTop45>();
  final RxList<ArrayIndexListTop45> tempArray = RxList<ArrayIndexListTop45>();
  final RxList<IndexModelS> tempdataQuoteIndexList = RxList<IndexModelS>();
  @override
  void onInit() async {
    super.onInit();
    // await Future.sync(() async {
    //   ActivityRequest.indexListRequest(
    //       packageId: Constans.PACKAGE_ID_INDEX_LIST);
    // });

    await lock.synchronized(
      () {
        getAll();
      },
    );
    await lock.synchronized(
      () {
        subscirbeIndexAll();
      },
    );
  }

  void subscirbeIndexAll() async {
    var datasub = getAll().first.array;
    for (int i = 0; i < datasub.length; i++) {
      await lock.synchronized(() {
        ActivityRequest.indexRequest(
          packageId: Constans.PACKAGE_ID_INDEX,
          commant: "1",
          arrayIndexCode: [datasub[i].IndexCode.toString()],
        );
      });
      await lock.synchronized(() {
        ActivityRequest.indexMemberListRequest(
            packageId: Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST,
            indexName: datasub[i].IndexCode.toString());
      });
    }
    getIndexQoutes();
  }

  void getIndexQoutes() {
    tempdataQuoteIndexList.assignAll(_myObjectQuotesIndex.getAll());
    getAll();
  }

// update data terus kata mas hendi gunawan
  List<IndexListTop45> getAll() {
    ConnectionsController getConnect = Get.find();
    List<IndexListTop45> data = _myObjectBoxIndex.getAll();
    if (data.isEmpty) {
      Future.delayed(const Duration(milliseconds: 500), () {
        change(null, status: RxStatus.empty());
      });
    } else if (getConnect.onError() == true) {
      Future.delayed(const Duration(milliseconds: 500), () {
        change(null, status: RxStatus.error());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        change(data, status: RxStatus.success());
      });
    }
    Future.delayed(const Duration(seconds: 1), () {
      getIndexQoutes();
    });
    return data;
  }
}
