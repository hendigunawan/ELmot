import 'dart:async';
import 'dart:typed_data';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/heart_bit.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/header_pkg.dart';
import 'package:online_trading/module/ordering/irigasi/header_order.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:synchronized/synchronized.dart';
// import 'package:synchronized/synchronized.dart';

class ConnectionsController extends GetxService {
  // final Lock _lock = Lock();
  final int reconnectDelayInSeconds = 5;
  static int percobaanConnect = 0;
  static final int _autoDeleteQueues = Constans.AUTO_DELETE_QUEUES;
  static late Client _clients;
  static late Channel _channelsReq;
  static late Channel _channelsReal;
  static late Channel _channelsOrder;
  static late Exchange _exchangeReq;
  static late Exchange _exchangeReal;
  static late Exchange _exchangeOrders;
  static late Queue _queueReq;
  static late Queue _queueReal;
  static String queueRealName = '';
  static String queueOrderName = '';
  static String queueReqName = '';
  static late Queue _queueOrders;
  RxBool onErrors = false.obs;
  RxBool onFirst = false.obs;
  RxBool onReadys = false.obs;

  // @override
  // void onInit() async {
  //   super.onInit();
  //   _lock.synchronized(() async => await initializeConnections());
  // }

  Future<void> initializeConnections() async {
    try {
      for (int i = 0; i < 10; i++) {
        try {
          await _handleConnection(i);
        } catch (e) {
          _handleError();
          break;
        }
      }
    } catch (e) {
      print(e);
      await Future.delayed(
        Duration(seconds: reconnectDelayInSeconds),
        initializeConnections,
      );
    }
  }

  Future<void> _handleConnection(int index) async {
    switch (index) {
      case 0:
        _clients = await _handleRequest(client);
        break;
      case 1:
        _channelsReq = await _handleRequest(channel);
        break;
      case 2:
        _channelsReal = await _handleRequest(channelRealtime);
        break;
      case 3:
        _exchangeReq = await _handleRequest(exchangeRequest);
        break;
      case 4:
        _exchangeReal = await _handleRequest(exchangeRealTime);
        break;
      case 5:
        _queueReq = await _handleRequest(queueRequest);
        break;
      case 6:
        _queueReal = await _handleRequest(queueRealTime);
        break;
      case 7:
        _channelsOrder = await _handleRequest(channelOrder);
        break;
      case 8:
        _exchangeOrders = await _handleRequest(exchangeOrder);
        break;
      case 9:
        _queueOrders = await _handleRequest(queueOrder);
        _handleFinalActions();
        break;
    }
  }

  Future<dynamic> _handleRequest(Function requestFunction) async {
    return await requestFunction();
  }

  void _handleError() {
    if (!onFirst.value) {
      onFirst.toggle();
      onErrors.toggle();
    }

    if (onFirst.value) {
      Future.delayed(const Duration(milliseconds: 10), initializeConnections);
    } else {
      initializeConnections();
    }

    if (onReadys.value) {
      onReadys.toggle();
    }
  }

