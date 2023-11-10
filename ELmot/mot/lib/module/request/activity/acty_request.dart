import 'dart:io';

import 'package:encrypt/encrypt.dart' as ky;
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/ordering/massage/create/file_windows/request_master.massage.dart';
import 'package:online_trading/module/request/encrpty_msg.dart';
import 'package:path_provider/path_provider.dart';

class ArrayStockCode {
  String? stockCode;
  String? board;

  ArrayStockCode({this.stockCode, this.board});
}

class ActivityRequest {
  static final ControllerHandelSUB controllerHandelSUB =
      Get.put(ControllerHandelSUB());
  static final ControllerHandelREQ controllerHandelREQ =
      Get.put(ControllerHandelREQ());
  static final String clientTag = Get.find(tag: "buildClientTag");

  static loginRequest({
    required int packageId,
    required String userName,
    required String passWord,
    String? imeI = '',
    String? noPhone = '',
  }) async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String massageDirectory = '${appDirectory.path}/massage.data';
    var file = File(massageDirectory);
    Uint8List massage;
    if (!file.existsSync()) {
      massage = createLoginRequest(
        clientTag: clientTag,
        loginId: userName == "" ? "" : userName,
        loginPassword: passWord == "" ? "" : passWord,
        imei: imeI!,
        phoneNo: noPhone!,
      );
      await encriptyLogin(file, massage);
    } else {
      if (await _cekSecure() == null) return;
      String getSecure = await _cekSecure();
      Uint8List dec =
          decrptyLogin(getSecure, File(massageDirectory).readAsBytesSync());
      print(dec);
      massage = dec;
    }
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }

  static Future<dynamic> _cekSecure() async {
    const secure = FlutterSecureStorage();
    return await secure.read(key: 'Code2');
  }

  static encriptyLogin(File file, Uint8List massage) async {
    FlutterSecureStorage secure = const FlutterSecureStorage();
    String key = generateRandomCode(16);
    Uint8List encryp;
    var cek = await _cekSecure();
    if (cek != null) key = cek;
    final kyes = ky.Key.fromUtf8(key);
    final iv = ky.IV.fromUtf8(Constans.IV);
    final en = ky.Encrypter(
      ky.AES(padding: Constans.PADDING, kyes, mode: ky.AESMode.sic),
    );
    final enc = en.encryptBytes(
      massage,
      iv: iv,
    );
    encryp = enc.bytes;
    secure.write(key: 'Code2', value: key);

    file.writeAsBytesSync(
      encryp.buffer.asUint8List(encryp.offsetInBytes, encryp.length),
    );
  }

  static reqAppFileHash() {
    Uint8List massage = createreqMasterMassage();

    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static Uint8List decrptyLogin(String keys, Uint8List data) {
    final key = ky.Key.fromUtf8(keys);
    final iv = ky.IV.fromUtf8(Constans.IV);
    final en = ky.Encrypter(
      ky.AES(padding: Constans.PADDING, key),
    );
    final dec = en.decryptBytes(ky.Encrypted(data), iv: iv);
    return Uint8List.fromList(dec);
  }

  static stockListRequest({required int packageId}) {
    Uint8List massage = createStockListRequest(clientTag, packageId);
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }

  static haskeyRequest({required int packageId}) {
    Uint8List massage = CreateHashKeyRequest(clientTag, packageId);
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static heardBeats() {
    Uint8List massage = createHeartBeat();

    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static indexListRequest({required int packageId}) {
    Uint8List massage = createIndexListRequesr(clientTag, packageId);
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }

  static brokerListRequest({required int packageId}) {
    Uint8List massage = createBrokerListRequest(clientTag, packageId);
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }

  static indexMemberListRequest(
      {required int packageId, required String indexName}) {
    Uint8List massage =
        createIndexMemberListRequesr(clientTag, packageId, indexName);
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }

  static quoteRequest({
    required int packageId,
    List<ArrayStockCode>? arrayStockCode,
    int? commant = 1,
  }) {
    Uint8List massage = createQuotesRequest(
        clientTag, packageId, commant.toString(), arrayStockCode!.toList());
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey:
            "QT.${arrayStockCode[0].stockCode}.${arrayStockCode[0].board}",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static orderBookRequest({
    required int packageId,
    required String stockCode,
    required String commant,
    String board = 'RG',
  }) {
    Uint8List massage = createOrderBookRequesr(
      clientTag,
      packageId,
      stockCode,
      commant,
      board,
    );
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: "OB.$stockCode.$board",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static todayTradesDataRequest({
    required int packageId,
    required String stockCode,
    required String commant,
    String board = 'RG',
    String? starttradeId = '0',
    String? nbreq = '0',
  }) {
    Uint8List massage = createRequestTodayTradesData(
      clientTag,
      packageId,
      stockCode,
      board,
      commant,
      starttradeId!,
      nbreq!,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  // static iDXNewsRequest({required int packageId}) {
  //   Uint8List massage = createIDXNewsRequest(clientTag, packageId);
  //   controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  // }

  static subscribeRunningTradesRequest({
    required int packageId,
    List<ArrayStockCode>? arrayStockCode,
    String? commant,
  }) {
    Uint8List massage = createSubscribeRunningTradesRequest(
        packageId, clientTag, commant.toString(), arrayStockCode!.toList());
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey:
            "RT.${arrayStockCode.first.stockCode}.${arrayStockCode.first.board}",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static dailyHistoryStockSummaryRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String? commant = '0',
    String? starttradeId = '0',
    String? nbreq = '0',
  }) {
    Uint8List massage = createDailyHistoryStockSummary(
      clientTag,
      packageId,
      stockCode,
      board,
      commant!,
      starttradeId!,
      nbreq!,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static subscribeBrokerSummaryRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String command = '1',
  }) {
    Uint8List massage = createSubscribeBrokerSummary(
      clientTag,
      packageId,
      command,
      stockCode,
      board,
    );
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: "BS.$stockCode.$board",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static stockRangkingRequest({
    required int packageId,
    String board = 'RG',
    int reqType = 0,
    int nRequest = 0,
  }) {
    Uint8List massage = CreateMassageStockRangking(
      clientTag,
      packageId,
      board,
      reqType,
      nRequest,
    );
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }

  static stockGroupListRequest({
    required int packageId,
    required String clientId,
  }) {
    Uint8List massage = createRequestStockGroupList(
      clientTag,
      packageId,
      clientId,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static subscribeTradeBookRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String command = '1',
  }) {
    Uint8List massage = createSubscribeTradeBook(
        clientTag, packageId, command, stockCode, board);
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: "TB.$stockCode.$board",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static addFavoritStockRequest({
    required int packageId,
    String? clientId,
    List<String>? arraygroupname,
    List<String>? arrayStockCode,
  }) {
    Uint8List massage = CreateAddFavoritstock(
      clientTag,
      packageId,
      clientId!,
      [
        "DayatFav",
        "1",
      ],
      ["BBCA", "BBNI"],
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static dailyChartDataRequest({
    required int packageId,
    required String stockCode,
    String board = "RG",
    String command = '1',
    String starttingDate = '0',
    String nrequest = '0',
  }) {
    Uint8List massage = createRequestDailyChartData(
      clientTag,
      packageId,
      stockCode,
      board,
      command,
      starttingDate,
      nrequest,
    );
    // controllerHandelREQ.addMassage(
    //   ModelMassage(massage: massage),
    // );
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: 'DC.$stockCode.$board',
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static weeklyChartDataRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String command = '1',
    String starttingDate = '0',
    String nrequest = '0',
  }) {
    Uint8List massage = createRequestWeeklyChartData(
      clientTag,
      packageId,
      stockCode,
      board,
      command,
      starttingDate,
      nrequest,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static monthlyChartDataRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String command = '1',
    String starttingDate = '0',
    String nrequest = '0',
  }) {
    Uint8List massage = createRequestMonthlyChartData(
      clientTag,
      packageId,
      stockCode,
      board,
      command,
      starttingDate,
      nrequest,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static interdayChartDataRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String command = '1',
    String starttingDate = '0',
    String nrequest = '0',
  }) {
    Uint8List massage = createRequestIntradayChartData(
      clientTag,
      packageId,
      stockCode,
      board,
      command,
      starttingDate,
      nrequest,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static dailyIndexChartDatasRequest({
    required int packageId,
    required String indexCode,
    String command = '0',
    String starttingDate = '0',
    String nreq = '0',
  }) {
    Uint8List massage = createRequestDailyIndexChartDatas(
      clientTag,
      packageId,
      indexCode,
      command,
      starttingDate,
      nreq,
    );
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: 'IDC.$indexCode',
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static weeklyIndexChartDatasRequest({
    required int packageId,
    required String stockCode,
    required String indexCode,
    String command = '0',
    String starttingDate = '0',
    String nreq = '0',
  }) {
    Uint8List massage = createRequestweeklyIndexChartDatas(
      clientTag,
      packageId,
      indexCode,
      command,
      starttingDate,
      nreq,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static monthlyIndexChartDatasRequest({
    required int packageId,
    required String stockCode,
    required String indexCode,
    String command = '0',
    String starttingDate = '0',
    String nreq = '0',
  }) {
    Uint8List massage = createRequestmonthlyIndexChartDatas(
      clientTag,
      packageId,
      indexCode,
      command,
      starttingDate,
      nreq,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static intradayIndexChartDatasRequest({
    required int packageId,
    required String stockCode,
    required String indexCode,
    String command = '0',
    String starttingDate = '0',
    String nreq = '0',
  }) {
    Uint8List massage = createRequestintradayIndexChartDatas(
      clientTag,
      packageId,
      indexCode,
      command,
      starttingDate,
      nreq,
    );
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static summaryofForeignRequest({
    required int packageId,
    required String stockCode,
    String board = 'RG',
    String command = '0',
    String starttingDate = '0',
    String nreq = '0',
  }) {
    Uint8List massage = createSubscribeSummaryofForeignTransaction(
      clientTag,
      packageId,
      command,
      stockCode,
      board,
      starttingDate,
      nreq,
    );
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: "SF.$stockCode.$board",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static srokerListforOrderRequest({
    required int packageId,
    required String clientId,
  }) {
    Uint8List massage =
        createBrokerListforOrderRequest(clientTag, packageId, clientId);
    controllerHandelREQ.addMassage(
      ModelMassage(massage: massage),
    );
  }

  static indexRequest({
    required int packageId,
    List<String>? arrayIndexCode,
    String? commant,
  }) {
    Uint8List massage = createsubscribeIndexRequest(
        clientTag, packageId, commant.toString(), arrayIndexCode!.toList());
    controllerHandelSUB.addOrUpdateToSubList(
      ModelSUB(
        routingKey: "ID.${arrayIndexCode.single}",
        massage: ModelMassage(massage: massage),
      ),
    );
  }

  static parameterRequest({required int requestFlag}) {
    Uint8List massage = createParameterRequest(clientTag, requestFlag);
    controllerHandelREQ.addMassage(ModelMassage(massage: massage));
  }
}
