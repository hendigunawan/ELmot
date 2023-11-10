import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202332)
class WeeklyIndexChartDatasModel {
  @Id()
  int id;
  int? indexCodeL;
  String? indexCode;
  int? command;
  int? array;

  final arrayweeklyindexchartdatasList =
      ToMany<ArrayWeeklyIndexChartDatasModel>();
  WeeklyIndexChartDatasModel(
      {this.id = 0, this.indexCodeL, this.indexCode, this.command, this.array});
}

@Entity(uid: 1707202333)
class ArrayWeeklyIndexChartDatasModel {
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

  ArrayWeeklyIndexChartDatasModel(
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
