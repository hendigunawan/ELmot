class TradeConfirmationRemainDate {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;
  List<ArrayTradeConfirmationRemainDate>? array;
  TradeConfirmationRemainDate({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.array,
  });
}

class ArrayTradeConfirmationRemainDate {
  int? tcDateList;
  ArrayTradeConfirmationRemainDate({this.tcDateList});
}

class TradeConfirmationBYDATE {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;
  int? tcDate;
  List<ArrayCountPertama>? arraycountpertama;
  int? totalGrossAmount;
  int? totalBrokerFee;
  int? totalLevy;
  int? totalWht;
  int? totalVAT;
  int? totalNetAmount;
  List<ArrayCountSell>? arraycountkedua;
  int? totalGrossAmountAR2;
  int? totalBrokerFeeAR2;
  int? totalLevyAR2;
  int? totalWhtAR2;
  int? totalVATAR2;
  int? totalSalesTaxAR2;
  int? totalNetAmountAR2;
  int? netPurchaseSELL;
  int? grandtotalBrokerFEE;
  int? grandtotalLevy;
  int? grandtotalWHT;
  int? grandtotalVAT;
  int? salesTax;
  int? grandTotal;
  int? otherFee;
}

class ArrayCountPertama {
  String? stockcode;
  int? price;
  int? qty;
  int? grossAmount;
  int? brokerFee;
  int? levy;
  int? wht;
  int? vat;
  int? netAmount;
  ArrayCountPertama({
    this.stockcode,
    this.price,
    this.qty,
    this.grossAmount,
    this.brokerFee,
    this.levy,
    this.wht,
    this.vat,
    this.netAmount,
  });
}

class ArrayCountSell {
  String? stockcode;
  int? price;
  int? qty;
  int? grossAmount;
  int? brokerFee;
  int? levy;
  int? wht;
  int? vat;
  int? salesTax;
  int? netAmount;
  ArrayCountSell({
    this.stockcode,
    this.price,
    this.qty,
    this.grossAmount,
    this.brokerFee,
    this.levy,
    this.wht,
    this.vat,
    this.salesTax,
    this.netAmount,
  });
}
