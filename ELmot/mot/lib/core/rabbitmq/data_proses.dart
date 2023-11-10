// ignore_for_file: avoid_print

import 'dart:typed_data';

import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'package:online_trading/module/appFileHash.pkg.dart';
import 'package:online_trading/module/broker_pkg.dart';
import 'package:online_trading/module/brokerlistfororder_pkg.dart';
import 'package:online_trading/module/daily_history_stock_summary.dart';
import 'package:online_trading/module/dailychartdata_pkg.dart';
import 'package:online_trading/module/hashkey_pkg.dart';
import 'package:online_trading/module/indexlist_pkg.dart';
import 'package:online_trading/module/indexmember_pkg.dart';
import 'package:online_trading/module/indexsubscribe_pkg.dart';
import 'package:online_trading/module/intradaychartdata_pkg.dart';
import 'package:online_trading/module/login_pkg.dart';
import 'package:online_trading/module/orderbook_pkg.dart';
import 'package:online_trading/module/packagestocklist_pkg.dart';
import 'package:online_trading/module/parameter_pkg.dart';
import 'package:online_trading/module/quotes_pkg.dart';
import 'package:online_trading/module/runningtrade_pkg.dart';
import 'package:online_trading/module/stcokgrouplistmember_pkg.dart';
import 'package:online_trading/module/stockgrouplist_pkg.dart';
import 'package:online_trading/module/stockrangking_pkg.dart';
import 'package:online_trading/module/todaytradesdata_pkg.dart';
import 'package:online_trading/module/tradebook_pkg.dart';
import 'package:online_trading/module/updatedailychart_pkg.dart';
import 'package:online_trading/module/weeklychartdata_pkg.dart';

import '../../module/dailyindexchartdatas_pkg.dart';
import '../../module/indxnews_pkg.dart';
import '../../module/monthlychartdata_pkg.dart';
import '../../module/monthlyindexchartdatas_pkg.dart';
import '../../module/weeklyindexchartdatas_pkg.dart';

