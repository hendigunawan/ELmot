import 'package:objectbox/objectbox.dart';

@Entity(uid: 170720231)
class BrokerListForOrderModel {
  @Id()
  int? id = 0;
  int? loginIdL;
  String? loginId;
  int? array;
  final arrayBrokerRequestList = ToMany<ArrayBrokerRequestData>();
  int? arrayDidalam;
  final arraydidalammm = ToMany<ArrayDiDalam>();
  BrokerListForOrderModel(
      {this.loginIdL, this.loginId, this.array, this.arrayDidalam});
}

@Entity(uid: 1707202334)
class ArrayBrokerRequestData {
  @Id()
  int? id = 0;
  int? brokerIdL;
  String? brokerID;
  int? brokerNameL;
  String? brokerName;
  ArrayBrokerRequestData({
    this.brokerIdL,
    this.brokerID,
    this.brokerNameL,
    this.brokerName,
  });
}

@Entity(uid: 1707202335)
class ArrayDiDalam {
  @Id()
  int? id = 0;
  int? accountIdL;
  String? accountId;
  int? accountNameL;
  String? accountName;
  ArrayDiDalam(
      {this.accountIdL, this.accountId, this.accountNameL, this.accountName});
}
