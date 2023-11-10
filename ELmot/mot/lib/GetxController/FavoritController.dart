// import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_trading/module/model/PERCOBAANMODEL.dart';
import 'package:online_trading/module/model/stockgrouplist_model.dart';
import 'package:online_trading/module/model/temp_stockgrouplist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

class CRUDDataController extends GetxController {
  late Box<PERCOBAAN> box;
  final openStockGrouplist = ObjectBoxDatabase.stockgroupListAja;
  RxList<StockGroupListModel> dataStockGroupList = <StockGroupListModel>[].obs;
  RxList<PERCOBAAN> dataList = <PERCOBAAN>[].obs;

  @override
  void onInit() {
    super.onInit();
    box = ObjectBoxDatabase.PERCOBAANAJA;
    getPERCOBAAN();
  }

  void getPERCOBAAN() {
    dataList.assignAll(box.getAll());
  }

  void addNewPERCOBAAN(String nama, int newsDate, int command, int array) {
    final newPerco = PERCOBAAN(
      nama: nama,
      newsDate: newsDate,
      command: command,
    );
    box.put(newPerco);
    dataList.add(newPerco);
    print("Data baru berhasil ditambahkan.");
  }

  // batas benar
}

class FavController extends GetxController {
  final _myObjectBox = ObjectBoxDatabase.TempStockGroupListAja;
  final _myObjectBoxMember = ObjectBoxDatabase.TempStockGroupListMemberAja;
  final _TempListMemberModel = ObjectBoxDatabase.TempStockGroupListMember;
  final RxList<TempStockGroupListModel> tempDataList =
      RxList<TempStockGroupListModel>();
  final RxList<TempArrayStockGroupList> tempArray =
      <TempArrayStockGroupList>[].obs;
  List<TempStockGroupListModel> specificData = [];
  List<TempStockGroupListMemberModel> datasemuagroup = [];
  RxList<TempStockGroupListModel> data = RxList<TempStockGroupListModel>();
  final RxList<TempStockGroupListMemberModel> dataAllgroupname =
      RxList<TempStockGroupListMemberModel>();
  RxList<TempArrayOFStockCode> datastockcodenya = <TempArrayOFStockCode>[].obs;
  RxList<bool> cekCeklis = <bool>[].obs;
  // stockcode
  final RxList<TempArrayOFStockCode> stockCodeSelected =
      RxList<TempArrayOFStockCode>();
  final RxList<TempArrayOFStockCode> stockDelete =
      RxList<TempArrayOFStockCode>();
  //
  @override
  void onInit() {
    super.onInit();

    getDataAllwithClientId();
    // _myObjectBox.removeAll();
    // _myObjectBoxMember.removeAll();
    // _TempListMemberModel.removeAll();
  }

  void getDataAllwithClientId() {
    specificData = _myObjectBox
        .getAll()
        .where((data) => data.clientId == "Dayat")
        .toList();
    if (specificData.isNotEmpty) {
      tempDataList.assignAll(specificData);
    }
  }

  void addNewGroup(String clientID, String newGroupname, int isDefault) {
    TempArrayStockGroupList newGroupArray = TempArrayStockGroupList()
      ..groupName = newGroupname
      ..groupNameL = newGroupname.length
      ..isDefault = isDefault;

    final newDataTemp = TempStockGroupListModel(
        array: 1, clientId: clientID, clientIdL: clientID.length);
    newDataTemp.arrayListTemp.add(newGroupArray);
    final existingDataTemp = _myObjectBox
        .query(TempStockGroupListModel_.clientId
            .equals(newDataTemp.clientId.toString()))
        .build()
        .findFirst();
    // final all = _myObjectBox.getAll();
    if (existingDataTemp != null) {
      existingDataTemp.arrayListTemp.add(newGroupArray);
      tempDataList.remove(existingDataTemp);
      tempDataList.add(existingDataTemp);
      _myObjectBox.put(existingDataTemp);
    } else {
      tempDataList.add(newDataTemp);
      _myObjectBox.put(newDataTemp);
    }
    getDataAllwithClientId();
  }

