import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202322)
class StockGroupListModel {
  @Id()
  int? id = 0;
  int? clientIdL;
  String? clientId;
  int? array;
  final arrayList = ToMany<ArrayStockGroupList>();
  StockGroupListModel({this.clientIdL, this.clientId, this.array});
}

@Entity(uid: 17072023323)
class ArrayStockGroupList {
  @Id()
  int? id = 0;
  int? groupNameL;
  String? groupName;
  int? isDefault;
  ArrayStockGroupList({this.groupNameL, this.groupName, this.isDefault});
}
