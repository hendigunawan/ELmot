import 'package:objectbox/objectbox.dart';

@Entity(uid: 170720234)
class DailyIndexChartDatasModel {
  @Id()
  int id;
  int? indexCodeL;
  String? indexCode;
  int? command;
  int? array;
  final arraydailyindexchartdatasList =
      ToMany<ArrayDailyIndexChartDatasModel>();
  DailyIndexChartDatasModel(
      {this.id = 0, this.indexCodeL, this.indexCode, this.command, this.array});
}

@Entity(uid: 1707202338)
class ArrayDailyIndexChartDatasModel {
  @Id()
  int id;
  int? date;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? freq;
  int? volume;
  int? value;

  ArrayDailyIndexChartDatasModel(
      {this.id = 0,
      this.date,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.closePrice,
      this.freq,
      this.value,
      this.volume});
}

class UpdateStockDataIndex {
  String? indexCode;
  int? len;
  int? date;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? freq;
  int? volume;
  int? value;

  UpdateStockDataIndex({
    this.indexCode,
    this.len,
    this.date,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.closePrice,
    this.freq,
    this.volume,
    this.value,
  });
}
