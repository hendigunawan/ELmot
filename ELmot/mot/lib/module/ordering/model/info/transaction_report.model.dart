class TransactionReportModelRemainYear {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;

  List<ArrayTransactionReportModelRemainYear>? array;

  TransactionReportModelRemainYear({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.array,
  });
}

class ArrayTransactionReportModelRemainYear {
  int? remainYear;
  ArrayTransactionReportModelRemainYear({this.remainYear});
}

class TransactionReportModel {
  String? loginId;
  String? reference;
  String? accountId;
  int? requestType;
  int? transactionReportPeriod;

  List<ArrayTransactionReport>? arrayTransReport;
  int? totalGrossAmount;
  int? totalBrokerFee;
  int? totalLevy;
  int? totalWht;
  int? totalVAT;
  int? totalSalesTax;
  int? totalFees;
  int? totalNetAmount;

  TransactionReportModel({
    this.loginId,
    this.reference,
    this.accountId,
    this.requestType,
    this.transactionReportPeriod,
    this.arrayTransReport,
    this.totalGrossAmount,
    this.totalBrokerFee,
    this.totalLevy,
    this.totalWht,
    this.totalVAT,
    this.totalSalesTax,
    this.totalFees,
    this.totalNetAmount,
  });
}

class ArrayTransactionReport {
  int? date;
  int? command;
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
  int? subTotalFees;
  int? netAmount;
  ArrayTransactionReport({
    this.date,
    this.command,
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
    this.subTotalFees,
    this.netAmount,
  });
}
