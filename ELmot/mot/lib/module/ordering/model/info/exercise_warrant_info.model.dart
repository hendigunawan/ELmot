class ExerciseWarrantInfo {
  String? loginId;
  String? reference;
  String? accountId;
  int? t0Date;
  int? t0Cash;
  int? t1Date;
  int? t1Cash;
  int? t2Date;
  int? t2Cash;
  int? t3Date;
  int? t3Cash;
  List<ArrayInfoWarrant>? array;
}

class ArrayInfoWarrant {
  String? stockCode;
  int? exercisePrice;
  int? volumeBalance;
  int? oldShares;
  int? newShares;
  int? exerciseDateBegin;
  int? exerciseDateEnd;
}
