import 'package:online_trading/module/model/packagestocklist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

final object = ObjectBoxDatabase.stockList;

PackageStockList getInformationStock(String stockcode) {
  PackageStockList data = PackageStockList();
  final query = object
      .query(PackageStockList_.stcokCode.contains(stockcode))
      .build()
      .find();
  data = query.first;

  return data;
}

StringBuffer getSpesialNotifier(String stockcode) {
  String getSN = getInformationStock(stockcode).remake2.toString();
  String spesialNotifier = getSN.substring(19, 30);
  List<String> fragments = spesialNotifier.split('-');
  final buffer = StringBuffer();
  for (String fragment in fragments) {
    if (fragment != "-") {
      buffer.write(fragment);
    }
  }
  return buffer;
}