  void _handleFinalActions() {
    if (onFirst.value && onErrors.value) {
      onErrors.toggle();
    }
    onFirst.toggle();
    if (onReadys.value == false) onReadys.toggle();
    print('connection ready'.toUpperCase());
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  bool onError() {
    return onErrors.value;
  }

  Channel get channelsReq {
    return _channelsReq;
  }

  Channel get channelsReal {
    return _channelsReal;
  }

  Channel get channelsOrder {
    return _channelsOrder;
  }

  Exchange get exchangeReq {
    return _exchangeReq;
  }

  Exchange get exchangeReal {
    return _exchangeReal;
  }

  Exchange get exchangeOrders {
    return _exchangeOrders;
  }

  Queue get queueReq {
    return _queueReq;
  }

  Queue get queueReal {
    return _queueReal;
  }

  Queue get queueOrders {
    return _queueOrders;
  }

  dynamic client() {
    try {
      Client connections = Client(settings: Constans.SETTING_CONN);
      return connections;
    } catch (e) {
      return null;
    }
  }

  dynamic channel() async {
    try {
      Client getClient = _clients;

      Channel buildChannel = await getClient.channel();

      return buildChannel;
    } catch (e) {
      return null;
    }
  }

  dynamic channelRealtime() async {
    try {
      Client getClient = _clients;

      Channel buildChannel = await getClient.channel();

      return buildChannel;
    } catch (e) {
      return null;
    }
  }

  dynamic channelOrder() async {
    try {
      Client getClient = _clients;

      Channel buildChannel = await getClient.channel();

      return buildChannel;
    } catch (e) {
      return null;
    }
  }

  dynamic exchangeRequest() async {
    try {
      Channel getChannel = channelsReq;

      Exchange buildExchange = await getChannel.exchange(
          Constans.EXCHANGE_NAME_REQUEST, Constans.EXCHANGE_TYPE_REQUEST);

      return buildExchange;
    } catch (e) {
      if (percobaanConnect % 5 == 0) {
        NotifikasiPopup.showFAILED(
          "Unable to connect to the server. Please check your internet connection or contact customer service.",
        );
      }
      return null;
    }
  }

  dynamic exchangeRealTime() async {
    try {
      Channel getChannel = channelsReal;

      Exchange buildExchange = await getChannel.exchange(
          Constans.EXCHANGE_NAME_REALTIME, Constans.EXCHANGE_TYPE_REALTIME);

      return buildExchange;
    } catch (e) {
      return null;
    }
  }

  dynamic exchangeOrder() async {
    try {
      Channel getChannel = channelsOrder;

      Exchange buildExchange = await getChannel.exchange(
          Constans.EXCHANGE_NAME_ORDER, Constans.EXCHANGE_TYPE_ORDER);

      return buildExchange;
    } catch (e) {
      return null;
    }
  }

  dynamic queueRequest() async {
    try {
      Channel getChannel = channelsReq;
      Exchange getExchange = exchangeReq;
      String getClientTag = Get.find(tag: "buildClientTag");
      Map<String, Object> arguments = {
        "x-max-length": 100, // Maksimum panjang antrian (100 pesan).
        "x-message-ttl": Duration(hours: _autoDeleteQueues).inMilliseconds,
        "x-expires": Duration(hours: _autoDeleteQueues).inMilliseconds,
      };

      Queue buildQueue = await getChannel.queue(
        autoDelete: true,
        getClientTag,
        arguments: arguments,
      );
      Queue bindQueue = await buildQueue.bind(getExchange, getClientTag);

      return bindQueue;
    } catch (e) {
      return null;
    }
  }

  void deletequeueReq() {
    Queue queue = queueReq;
    queue.delete();
  }

  dynamic queueRealTime() async {
    try {
      Channel getChannel = channelsReal;
      String getClientTag = Get.find(tag: "buildClientTag");
      Map<String, Object> arguments = {
        "x-max-length": 100, // Maksimum panjang antrian (100 pesan).
        "x-message-ttl": Duration(hours: _autoDeleteQueues).inMilliseconds,
        "x-expires": Duration(hours: _autoDeleteQueues).inMilliseconds,
      };

      Queue buildQueue = await getChannel.queue(
        autoDelete: true,
        queueRealName == '' ? '$getClientTag.REALTIME' : queueRealName,
        arguments: arguments,
      );
      queueRealName = buildQueue.name;

      return buildQueue;
    } catch (e) {
      return null;
    }
  }

  void deletequeueOrder() {
    Queue queue = queueOrders;
    queue.delete();
  }

  dynamic queueOrder() async {
    try {
      Channel getChannel = channelsOrder;
      Exchange getExchange = exchangeOrders;
      Map<String, Object> arguments = {
        "x-max-length": 100, // Maksimum panjang antrian (100 pesan).
        "x-message-ttl": Duration(hours: _autoDeleteQueues).inMilliseconds,
        "x-expires": Duration(hours: _autoDeleteQueues).inMilliseconds,
      };
      String getClientTag = Get.find(tag: "buildClientTag");

      Queue buildQueue = await getChannel.queue(
        '$getClientTag.ORDER',
        autoDelete: true,
        arguments: arguments,
      );
      Queue bindQueue = await buildQueue.bind(getExchange, buildQueue.name);

      return bindQueue;
    } catch (e) {
      return null;
    }
  }
}

class HendelConsume {
  static consumeRequest() async {
    ConnectionsController getConnectionsController = Get.find();
    try {
      Queue getQueue = getConnectionsController.queueReq;
      await getQueue
          .consume(
            consumerTag: getQueue.name,
            noAck: true,
          )
          .then(
            (consumer) async => consumer.listen(
              (M) {
                Uint8List UI = Uint8List.view(M.payload!.buffer);
                if (M.payload!.isEmpty ||
                    M.routingKey!.endsWith('..') ||
                    M.payload!.length < 18) {
                  print('DARI YOGA CONNACT_SERVER.dart');
                } else {
                  PackageHeaders(buf: UI, routingKey: M.routingKey.toString());
                }
              },
            ),
          );
    } catch (e) {
      print('HendelConsume: $e');
      // getConnectionsController.initializeConnections();
    }
  }
}

class HendelConsumeOrder {
  static consumeOrder() async {
    ConnectionsController getConnectionsController = Get.find();
    final getHeart = Get.put(HeartLove());
    getHeart.timestampStart = DateTime.now().obs;
    getHeart.timestampStart!.refresh();

    if (getConnectionsController.onReadys.value == false) return;
    try {
      Queue getQueue = getConnectionsController.queueOrders;

      await getQueue
          .consume(
            consumerTag: getQueue.name,
          )
          .then(
            (consumer) async => consumer.listen(
              (M) {
                Uint8List UI = Uint8List.view(M.payload!.buffer);
                if (M.payload!.isEmpty ||
                    M.routingKey!.endsWith('..') ||
                    M.payload!.length < 18) {
                  print('DARI YOGA CONNACT_SERVER.dart');
                } else {
                  print('ORder'.toUpperCase());
                  PackageHeadersOrder(
                    buf: UI,
                    routingKey: M.routingKey.toString(),
                  );
                }
              },
            ),
          );
    } catch (e) {
      print('HendelConsume: $e');
      // getConnectionsController.initializeConnections();
    }
  }
}

class ControllerHandelREQ extends GetxService {
  final massagess = ModelMassage().obs;
  ConnectionsController getConnectionsController =
      Get.find<ConnectionsController>();
  RxBool getStatus = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(massagess, (callback) => hanndelRequest(callback.massage!));
  }

