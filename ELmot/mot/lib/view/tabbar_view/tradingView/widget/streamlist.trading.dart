import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/view/tabbar_view/tradingView/controller/runningtrade.controller.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';

class StreamRunningTrades extends StatelessWidget {
  StreamRunningTrades({super.key, this.query});
  final String? query;
  final getRunning = Get.put(RunningTradeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: getRunning.list.isEmpty ? 0 : getRunning.list.length,
        itemBuilder: (conetxt, index) {
          List<RunningTrades> data = getRunning.list.reversed.toList();
          return SizedBox(
            height: Get.height * 0.1,
            child: ListTile(
              style: ListTileStyle.list,
              textColor: Colors.white,
              title: Text(data[index].stockCode!),
              leading: Text(
                formatJam(data[index].lastTradedTime!.toString()),
              ),
              trailing: SizedBox(
                width: Get.width * 0.50,
                height: Get.height * 0.9,
                child: Row(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.242,
                          child: Row(
                            children: [
                              const Text(
                                'Last',
                                style: TextStyle(fontSize: 19),
                              ),
                              const Spacer(),
                              Text(
                                formattaCurrun(data[index].lastPrice!),
                                style: const TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.242,
                          child: const Row(
                            children: [
                              Text(
                                'a',
                                style: TextStyle(fontSize: 19),
                              ),
                              Spacer(),
                              Text(
                                'a',
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        SizedBox(
                          width: Get.width * 0.242,
                          child: const Row(
                            children: [
                              Text(
                                'a',
                                style: TextStyle(fontSize: 19),
                              ),
                              Spacer(),
                              Text(
                                'a',
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.242,
                          child: const Row(
                            children: [
                              Text(
                                'a',
                                style: TextStyle(fontSize: 19),
                              ),
                              Spacer(),
                              Text(
                                'a',
                                style: TextStyle(fontSize: 19),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}

Stream<List<RunningTrades>> streamData({String? query}) {
  return query == null
      ? ObjectBoxDatabase.runningTradeRealtime()
      : ObjectBoxDatabase.runningTradeRealtimeWithQuery(query);
}

String formatJam(String data) {
  if (data.length != 6) {
    data = '0$data';
  }

  if (data.length < 5) {
    return 'DATA JAM: ${data.length}& $data';
  }

  var hour = int.parse(data.substring(0, 2));
  var minute = int.parse(data.substring(2, 4));
  var second = int.parse(data.substring(4, 6));

  var format = DateFormat('HH:mm:ss');
  var dummyDateTime = DateTime(
    2000,
    1,
    1,
    hour,
    minute,
    second,
  ); // Menggunakan tanggal fiktif
  var hasil = format.format(dummyDateTime);
  return hasil;
}
