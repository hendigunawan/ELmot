// ignore_for_file: non_constant_identifier_names

import 'package:dart_amqp/dart_amqp.dart';

class Constans {
//START SERVER CONSTANT
  // static String SERVER_HOST = "10.249.250.137";
  // static int SERVER_PORT = 5672;

  static String SERVER_HOST = "117.102.72.146";
  static int SERVER_PORT = 5672;
  static String ROUTING_KEY = "*.*.*";
  static int AUTO_DELETE_QUEUES = 8; //IN HOURS
//END SERVER CONSTANT

//START SETTING CONSTANS
  static int BUY_ORDER = 0;
  static int SELL_ORDER = 1;
  static int MARGIN_BUY = 2;
  static int SHORT_SELL = 3;
  static bool AMEND = true;
  static bool WITHDRAW = false;
//END SETTING CONSTANS

//START EXCHANGE
  static String EXCHANGE_NAME_REALTIME = "IDX";
  static ExchangeType EXCHANGE_TYPE_REALTIME = ExchangeType.TOPIC;
  static String EXCHANGE_NAME_REQUEST = "IDX_TASK";
  static ExchangeType EXCHANGE_TYPE_REQUEST = ExchangeType.DIRECT;
  static String EXCHANGE_NAME_ORDER = "IDX_ORDER";
  static ExchangeType EXCHANGE_TYPE_ORDER = ExchangeType.DIRECT;
  static String QUEUE_NAME_REALTIME = "";
  static String QUEUE_NAME_REQUEST = "REQUEST_QUEUE";
  static String QUEUE_NAME_ORDER = "ORDER_QUEUE";
  // static String QUEUE_NAME_ORDER = "";
//END EXCHANGE

//START DATA PROTOCOL
  static int PACKAGE_HEADER_LENGTH = 18;
  static var PKG_SIGNATURE = 2506938522;
  static var PKG_FLAG_ENCRYPTED = 0;
  static var PKG_FLAG_COMPRESSED = 1;
//END DATA PROTOCOL

//START PACKAGE ID
  static int PACKAGE_ID_LOGIN = 0x0001;
  static int PACKAGE_ID_PIN_VALIDATE = 0x0002;
  static int PACKAGE_ID_STOCK_LIST = 0x0003;
  static int PACKAGE_ID_INDEX_LIST = 0x0004;
  static int PACKAGE_ID_BROKER_LIST = 0x0005;
  static int PACKAGE_ID_MEMBER_OF_INDEX_LIST = 0x0006;
  static int PACKAGE_ID_RUNNING_TRADES = 0x0007;
  static int PACKAGE_ID_INDEX = 0x0008;
  static int PACKAGE_ID_QUOTES = 0x0009;
  static int PACKAGE_ID_ORDER_BOOK = 0x000a;
  static int PACKAGE_ID_TRADE_BOOK = 0x000b;
  static int PACKAGE_ID_BROKER_SUMMARY = 0x000c;
  static int PACKAGE_ID_SUMMARY_OF_FOREIGN_TRANSACTION = 0x000d;
  static int PACKAGE_ID_TODAY_TRADES_DATA = 0x0020;
  static int PACKAGE_ID_DAILY_HISTORY_STOCK_SUMMARY = 0x0021;
  static int PACKAGE_ID_IDX_NEWS = 0x0022;
  static int PACKAGE_ID_STOCK_GROUP_LIST = 0x0023;
  static int PACKAGE_ID_STOCK_GROUP_LIST_MEMBERS = 0x0024;
  static int PACKAGE_ID_UPDATE_STOCK_GROUP_LIST_MEMBERS = 0x0025;
  static int PACKAGE_ID_DAILY_CHART_DATA = 0x0026;
  static int PACKAGE_ID_AUTO_UPDATE_DAILY_CHART_DATA = 0x0010;
  static int PACKAGE_ID_WEEKLY_CHART_DATA = 0x0027;
  static int PACKAGE_ID_AUTO_UPDATE_WEEKLY_CHART_DATA = 0x0011;
  static int PACKAGE_ID_MONTHLY_CHART_DATA = 0x0028;
  static int PACKAGE_ID_AUTO_UPDATE_MONTHLY_CHART_DATA = 0x0012;
  static int PACKAGE_ID_INTRADAY_CHART = 0x0029;
  static int PACKAGE_ID_AUTO_UPDATE_INTRADAY_CHART = 0x0013;
  static int PACKAGE_ID_AUTO_UPDATE_INTRADAY_CHART_DATA = 0x0013; //
  static int PACKAGE_ID_REGISTER_LOGIN_ID = 0x0090;
  static int PACKAGE_ID_BROKER_LIST_FOR_ORDER = 0x0091;
  static int PACKAGE_ID_HASH_KEY_MASTER_DATA = 0x000e;