  void deleteGroupFavorit(String clientID, String groupName) {
    final existingData = _myObjectBox
        .query(TempStockGroupListModel_.clientId.equals("Dayat"))
        .build()
        .findFirst();
    if (existingData != null) {
      for (int i = 0; i < existingData.arrayListTemp.length; i++) {
        if (existingData.arrayListTemp[i].groupName == groupName) {
          existingData.arrayListTemp
              .removeWhere((item) => item.groupName == groupName);
          tempDataList.remove(existingData);
          tempDataList.add(existingData);
          _myObjectBox.put(existingData);
        }
        _myObjectBox.put(existingData);
        getDataAllwithClientId();
      }
    }
  }

  void addmemberofgroupFavorit(
      String clientId, String stockCode, String groupname, bool isAdd) {
    TempArrayOFStockCode newDatastockCodeMember = TempArrayOFStockCode()
      ..stockC = stockCode
      ..stockCL = stockCode.length;
    TempArrayOFGroupname newDataGroupMember = TempArrayOFGroupname(
      groupName: groupname,
      groupNameL: groupname.length,
      arraystockCD: 1,
    );
    newDataGroupMember.arrayListStockCD.add(newDatastockCodeMember);
    TempStockGroupListMemberModel allData = TempStockGroupListMemberModel(
      array1: 1,
      clientId: clientId,
      clientIdL: clientId.length,
    );
    allData.arrayList.add(newDataGroupMember);

    final existingMember = _myObjectBoxMember
        .query(TempStockGroupListMemberModel_.clientId.equals(clientId))
        .build()
        .findFirst();
    if (existingMember != null) {
      for (int i = 0; i < existingMember.arrayList.length; i++) {
        var groupnameada = existingMember.arrayList.first.groupName;
        if (existingMember.clientId == allData.clientId) {
          if (existingMember.arrayList.isEmpty) {
            existingMember.arrayList.add(newDataGroupMember);
            print("berhasil 1");
          } else {
            if (groupnameada == groupname) {
              // _myObjectBoxMember.removeAll();
              // break;
              if (existingMember.arrayList.first.arrayListStockCD[i].stockC ==
                  allData.arrayList.first.arrayListStockCD[i].stockC) {
                print("Sama");
                // break;
              } else {
                // existingMember.arrayList.first.arrayListStockCD
                //     .remove(existingMember.arrayList[i].arrayListStockCD);
                // existingMember.arrayList[i].arrayListStockCD
                //     .add(newDatastockCodeMember);
                // existingMember.arrayList.add(newDataGroupMember);
                existingMember.arrayList.first.arrayListStockCD
                    .add(newDatastockCodeMember);
                _myObjectBoxMember.put(existingMember);
                print("berhasil 2");
              }
            } else {
              existingMember.arrayList.assign(newDataGroupMember);
              _myObjectBoxMember.put(existingMember);
            }
          }
        } else {
          print("grup name tidak sama");
        }
      }
    } else {
      _myObjectBoxMember.put(allData);
    }
  }

  void getAllGroupFavorit(String clientId, String groupname) {
    datasemuagroup = _myObjectBoxMember
        .getAll()
        .where((data) => data.clientId == clientId)
        .toList();

    if (datasemuagroup.isNotEmpty) {
      dataAllgroupname.assignAll(datasemuagroup);
    }
    getMemberfromgroup(groupname);
  }

