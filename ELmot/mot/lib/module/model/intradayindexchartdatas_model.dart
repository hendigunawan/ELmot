import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202311)
class IntradayIndexChartDatasModel {
  @Id()
  int id = 0;
  int? indexCodeL;
  String? indexCode;
  int? command;
  int? array;
  final arrayintradayindexchartdatasList =
      ToMany<ArrayIntradayIndexChartDatasModel>();
  IntradayIndexChartDatasModel(
      {this.indexCodeL, this.indexCode, this.command, this.array});
}

@Entity(uid: 17072023312)
class ArrayIntradayIndexChartDatasModel {
  @Id()
  int id = 0;
  int? date;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? freq;
  int? volume;
  int? value;

  ArrayIntradayIndexChartDatasModel(
      {this.date,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.closePrice,
      this.freq,
      this.value,
      this.volume});
}