  void addMassage(ModelMassage massage) {
    massagess.update((val) {
      val!.massage = massage.massage;
    });
  }

  void hanndelRequest(Uint8List massage) async {
    if (getConnectionsController.onReadys.value == false) return;
    try {
      Exchange exchange = getConnectionsController.exchangeReq;
      exchange.publish(massage, Constans.QUEUE_NAME_REQUEST);
      if (getStatus.value == true) {
        HendelConsume.consumeRequest();
        getStatus.toggle();
      }
      // HendelConsume.consumeRequest();
    } catch (e) {
      print("ERROR DI REQ $e");
      // getConnectionsController.onReadys.value = false;
      // getConnectionsController.onReadys.refresh();
      // getConnectionsController.initializeConnections();
      if (getStatus.value == false) {
        getStatus.toggle();
      }
    }
  }
}

class ControllerHandelOrder extends GetxService {
  final massagess = ModelMassage().obs;
  ConnectionsController getConnectionsController =
      Get.find<ConnectionsController>();
  RxBool getStatus = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    ever(massagess, (callback) => handelOrder(callback.massage!));
  }

  void addMassage(ModelMassage massage) {
    massagess.update((val) {
      val!.massage = massage.massage;
    });
  }

  void handelOrder(Uint8List massage) async {
    if (getConnectionsController.onReadys.value == false) return;
    try {
      Exchange exchange = getConnectionsController.exchangeOrders;
      exchange.publish(massage, Constans.QUEUE_NAME_ORDER);
      if (getStatus.value == true) {
        HendelConsumeOrder.consumeOrder();
        getStatus.toggle();
      }
      // HendelConsume.consumeRequest();
    } catch (e) {
      print("ERROR DI REQ $e");
      // getConnectionsController.onReadys.value = false;
      // getConnectionsController.onReadys.refresh();
      // getConnectionsController.initializeConnections();
      if (getStatus.value == false) {
        getStatus.toggle();
      }
    }
  }
}

