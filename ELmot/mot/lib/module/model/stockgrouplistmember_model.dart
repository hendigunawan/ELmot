import 'package:objectbox/objectbox.dart';

@Entity(uid: 2907202301)
class StockGroupListMemberModel {
  @Id()
  int? id = 0;
  int? clientIdL;
  String? clientId;
  int? array1;

  final arrayList = ToMany<ArrayOFGroupname>();

  StockGroupListMemberModel({this.clientIdL, this.clientId, this.array1});
}

@Entity(uid: 2907202302)
class ArrayOFGroupname {
  @Id()
  int id;
  int? groupNameL;
  String? groupName;
  int? arraystockCD;
  final arrayListStockCD = ToMany<ArrayOFStockCode>();
  ArrayOFGroupname(
      {this.id = 0, this.groupNameL, this.groupName, this.arraystockCD});
}

@Entity(uid: 2907202303)
class ArrayOFStockCode {
  @Id()
  int id;
  int? stockCL;
  String? stockC;

  ArrayOFStockCode({this.id = 0, this.stockCL, this.stockC});
}
