import 'package:objectbox/objectbox.dart';

@Entity()
class PackageStockList {
  @Id()
  int id = 0;
  int? stockCodeL;
  String? stcokCode;
  int? stockNameL;
  String? stockName;
  int? instrumenL;
  String? instrumen;
  int? remake2L;
  String? remake2;
  int? sector;

  PackageStockList({
    this.stockCodeL,
    this.stcokCode,
    this.stockNameL,
    this.stockName,
    this.instrumenL,
    this.instrumen,
    this.remake2L,
    this.remake2,
    this.sector,
  });
}