class ModelMassage {
  Uint8List? massage;
  ModelMassage({this.massage});
}

class ControllerHandelSUB extends GetxService {
  static late Queue save;
  RxBool saved = false.obs;
  RxList<ModelSUB> listSub = <ModelSUB>[].obs;
  ConnectionsController getConnectionsController = Get.find();
  final getRequest = Get.put(ControllerHandelREQ());

  void addOrUpdateToSubList(ModelSUB model) async {
    while (true) {
      try {
        // if (getConnectionsController.onReadys.value == false) return;
        if (getConnectionsController.onReadys.value == true) {
          Queue getQueueRealtime = getConnectionsController.queueReal;
          Exchange getExchangeRealtime = getConnectionsController.exchangeReal;

          if (saved.value == false) {
            saved.toggle();
            save = getQueueRealtime;
            await save.bind(getExchangeRealtime, model.routingKey!);
          } else {
            await save.bind(getExchangeRealtime, model.routingKey!);
          }

          Consumer consumer = await save.consume(
            noAck: true,
          );
          consumer.listen(
            (AmqpMessage M) {
              print(M.routingKey);
              Uint8List UI = Uint8List.view(M.payload!.buffer);
              if (M.payload!.isEmpty ||
                  M.routingKey!.endsWith('..') ||
                  M.payload!.length < 18) {
                print('DARI YOGA CONNACT_SERVER.dart');
              } else {
                PackageHeaders(buf: UI, routingKey: M.routingKey.toString());
              }
            },
          );
          if (model.massage != null) getRequest.addMassage(model.massage!);
          listSub.add(model);
        }
        break;
      } catch (e) {
        print("ERROR DI SUB $e");
        // listSub.clear();
        // getConnectionsController.onReadys.value = false;
        // getConnectionsController.onReadys.refresh();
        // getConnectionsController.onInit();
        saved.value = false;
        await Future.delayed(Duration(seconds: 1));
      }
    }
  }

  void unBind() async {
    // Queue getQueueRealtime = getConnectionsController.queueReal;
    Exchange getExchangeRealtime = getConnectionsController.exchangeReal;
    try {
      Lock().synchronized(
        () {
          for (int i = 0; i < listSub.length; i++) {
            save.unbind(getExchangeRealtime, listSub[i].routingKey!);
          }
        },
      );
      listSub.clear();
    } catch (e) {
      print("ERROR DI UNBIND $e");
      // getConnectionsController.onReadys.value = false;
      // getConnectionsController.onReadys.refresh();
      // getConnectionsController.initializeConnections();
    }
  }

  void deleteQueuewhenClose() {
    Queue queue = save;
    // getConnectionsController.channelsOrder.close();
    // getConnectionsController.channelsReal.close();
    // getConnectionsController.channelsReq.close();
    queue.delete();
    saved.toggle();
  }
}

class ModelSUB {
  String? routingKey;
  int? status; //Automatis
  bool? isRun; //Automatis atau dipakai setiap pop jadi false
  ModelMassage? massage;
  ModelSUB({this.routingKey, this.isRun, this.status = 0, this.massage});
}