  void getMemberfromgroup(String groupname) {
    for (int i = 0; i < dataAllgroupname.first.arrayList.length; i++) {
      var groupnamedalam = dataAllgroupname.first.arrayList[i].groupName;
      if (groupnamedalam == groupname) {
        // datastockcodenya.clear();
        datastockcodenya
            .addAll(dataAllgroupname.first.arrayList[i].arrayListStockCD);
      }
    }
  }

//  voidaddfavorit
  void addFavvvMember(
      String clientId, String stockCode, String groupname, bool isAdd) {
    isAdd = true;
    TempArrayOFStockCode newDatastockCodeMember = TempArrayOFStockCode()
      ..stockC = stockCode
      ..stockCL = stockCode.length;
    TempArrayOFGroupname newDataGroupMember = TempArrayOFGroupname(
      groupName: groupname,
      groupNameL: groupname.length,
      arraystockCD: 1,
    );
    newDataGroupMember.arrayListStockCD.add(newDatastockCodeMember);
    TempStockGroupListMemberModel allData = TempStockGroupListMemberModel(
      array1: 1,
      clientId: clientId,
      clientIdL: clientId.length,
    );
    allData.arrayList.add(newDataGroupMember);
    // batas data baru masuk kedalam model
    final existingMember = _TempListMemberModel.query(
            TempArrayOFGroupname_.groupName.equals(groupname))
        .build()
        .findFirst();

    if (existingMember != null) {
      final stockCodeExists = existingMember.arrayListStockCD
          .any((element) => element.stockC == stockCode);

      if (!stockCodeExists) {
        existingMember.arrayListStockCD.add(newDatastockCodeMember);
        _TempListMemberModel.put(existingMember);
      }
    } else {
      _myObjectBoxMember.put(allData);
    }
  }

// baru
  void displayDataByGroupName(String groupName) {
    final existingMember = _myObjectBoxMember.getAll();

    List<TempArrayOFStockCode> data = <TempArrayOFStockCode>[];
    if (existingMember.isNotEmpty) {
      if (existingMember.first.arrayList.isNotEmpty) {
        for (var i in existingMember) {
          for (var s in i.arrayList) {
            if (s.groupName == groupName) {
              data.addAll(s.arrayListStockCD);
            }
          }
        }
        stockCodeSelected.clear();
        stockCodeSelected.assignAll(data);
      }
    }
  }

  void deleteStockfromGroup(String groupname, String stockC) {}

// batas akhir
// memanggil void baru ni
  void addVoiddatanew(
      String clientId, String stockCode, String groupname, bool isAdd) {
    TempArrayOFStockCode newDatastockCodeMember = TempArrayOFStockCode()
      ..stockC = stockCode
      ..stockCL = stockCode.length;

    TempArrayOFGroupname newDataGroupMember = TempArrayOFGroupname(
      groupName: groupname,
      groupNameL: groupname.length,
      arraystockCD: 1,
    );
    newDataGroupMember.arrayListStockCD.add(newDatastockCodeMember);

    TempStockGroupListMemberModel allData = TempStockGroupListMemberModel(
      array1: 1,
      clientId: clientId,
      clientIdL: clientId.length,
    );
    allData.arrayList.add(newDataGroupMember);

    final data2 = _myObjectBoxMember
        .query(TempStockGroupListMemberModel_.clientId.equals(clientId))
        .build()
        .find();

    bool isGroupFound = false;
    for (var i in data2) {
      if (i.arrayList.any((element) => element.groupName == groupname)) {
        isGroupFound = true;

        // Jika grup ada, lakukan pembaruan data dalam grup ini.
        for (var element in i.arrayList) {
          if (element.groupName == groupname) {
            if (element.arrayListStockCD.isNotEmpty) {
              List<TempArrayOFStockCode> tempStockCode = [
                ...element.arrayListStockCD
              ];
              if (element.arrayListStockCD.any((e) => e.stockC == stockCode)) {
                // Lakukan logika untuk menghapus atau lainnya
                print("Ini untuk delete nanti");
              } else {
                tempStockCode.add(newDatastockCodeMember);
              }

              element.arrayListStockCD.clear();
              element.arrayListStockCD.addAll(tempStockCode);
              newDataGroupMember = element;
              print("Update data");
            } else {
              element.arrayListStockCD.add(newDatastockCodeMember);
              print("Data stock kosong, langsung tambah");
            }
          }
        }

        _myObjectBoxMember.put(i);
        // break; // Keluar dari loop setelah grup ditemukan dan diupdate
      }
    }

    if (!isGroupFound) {
      _myObjectBoxMember.put(allData);
      print("Redundan");
    }
    var data = _myObjectBoxMember.getAll();
    print(data);
  }
}
