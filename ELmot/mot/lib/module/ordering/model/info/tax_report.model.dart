class TaxReportData {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;

  List<TaxReportArrayList>? taxReportArrayy;

  TaxReportData({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.taxReportArrayy,
  });
}

class TaxReportArrayList {
  int? taxReportYearlist;
  TaxReportArrayList({this.taxReportYearlist});
}

class TaxReportDataBYYear {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;
  int? taxReportYear;
  List<ArrayTaxReportDataBYYear>? taxReportArrayybyyear;
  int? totalGrossAmount;
  int? totalBrokerFee;
  int? totalLevy;
  int? totalWht;
  int? totalVAT;
  int? totalSalesTax;
  int? totalNetAmount;

  TaxReportDataBYYear({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.taxReportYear,
    this.taxReportArrayybyyear,
    this.totalGrossAmount,
    this.totalBrokerFee,
    this.totalLevy,
    this.totalWht,
    this.totalVAT,
    this.totalSalesTax,
    this.totalNetAmount,
  });
}

class ArrayTaxReportDataBYYear {
  int? date;
  String? board;
  String? productStockCode;
  int? price;
  int? qty;
  int? grossAmount;
  int? brokerFee;
  int? levy;
  int? wht;
  int? vat;
  int? salesTax;
  int? netAmount;

  ArrayTaxReportDataBYYear({
    this.date,
    this.board,
    this.productStockCode,
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
