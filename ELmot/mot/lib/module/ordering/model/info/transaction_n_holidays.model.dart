class TransactionNHolidaysModel {
  int? reqType;
  List<ArrayRemain>? array;
}

class ArrayRemain {
  int? tradingDate;
  ArrayRemain({this.tradingDate});
}

class TransactionNHolidaysDATAModel {
  int? reqType;
  List<ArrayHolidayByDate>? array;
}

class ArrayHolidayByDate {
  int? holiday;
  String? description;
  ArrayHolidayByDate({this.holiday, this.description});
}
