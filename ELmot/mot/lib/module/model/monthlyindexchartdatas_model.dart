import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202316)
class MonthlyIndexChartDatasModel {
  @Id()
  int id;
  int? indexCodeL;
  String? indexCode;
  int? command;
  int? array;
  final arraymonthlyindexchartdatasList =
      ToMany<ArrayMonthlyIndexChartDatasModel>();
  MonthlyIndexChartDatasModel(
      {this.id = 0, this.indexCodeL, this.indexCode, this.command, this.array});
}

@Entity(uid: 17072023317)
class ArrayMonthlyIndexChartDatasModel {
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

  ArrayMonthlyIndexChartDatasModel(
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
