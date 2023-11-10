// import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:online_trading/module/model/favoritelocal_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/objectbox.g.dart';

class FavoriteControllerLocal extends GetxController
    with StateMixin<List<FavoriteLocalM>> {
  final header = ObjectBoxDatabase.FavoriteLoacalHeader;
  final body = ObjectBoxDatabase.FavoriteLoacalBody;
  var getHeader = FavoriteLoacalH().obs;
  @override
  void onInit() {
    super.onInit();
    onAddHeader();
    if (header.isEmpty() && body.isEmpty()) {
      return;
    } else {
      if (body.getAll().isNotEmpty) {
        getAll(body.getAll().first);
      }
    }
  }

  void onAddHeader() {
    if (header.getAll().isEmpty) {
      // final getDataClient = ObjectBoxDatabase.loginBox.getAll();
      header.put(FavoriteLoacalH(
          clientTag: Get.find<LoginOrderController>().order!.value.loginId));
      getHeader.value = header.get(1)!;
    } else {
      getHeader.value = header.get(1)!;
    }
  }

  void onAddBody(String bodyName, bool isDelete) {
    if (body.getAll().isEmpty) {
      FavoriteLoacalB data = FavoriteLoacalB(groupTag: bodyName);
      data.header.target = getHeader.value;
      body.put(data);
      print('addNew');
    } else if (body.getAll().isNotEmpty) {
      var data = body.getAll();
      var getOneData = data.where((element) => element.groupTag == bodyName);

      if (getOneData.isEmpty) {
        FavoriteLoacalB data = FavoriteLoacalB(groupTag: bodyName);
        data.header.target = getHeader.value;
        body.put(data);
        print('addNew');
      } else {
        getOneData.first.groupTag = bodyName;
        getOneData.first.header.target = getHeader.value;
        body.putAsync(getOneData.first);
        print('add');
      }
    } else if (isDelete) {
      var data = body.getAll();
      var getOneData =
          data.where((element) => element.groupTag == bodyName).first;

      data.remove(getOneData);
      body.putManyAsync(data);
      print('Remover');
    }
  }

  void onAddMember(FavoriteLoacalB? bodys, String members, bool isDelete) {
    FavoriteLocalM memberst = FavoriteLocalM();
    if (members.isEmpty) {
      return;
    }
    if (bodys == null) {
      return;
    }
    var query = body
        .query(FavoriteLoacalB_.groupTag.equals(bodys.groupTag.toString()))
        .build()
        .findFirst();

    if (query != null) {
      if (query.member.isEmpty) {
        memberst.stockCode = members;
        query.member.add(memberst);
        body.put(query);
      }
      for (int i = 0; i < query.member.length; i++) {
        if (isDelete == true) {
          if (query.member[i].stockCode == members) {
            query.member.remove(query.member[i]);
            body.put(query, mode: PutMode.update);
          }
        } else {
          if (query.member[i].stockCode != members) {
            memberst.stockCode = members;
            query.member.add(memberst);
            body.put(query);
          } else if (query.member[i].stockCode == members) {
            break;
          }
        }
      }
    } else {
      query!.member.add(memberst);
      body.put(query, mode: PutMode.put);
      return;
    }
  }

  List<FavoriteLocalM> getAll(FavoriteLoacalB bodys) {
    var dataB =
        body.query(FavoriteLoacalB_.id.equals(bodys.id)).build().findFirst();
    List<FavoriteLocalM> data = [];
    if (dataB != null) {
      data = dataB.member;
    }
    if (data.isEmpty) {
      Future.delayed(const Duration(milliseconds: 5), () {
        change(null, status: RxStatus.empty());
      });
    } else {
      Future.delayed(const Duration(milliseconds: 5), () {
        change(data, status: RxStatus.success());
      });
    }
    return data;
  }

  void removeTask(String tag, FavoriteLoacalB? bodys) {
    if (bodys == null) {
      return;
    }
    var query = body
        .query(FavoriteLoacalB_.groupTag.equals(bodys.groupTag.toString()))
        .build()
        .findFirst();

    if (query != null) {
      for (int i = 0; i < query.member.length; i++) {
        if (query.member[i].stockCode == tag) {
          query.member.remove(query.member[i]);
        } else {
          break;
        }
      }
    } else {
      return;
    }
  }

  void removeBody(FavoriteLoacalB? bodys) {
    if (bodys == null) {
      return;
    }
    var query = body
        .query(FavoriteLoacalB_.groupTag.equals(bodys.groupTag!))
        .build()
        .findFirst();

    if (query != null) {
      body.remove(query.id);
    } else {
      return;
    }
  }
}
