import 'package:get/get.dart';
import 'package:online_trading/GetxController/favoritecontrollerlocal.dart';
import 'package:online_trading/module/model/favoritelocal_model.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';

class RunningTradeController extends GetxController {
  RxString querys = ''.obs;
  RxList<FavoriteLoacalB> rombongan = <FavoriteLoacalB>[].obs;
  RxList<RunningTrades> dummy = <RunningTrades>[].obs;
  RxList<RunningTrades> listQuery = <RunningTrades>[].obs;
  RxList<RunningTrades> list = <RunningTrades>[].obs;

  Rx<RunningTrades> data = RunningTrades().obs;

  void addDatas(RunningTrades add) {
    data.value = add;
  }

  @override
  void onInit() {
    super.onInit();
    ever(querys, (callback) => listQuery.clear());
    ever(data, (callback) {
      buildList(callback);
      buildListQuery(querys.value, callback);
      buildListQueryRombongan(rombongan, callback);
    });
  }

  void buildList(RunningTrades datas) {
    int lenght = 30;

    if (list.length >= lenght) {
      list.removeAt(0);
    }

    list.add(datas);
    list.refresh();
    update();
  }

  void buildListQuery(String? query, RunningTrades datas) {
    if (query == null || query == '') return;
    RunningTrades? listDatas = datas;

    if (listDatas.isBlank! || listDatas.stockCode != query) return;

    if (listQuery.length >= 50) {
      listQuery.removeAt(0);
    }

    listQuery.add(listDatas);
    list.refresh();
    update();
  }

  void buildListQueryRombongan(
      List<FavoriteLoacalB>? query, RunningTrades datas) {
    if (query == null || query.isEmpty) return;
    RunningTrades? listDatas = datas;

    for (var i = 0; i < query.length; i++) {
      var getList = Get.put(FavoriteControllerLocal()).getAll(query[i]);
      if (getList.isEmpty) rombongan.removeAt(i);
      var where = getList
          .where((element) => element.stockCode == datas.stockCode)
          .toList();
      if (where.isNotEmpty) {
        if (listQuery.length >= 50) {
          listQuery.removeAt(0);
        }

        listQuery.add(listDatas);
        list.refresh();
        update();
      }
    }
  }
}
