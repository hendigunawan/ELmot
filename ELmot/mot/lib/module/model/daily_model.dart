class DailyModel {
  int? stockCodeL;
  String? stockCode;
  int? boardL;
  String? board;
  int? date;
  int? openPrice;
  int? highPrice;
  int? lowPrice;
  int? closePrice;
  int? freq;
  int? volume;
  int? value;

  DailyModel({
    this.stockCodeL,
    this.stockCode,
    this.boardL,
    this.board,
    this.date,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.closePrice,
    this.freq,
    this.volume,
    this.value,
  });

  DailyModel.fromJson(Map<String, dynamic> json) {
    stockCodeL = json["stockCodeL"];
    stockCode = json["stockCode"];
    boardL = json["boardL"];
    board = json["board"];
    date = json["date"];
    openPrice = json["openPrice"];
    highPrice = json["highPrice"];
    lowPrice = json["lowPrice"];
    closePrice = json["closePrice"];
    freq = json["freq"];
    volume = json["volume"];
    value = json["value"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["stockCodeL"] = stockCodeL;
    data["stockCode"] = stockCode;
    data["boardL"] = boardL;
    data["board"] = board;
    data["date"] = date;
    data["openPrice"] = openPrice;
    data["highPrice"] = highPrice;
    data["lowPrice"] = lowPrice;
    data["closePrice"] = closePrice;
    data["freq"] = freq;
    data["volume"] = volume;
    data["value"] = value;
    print("DATA DAILY: $data");
    return data;
  }
}
