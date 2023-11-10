import 'package:objectbox/objectbox.dart';

@Entity(uid: 0508202301)
class TempStockGroupListModel {
  @Id()
  int? id = 0;
  int? clientIdL;
  String? clientId;
  int? array;
  final arrayListTemp = ToMany<TempArrayStockGroupList>();
  TempStockGroupListModel({this.clientIdL, this.clientId, this.array});
}

@Entity(uid: 0508202302)
class TempArrayStockGroupList {
  @Id()
  int? id = 0;
  int? groupNameL;
  String? groupName;
  int? isDefault;
  TempArrayStockGroupList({this.groupNameL, this.groupName, this.isDefault});
}

// batas

@Entity(uid: 0808202301)
class TempStockGroupListMemberModel {
  @Id()
  int? id = 0;
  int? clientIdL;
  String? clientId;
  int? array1;

  final arrayList = ToMany<TempArrayOFGroupname>();

  TempStockGroupListMemberModel({this.clientIdL, this.clientId, this.array1});
}

@Entity(uid: 0808202302)
class TempArrayOFGroupname {
  @Id()
  int id;
  int? groupNameL;
  String? groupName;
  int? arraystockCD;
  final arrayListStockCD = ToMany<TempArrayOFStockCode>();
  TempArrayOFGroupname(
      {this.id = 0, this.groupNameL, this.groupName, this.arraystockCD});
}

@Entity(uid: 0808202303)
class TempArrayOFStockCode {
  @Id()
  int id;
  int? stockCL;
  String? stockC;

  TempArrayOFStockCode({this.id = 0, this.stockCL, this.stockC});
}