  // nambah karena belum ada line 690 di modul xlsx
  static int PACKAGE_ID_DAILY_INDEX_CHART_DATAS = 0x002a;
  static int PACKAGE_ID_WEEKLY_INDEX_CHART_DATAS = 0x002b;
  static int PACKAGE_ID_MONTHLY_INDEX_CHART_DATAS = 0x002c;
  static int PACKAGE_ID_INTRADAY_INDEX_CHART_DATAS = 0x002d;
  static int PACKAGE_ID_STOCK_RANGKING = 0x002e;
  static int LOGIN_SUCCESS = 0x0000;
  static int LOGIN_ID_NOT_FOUND = 0x0002;
  static int LOGIN_FAILED = 0x0005;
  static int DIFFERENT_DEVICE = 0x0006;
  static int PASSWORD_EXPIRED = 0x0010;
  static int LOGIN_ID_NOT_ACTIVE = 0x0016;
  static int PACKAGE_ID_DATA_PARAMETER = 0x002f;
//END PACKAGE ID

//Constans PackageId Order
  static int PACKAGE_ID_HEADER_ONLY = 0x0000;
  static int PACKAGE_ID_LOGIN_ORDER = 0x0001;
  static int PACKAGE_ID_LOGOUT_ORDER = 0x00ff;
  static int PACKAGE_ID_VALIDATE_PIN_ORDER = 0x0002;
  static int PACKAGE_ID_CHANGE_PASWORD_OR_PIN_ORDER = 0x0003;
  static int PACKAGE_ID_REQUEST_TRADING_LIMIT_ORDER = 0x0004;
  static int PACKAGE_ID_REQUEST_STOCK_BALENCE_ORDER = 0x0005;
  static int PACKAGE_ID_REQUEST_ACCOUNT_INFO_ORDER = 0x0006;
  static int PACKAGE_ID_REQUEST_REALIZED_GAID_OR_LOST_ORDER = 0x0007;
  static int PACKAGE_ID_REQUEST_TRADE_CONFIRMATION_ORDER = 0x0008;
  static int PACKAGE_ID_REQUEST_TAX_INFO_ORDER = 0x0009;
  static int PACKAGE_ID_REQUEST_PORTFOLIO_ORDER = 0x000A;
  static int PACKAGE_ID_REQUEST_PORTFOLIO_RETURN_ORDER = 0x000B;
  static int PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_INFO_ORDER = 0x000C;
  static int PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_LIST_ORDER = 0x000D;
  static int PACKAGE_ID_REQUEST_FUND_WITHDRAWAL_ORDER = 0x000E;
  static int PACKAGE_ID_CANCEL_FUND_WITHDRAWAL_ORDER = 0x000F;
  static int PACKAGE_ID_REQUEST_FINANCIAL_HISTORY_ORDER = 0x0010;
  static int PACKAGE_ID_REQUEST_CASH_LEDGER_ORDER = 0x001A;
  static int PACKAGE_ID_REQUEST_SINGLE_STOCK_BALENCE_ORDER = 0x001B;
  static int PACKAGE_ID_VALIDATE_LOGIN_PASSWORD_ORDER = 0x001C;
  static int PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_INFO_ORDER = 0x0011;
  static int PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_LIST_ORDER = 0x0012;
  static int PACKAGE_ID_REQUEST_EXERCISE_RIGH_OR_WARRANT_ORDER = 0x0013;
  static int PACKAGE_ID_CANCEL_EXERCISE_RIGH_OR_WARRANT_ORDER = 0x0014;
  static int PACKAGE_ID_REQUEST_STOCK_COLLATERAL_INFO_ORDER = 0x0015;
  static int PACKAGE_ID_REQUEST_TRANSACTION_AND_HOLIDAYS_ORDER = 0x0016;
  static int PACKAGE_ID_REQUEST_CORPORATE_ACTION_INFORMATION_ORDER = 0x0017;
  static int PACKAGE_ID_REQUEST_TRANSACTIONS_REPORT_ORDER = 0x0018;
  static int PACKAGE_ID_REQUEST_MONTHLY_BALANCE_ORDER = 0x0019;
  static int PACKAGE_ID_SPEED_ORDER_BOOK_ORDER = 0x0020;
  static int PACKAGE_ID_HEARTBIT_ORDER = 0xffff;
//END Constans PackageId Order

//PACKAGE ORDER REQUEST
  static int PACKAGE_ID_REQUEST_ORDER = 0x0080;
  static int PACKAGE_ID_REQUEST_AMEND = 0x0081;
  static int PACKAGE_ID_REQUEST_WITHDRAW = 0x0082;
  static int PACKAGE_ID_ORDER_LIST_REQUEST = 0x0083;
  static int PACKAGE_ID_TRADE_LIST_REQUEST = 0x0084;
  static int PACKAGE_ID_REQUEST_REJECTED_ORDER_MASSAGE = 0x0085;
  static int PACKAGE_ID_HISTORICAL_ORDER_LIST_REQUEST = 0x0086;
  static int PACKAGE_ID_HISTORICAL_TRADE_LIST_REQUEST = 0x0087;
  static int PACKAGE_ID_REQUEST_NEW_GTC_ORDER = 0x0088;
  static int PACKAGE_ID_REQUEST_CANCEL_GTC_ORDER = 0x0089;
  static int PACKAGE_ID_REQUEST_GTC_ORDER_LIST = 0x008a;
  static int PACKAGE_ID_REQUEST_BREAK_OERDER_LIST = 0x0090;
  static int PACKAGE_ID_REQUEST_TRAILING_ORDER_LIST = 0x0091;
  static int PACKAGE_ID_REQUEST_NEW_BREAK_OERDER = 0x008c;
  static int PACKAGE_ID_REQUEST_NEW_TRAILING_ORDER = 0x008d;
  static int PACKAGE_ID_REQUEST_CANCLE_BREAKE_ORDER = 0x008e;
  static int PACKAGE_ID_REQUEST_CANCLE_TRAILING_ORDER = 0x008f;
  static int PACKAGE_ID_REQUEST_SPEED_ORDER_AMEND = 0x0092;
  static int PACKAGE_ID_REQUEST_SPEED_ORDER_ = 0x0093;
//END PACKAGE ORDER REQUEST

//PACKAGE ORDER REALTIME
  static int PACKAGE_ID_LOGIN_REPLY_ORDER_REALTIME = 0x0040;
  static int PACKAGE_ID_NEW_ORDER_REPLY_ORDER_REALTIME = 0x0022;
  static int PACKAGE_ID_AMEND_REPLY_ORDER_REALTIME = 0x0023;
//END PACKAGE ORDER REALTIME

//Special Notif
  static String B = 'Bankruptcy filing against the company';
  static String M = 'Moratorioum of debt payment';
  static String E = 'Latest financial report showing negative equity';
  static String A =
      'Adverse opinion of the financial report from Public Accountant';
  static String D =
      'Disclaimer opinion of the financial report from Public Accountant';
  static String L = 'Late submission of financial report';
  static String S = 'Latest financial report showing no sales';
  static String C =
      'Lawsuit against Listed Company, its subsidiary, and/or member \nof Board of Directors and Board of Commissioners of Listed \nCompany which has Material impact';
  static String Q =
      'Restriction of business activity of Listed Company and/or its subsidiary by regulator';
  static String Y =
      'Listed Company has not held Annual General Meeting of \nShareholders until 6 (six) months after the end of previous year';
  static String F = 'Administrative sanction from OJK due to minor offense';
  static String G = 'Bankruptcy filing against the company';
  static String V = 'Administrative sanction from OJK due to serious offense';
  static String N =
      'Listed Company is an Issuer with Multiple Voting Shares Structure';
  static String K =
      'Stock Listed under New Economy Board, with Multiple Voting Shares (MVS)';
  static String I =
      'Stock Listed under New Economy Board, without Multiple Voting Shares (MVS)';
  static String X = 'Securities in Special Monitoring';

//START CRYPTO SETTING
  static String IV = "1F4114E9F8B1B968";
  static String ENCRYPTIONKEY = "97DF7EF6E7D71FA3";
  static String? PADDING;
//END CRYPTO SETTING

  static ConnectionSettings SETTING_CONN = ConnectionSettings(
    host: SERVER_HOST,
    port: SERVER_PORT,
    authProvider: const AmqPlainAuthenticator("user", "user"),
  );
}
