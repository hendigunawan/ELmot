class BreakOrderList {
  String? loginId;
  String? reference;
  String? custId;
  List<ArrayBreakOrderList>? array;
}

class ArrayBreakOrderList {
  String? orderId;
  int? command;
  String? board;
  String? stockCode;
  int? price;
  int? volume;
  int? autoPriceStep;
  int? priceType;
  int? priceCriteria;
  int? targetPrice;
  int? volumeType;
  int? volumeCriteria;
  int? targetVol;
  int? orderstatus;
  int? orderDate;
  int? orderTime;
  int? sendDate;
  int? sendTime;
  int? startDate;
  int? dueDate;
  int? sourceId;
  int? withdrawsourceId;
  String? inputUser;
  String? withdrawBy;
  String? description;
  String? clinetIpAddress;
  String? resultNote;
}