Uint8List buf = Uint8List(0);
// Uint8List inpt = Uint8List(0);
String routkey = '';
int rout = 0;
getData(Uint8List inputs, String routingKEY) async {
  buf = inputs;
  routkey = routingKEY;
  int packageId = Encrypt().encrypt2(inputs, 8);
  int pos = Constans.PACKAGE_HEADER_LENGTH;
  String name = '';
  if (pos <= buf.length) {
    if (packageId != Constans.PACKAGE_ID_STOCK_RANGKING) {
      int len = Encrypt().encrypt2(inputs, pos);
      if (len < 100) {
        name = Encrypt().getAsciiString(inputs, pos + 2, len);
      }
    }
  }
  if (!name.toUpperCase().startsWith('TAG')) {
    if (Constans.PACKAGE_ID_LOGIN == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_LOGIN");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: ${name.toString()}");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_LOGIN}");
      return getLoginResponse();
    } else if (Constans.PACKAGE_ID_PIN_VALIDATE == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_PIN_VALIDATE");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_PIN_VALIDATE}");
    } else if (0x0031 == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok HASH FILE");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${0x0031}");
      return pkgAppfileHAsh(buf);
    } else if (Constans.PACKAGE_ID_STOCK_LIST == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_STOCK_LIST");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_STOCK_LIST}");

      return StockList();
    } else if (Constans.PACKAGE_ID_INDEX_LIST == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_INDEX_LIST");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_INDEX_LIST}");
      return Index();
    } else if (Constans.PACKAGE_ID_BROKER_LIST == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_BROKER_LIST");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_BROKER_LIST}");
      return replayBroker();
    } else if (Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_MEMBER_OF_INDEX_LIST");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_MEMBER_OF_INDEX_LIST}");
      return indexMember();
    } else if (Constans.PACKAGE_ID_RUNNING_TRADES == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_RUNNING_TRADES");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_RUNNING_TRADES}");
      return updateRunningTrades();
    } else if (Constans.PACKAGE_ID_INDEX == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_INDEX");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_INDEX}");
      return IndexSubscribe();
    } else if (Constans.PACKAGE_ID_QUOTES == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_QUOTES");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_QUOTES}");
      return QuotesReplay();
    } else if (Constans.PACKAGE_ID_ORDER_BOOK == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_ORDER_BOOK");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_ORDER_BOOK}");
      return updateOrder();
    } else if (Constans.PACKAGE_ID_TRADE_BOOK == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_TRADE_BOOK");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_TRADE_BOOK}");
      return TradBook();
    } else if (Constans.PACKAGE_ID_BROKER_SUMMARY == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_BROKER_SUMMARY");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_BROKER_SUMMARY}");
    } else if (Constans.PACKAGE_ID_SUMMARY_OF_FOREIGN_TRANSACTION ==
        packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_SUMMARY_OF_FOREIGN_TRANSACTION");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_SUMMARY_OF_FOREIGN_TRANSACTION}");
      // return updateSummaryofForeignTransaction();
    } else if (Constans.PACKAGE_ID_TODAY_TRADES_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_TODAY_TRADES_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_TODAY_TRADES_DATA}");
      return updateTodayTradesData();
    } else if (Constans.PACKAGE_ID_DAILY_HISTORY_STOCK_SUMMARY == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_DAILY_HISTORY_STOCK_SUMMARY");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_DAILY_HISTORY_STOCK_SUMMARY}");
      return updateDailyHistoryStockSummary();
    } else if (Constans.PACKAGE_ID_IDX_NEWS == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_IDX_NEWS");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_IDX_NEWS}");
      return updateIDXNews();
    } else if (Constans.PACKAGE_ID_DAILY_CHART_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_DAILY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_DAILY_CHART_DATA}");
      return updateDailyChartData();
    } else if (Constans.PACKAGE_ID_WEEKLY_CHART_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_WEEKLY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_WEEKLY_CHART_DATA}");
      return updateWeeklyChartData();
    } else if (Constans.PACKAGE_ID_MONTHLY_CHART_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_MONTHLY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_MONTHLY_CHART_DATA}");
      return updateMonthlyChartData();
    } else if (Constans.PACKAGE_ID_INTRADAY_CHART == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_INTRADAY_CHART");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_INTRADAY_CHART}");
      return updateIntradayChartData();
    } else if (Constans.PACKAGE_ID_REGISTER_LOGIN_ID == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_REGISTER_LOGIN_ID");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_REGISTER_LOGIN_ID}");
    } else if (Constans.PACKAGE_ID_STOCK_GROUP_LIST == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_STOCK_GROUP_LIST");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_STOCK_GROUP_LIST}");
      return updateStockGroupList();
    } else if (Constans.PACKAGE_ID_STOCK_GROUP_LIST_MEMBERS == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_STOCK_GROUP_LIST_MEMBERS");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_STOCK_GROUP_LIST_MEMBERS}");
      return updateStockGroupListMember();
    } else if (Constans.PACKAGE_ID_BROKER_LIST_FOR_ORDER == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_BROKER_LIST_FOR_ORDER");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_BROKER_LIST_FOR_ORDER}");
      return updateBrokerListForOder();
    } else if (Constans.PACKAGE_ID_AUTO_UPDATE_DAILY_CHART_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_AUTO_UPDATE_DAILY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_AUTO_UPDATE_DAILY_CHART_DATA}");
      return UpdateDailyChart();
    } else if (Constans.PACKAGE_ID_AUTO_UPDATE_WEEKLY_CHART_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_AUTO_UPDATE_WEEKLY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_AUTO_UPDATE_WEEKLY_CHART_DATA}");
      UpdateWeeklyChart();
    } else if (Constans.PACKAGE_ID_AUTO_UPDATE_MONTHLY_CHART_DATA ==
        packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_AUTO_UPDATE_MONTHLY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_AUTO_UPDATE_MONTHLY_CHART_DATA}");
    } else if (Constans.PACKAGE_ID_AUTO_UPDATE_INTRADAY_CHART_DATA ==
        packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_AUTO_UPDATE_INTRADAY_CHART_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print(
          "P_ORDER_ID: ${Constans.PACKAGE_ID_AUTO_UPDATE_INTRADAY_CHART_DATA}");
    } else if (Constans.PACKAGE_ID_DAILY_INDEX_CHART_DATAS == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_DAILY_INDEX_CHART_DATAS");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_DAILY_INDEX_CHART_DATAS}");
      return updateDailyIndexChartDatas();
    } else if (Constans.PACKAGE_ID_WEEKLY_INDEX_CHART_DATAS == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_WEEKLY_INDEX_CHART_DATAS");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_WEEKLY_INDEX_CHART_DATAS}");
      return updateWeeklyIndexChartDatas();
    } else if (Constans.PACKAGE_ID_MONTHLY_INDEX_CHART_DATAS == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_MONTHLY_INDEX_CHART_DATAS");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_MONTHLY_INDEX_CHART_DATAS}");
      return updateMonthlyIndexChartDatas();
    } else if (Constans.PACKAGE_ID_INTRADAY_INDEX_CHART_DATAS == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_INTRADAY_INDEX_CHART_DATAS");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_INTRADAY_INDEX_CHART_DATAS}");
      // return updateIntradayIndexChartDatas();
    } else if (Constans.PACKAGE_ID_HASH_KEY_MASTER_DATA == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_HASH_KEY_MASTER_DATA");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_HASH_KEY_MASTER_DATA}");
      return HashKeyPKG();
    } else if (Constans.PACKAGE_ID_STOCK_RANGKING == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_STOCK_RANGKING");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_STOCK_RANGKING}");
      return StockRangking();
    } else if (Constans.PACKAGE_ID_DATA_PARAMETER == packageId) {
      print(
          "-----------------------------------------------------------------");
      print("Ok PACKAGE_ID_DATA_PARAMETER");
      print("ROUTING_KEY: $routingKEY");
      print("ORDER_ID: $packageId");
      print("NAME: $name");
      print("P_ORDER_ID: ${Constans.PACKAGE_ID_DATA_PARAMETER}");
      return ParameterPkg();
    } else {
      print(
          "-----------------------------------------------------------------");
      print(
          "NAH NGGAK ADA PACKAGE ID YANG COCOK!!! $routingKEY, $packageId, $name");
    }
  } else {
    print("DARI YOGA DATA_PROSES.dart");
  }
}
