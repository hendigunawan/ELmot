import 'dart:io';
import 'package:get/get.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

// RxString clientTags = ''.obs;

class ServiceAll extends GetxService {
  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await Get.putAsync(() async => await buildStore(), tag: "buildStore");
    await buildObjectBox();
    await Get.putAsync(() async => buildClientTag(), tag: "buildClientTag");
    await Get.putAsync(() async => await buildSharedPreferences(),
        tag: "buildSharedPreferences");
    await Get.putAsync<bool>(() => getStatusLogin(), tag: "getStatusLogin");
    Get.put(EncryptControll());
  }

  Future<SharedPreferences> buildSharedPreferences() async {
    return await SharedPreferences.getInstance();
  }

  Future<bool> getStatusLogin() async {
    final SecureStorage store = SecureStorage();

    if (await store.getPassWord() == null || await store.getPassWord() == '') {
      return false;
    } else {
      return true;
    }
    // final getShare = ObjectBoxDatabase.loginBox;

    // if (getShare.getAll().isEmpty) {
    //   return false;
    // } else {
    //   return true;
    // }
  }

  String buildClientTag() {
    String clientTag = generateRandomCode(10);
    if (GetPlatform.isAndroid) {
      clientTag = "US.${generateRandomCode(10)}.ANDROID";
    } else if (GetPlatform.isDesktop) {
      clientTag = "US.${generateRandomCode(10)}.DESKTOP";
    } else if (GetPlatform.isIOS) {
      clientTag = "US.${generateRandomCode(10)}.IOS";
    } else if (GetPlatform.isMacOS) {
      clientTag = "US.${generateRandomCode(10)}.MACOS";
    } else if (GetPlatform.isLinux) {
      clientTag = "US.${generateRandomCode(10)}.LINUX";
    }
    return clientTag;
  }

  Future<Store> buildStore() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbDirectory = '${appDirectory.path}/objectbox';
    if (!Directory(dbDirectory).existsSync()) {
      Directory(dbDirectory).createSync(recursive: true);
    }

    final store = Store(getObjectBoxModel(), directory: dbDirectory);
    return store;
  }

  Future<void> buildObjectBox() async {
    Store store = Get.find(tag: "buildStore");
    return await ObjectBoxDatabase.init(store);
  }
}

class GetDataStock {
  static final openBoxHashKey = ObjectBoxDatabase.hasKeyBox;
  static final lock = Lock();

  Future<void> getHashKey() async {
    await lock.synchronized(
      () async {
        ActivityRequest.haskeyRequest(
          packageId: Constans.PACKAGE_ID_HASH_KEY_MASTER_DATA,
        );
      },
    ).catchError(
      (onError) {
        print("EROOR CEK HASH KEY LIST: $onError");
      },
    );
  }
}

class GetDataController extends GetxController {
  RxBool onDoneMember = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(onDoneMember, (callback) => GetDatas().getMemberUpdate());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Get.delete<GetDataController>();
    super.dispose();
  }
}

class GetDatas {
  final Lock lock = Lock();
  static final open = ObjectBoxDatabase.indexMembers;
  static final openaR = ObjectBoxDatabase.StockCodeRangking;
  var stockcode = "ANTM";
  Future<void> getMemberUpdate() async {
    await Future.sync(
      () async => await ActivityRequest.stockGroupListRequest(
        packageId: Constans.PACKAGE_ID_STOCK_GROUP_LIST,
        clientId: "Dayat",
      ),
    );
    // // TEST LOGIN ORDER
    // await Future.sync(() async {
    //   OrderMassage.loginOrder();
    // });
    //BATAS BAWAH
    await Future.sync(() async {
      ActivityRequest.indexListRequest(
          packageId: Constans.PACKAGE_ID_INDEX_LIST);
    });

    await Future.sync(
      () async => await ActivityRequest.indexMemberListRequest(
        packageId: Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST,
        indexName: 'LQ45',
      ),
    );

    await Future.delayed(const Duration(seconds: 2), () async {
      List<String> list = [];
      for (int i = 0; i < open.getAll().first.array.length; i++) {
        await lock.synchronized(() {
          stockcode =
              open.getAll().first.array[i].stockCode.toString().toUpperCase();
          ActivityRequest.quoteRequest(
            packageId: Constans.PACKAGE_ID_QUOTES,
            commant: 1,
            arrayStockCode: [
              ArrayStockCode(stockCode: stockcode, board: 'RG'),
            ],
          );
          list.add(stockcode);
        });
      }
      var query =
          openaR.query(StockData_.reqType.equals(2)).build().findFirst();
      if (query != null) {
        if (query.arrayData.isNotEmpty) {
          for (int i = 0; i < 10; i++) {
            ActivityRequest.quoteRequest(
              packageId: Constans.PACKAGE_ID_QUOTES,
              arrayStockCode: [
                ArrayStockCode(
                  stockCode: query.arrayData[i].stockCode,
                  board: 'RG',
                ),
              ],
            );
          }
        }
      }
      return list;
    });

    await Future.sync(() {
      for (int i = 0; i < 3; i++) {
        switch (i) {
          case 0:
            ActivityRequest.stockRangkingRequest(
              packageId: Constans.PACKAGE_ID_STOCK_RANGKING,
              reqType: 1,
              board: 'RG',
              nRequest: 10,
            );
          case 1:
            ActivityRequest.stockRangkingRequest(
              packageId: Constans.PACKAGE_ID_STOCK_RANGKING,
              reqType: 8,
              board: 'RG',
              nRequest: 10,
            );
          case 2:
            ActivityRequest.stockRangkingRequest(
              packageId: Constans.PACKAGE_ID_STOCK_RANGKING,
              reqType: 6,
              board: 'RG',
              nRequest: 10,
            );
        }
      }
    });

    GetDataController getController = Get.put(GetDataController());
    getController.dispose();
  }
}

class GetDataFirst {
  final int code;
  GetDataFirst({required this.code}) {
    init();
  }

  void init() {
    try {
      switch (code) {
        case 1:
          ActivityRequest.stockListRequest(
            packageId: Constans.PACKAGE_ID_STOCK_LIST,
          );
          break;
        case 2:
          ActivityRequest.brokerListRequest(
            packageId: Constans.PACKAGE_ID_BROKER_LIST,
          );
          break;
        case 4:
          ActivityRequest.indexListRequest(
            packageId: Constans.PACKAGE_ID_INDEX_LIST,
          );
          break;
      }
    } catch (e) {
      print("ERROR: $e");
    }
  }
}
