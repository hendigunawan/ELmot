// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:online_trading/module/model/PERCOBAANMODEL.dart';

import 'package:online_trading/module/model/dailychartdata_model.dart';
import 'package:online_trading/module/model/dailyindexchartdatas_model.dart';
import 'package:online_trading/module/model/favoritelocal_model.dart';
import 'package:online_trading/module/model/index_model.dart';
import 'package:online_trading/module/model/indexlist_model.dart';
import 'package:online_trading/module/model/indexmember_model.dart';
import 'package:online_trading/module/model/intradaychartdata_model.dart';
import 'package:online_trading/module/model/loginrply_package.dart';
import 'package:online_trading/module/model/monthlychartdata_model.dart';
import 'package:online_trading/module/model/orderbook_model.dart';
import 'package:online_trading/module/model/packagestocklist_model.dart';
import 'package:online_trading/module/model/quotes_model.dart';
import 'package:online_trading/module/model/rangkingstock_model.dart';
import 'package:online_trading/module/model/runningtrades_model.dart';
import 'package:online_trading/module/model/stockgrouplist_model.dart';
import 'package:online_trading/module/model/temp_stockgrouplist_model.dart';
import 'package:online_trading/module/model/todaytrades_model.dart';
import 'package:online_trading/module/model/tradebook_model.dart';
import 'package:online_trading/module/model/weeklychartdata_model.dart';
import 'package:online_trading/module/objectbox/model/objectbox_model.dart';

import '../../../objectbox.g.dart';
import '../../model/daily_history_stock_summary.dart';

// late Store _store;
// late Box<loginObject> _loginBox;

class ObjectBoxDatabase {
  static late Store _store;

  static late Box<InfoMobile> _InfoMobile;
  static late Box<loginObject> _loginBox;
  static late Box<OrderBook> _oerderbook;
  static late Box<DailyHistoryStockSummaryDataModel> _dailyhistorystocksummary;
  static late Box<IndexMember> _indexMember;
  static late Box<PackageStockList> _stockList;
  static late Box<Quotes> _quotes;
  static late Box<HashKey> _hashKey;
  static late Directory appDirectory;
  static late Box<TodayTradesDataModel> _today;

  static late Box<IndexModelS> _indexAja;
  static late Box<TradeBookModel> _tradeBook;
  static late Box<RunningTrades> _runningTrade;
  static late Box<StockGroupListModel> _stockGroupList;
  static late Box<PERCOBAAN> _PERCOBAAN;
  static late Box<TempStockGroupListModel> _TempStockGroupListModel;
  static late Box<TempStockGroupListMemberModel> _TempStockGroupListMemberModel;
  static late Box<TempArrayOFGroupname> _TempListMemberModel;
  static late Box<IndexListTop45> _indexListTop45;
  static late Box<StockData> _stockDataRangking;
  static late Box<FavoriteLoacalH> _favoriteLocalH;
  static late Box<FavoriteLoacalB> _favoriteLocalB;
  static late Box<FavoriteLocalM> _favoriteLocalM;
  static late Box<DailyIndexChartDatasModel> _dailyChartIndex;
  static late Box<DailyChartDataModel> _dailyChartData;
  static late Box<WeeklyChartDataModel> _weeklyChartData;
  static late Box<MonthlyChartDataModel> _monthlyChartData;
  static late Box<IntradayChartDataModel> _intradayChartData;
  static Future<void> init(Store store) async {
    _store = store;
    _InfoMobile = Box<InfoMobile>(store);
    _loginBox = Box<loginObject>(store);
    _oerderbook = Box<OrderBook>(store);
    _indexMember = Box<IndexMember>(store);
    _today = Box<TodayTradesDataModel>(store);
    _stockList = Box<PackageStockList>(store);
    _quotes = Box<Quotes>(store);
    _hashKey = Box<HashKey>(store);

    _dailyhistorystocksummary = Box<DailyHistoryStockSummaryDataModel>(store);
    _indexAja = Box<IndexModelS>(store);
    _tradeBook = Box<TradeBookModel>(store);
    _runningTrade = Box<RunningTrades>(store);
    _stockGroupList = Box<StockGroupListModel>(store);
    _PERCOBAAN = Box<PERCOBAAN>(store);
    _TempStockGroupListModel = Box<TempStockGroupListModel>(store);
    _TempStockGroupListMemberModel = Box<TempStockGroupListMemberModel>(store);
    _TempListMemberModel = Box<TempArrayOFGroupname>(store);
    _indexListTop45 = Box<IndexListTop45>(store);
    _stockDataRangking = Box<StockData>(store);
    _favoriteLocalH = Box<FavoriteLoacalH>(store);
    _favoriteLocalB = Box<FavoriteLoacalB>(store);
    _favoriteLocalM = Box<FavoriteLocalM>(store);
    _dailyChartIndex = Box<DailyIndexChartDatasModel>(store);
    _dailyChartData = Box<DailyChartDataModel>(store);
    _weeklyChartData = Box<WeeklyChartDataModel>(store);
    _monthlyChartData = Box<MonthlyChartDataModel>(store);
    _intradayChartData = Box<IntradayChartDataModel>(store);
  }

  static Box<loginObject> get loginBox {
    return _loginBox;
  }

  static Box<InfoMobile> get infoMobile {
    return _InfoMobile;
  }

  static Box<OrderBook> get orderBookBox {
    return _oerderbook;
  }

  static Box<IndexMember> get indexMembers {
    return _indexMember;
  }

  static Box<TodayTradesDataModel> get todayTrade {
    return _today;
  }

  static Box<PackageStockList> get stockList {
    return _stockList;
  }

  static Box<DailyHistoryStockSummaryDataModel> get dailyhistorystocksummary {
    return _dailyhistorystocksummary;
  }

  static Box<Quotes> get quotesBox {
    return _quotes;
  }

  static Box<HashKey> get hasKeyBox {
    return _hashKey;
  }

// chart data
  static Box<DailyChartDataModel> get dailyChartDataBox {
    return _dailyChartData;
  }

  static Box<WeeklyChartDataModel> get weeklyChartDataBox {
    return _weeklyChartData;
  }

  static Box<MonthlyChartDataModel> get monthlyChartDataBox {
    return _monthlyChartData;
  }

  static Box<IntradayChartDataModel> get intradayChartDataBox {
    return _intradayChartData;
  }
  // batas

  static Box<IndexModelS> get indexaja {
    return _indexAja;
  }

  static Box<TradeBookModel> get tradebookaja {
    return _tradeBook;
  }

  static Box<RunningTrades> get runningtradeaja {
    return _runningTrade;
  }

  static Box<StockGroupListModel> get stockgroupListAja {
    return _stockGroupList;
  }

  static Box<PERCOBAAN> get PERCOBAANAJA {
    return _PERCOBAAN;
  }

  static Box<TempStockGroupListModel> get TempStockGroupListAja {
    return _TempStockGroupListModel;
  }

  static Box<TempArrayOFGroupname> get TempStockGroupListMember {
    return _TempListMemberModel;
  }

  static Box<TempStockGroupListMemberModel> get TempStockGroupListMemberAja {
    return _TempStockGroupListMemberModel;
  }

  static Box<IndexListTop45> get Indexlisttop45Aja {
    return _indexListTop45;
  }

  static Box<StockData> get StockCodeRangking {
    return _stockDataRangking;
  }

  static Box<FavoriteLoacalH> get FavoriteLoacalHeader {
    return _favoriteLocalH;
  }

  static Box<FavoriteLoacalB> get FavoriteLoacalBody {
    return _favoriteLocalB;
  }

  static Box<FavoriteLocalM> get FavoriteLoacalMember {
    return _favoriteLocalM;
  }

  static Box<DailyIndexChartDatasModel> get indexChartDaily {
    return _dailyChartIndex;
  }

  static Stream<List<OrderBook>> orderBookRealtime() {
    final builder = _oerderbook.query()
      ..order(OrderBook_.lastUpdated, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<OrderBook>> orderBookRealtimeWithQuery(
      String query, String? board) {
    final builder = _oerderbook.query(OrderBook_.stockC.equals(query) &
        (board == null
            ? OrderBook_.board.equals('RG')
            : OrderBook_.board.equals(board)))
      ..order(OrderBook_.lastUpdated, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<TradeBookModel>> tradeBookRealtimeWithQuery(
      String query, String board, int Prevprice) {
    final builder = _tradeBook.query(TradeBookModel_.stockCode.equals(query) &
        TradeBookModel_.board.equals(board))
      ..order(TradeBookModel_.lastUpdated, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<IndexModelS>> quoteIndexrealtim(String query) {
    final builder = _indexAja.query(IndexModelS_.indexCode.equals(query));

    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<RunningTrades>> runningTradeRealtimeWithQuery(
      String query) {
    final builder = _runningTrade.query(RunningTrades_.stockCode.equals(query))
      ..order(RunningTrades_.lastTradedTime, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<RunningTrades>> runningTradeRealtime() {
    final builder = _runningTrade.query()
      ..order(RunningTrades_.lastTradedTime, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<IndexMember>> indexMemberRealtime() {
    final builder = _indexMember.query()
      ..order(IndexMember_.indexCode, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<IndexMember>> indexMemberRealtimewithQuery(String query) {
    final builder = _indexMember.query(IndexMember_.indexCode.equals(query))
      ..order(IndexMember_.indexCode, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<PackageStockList>> stockListRealtime() {
    final builder = _stockList.query()
      ..order(PackageStockList_.stcokCode, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<Quotes>> qoutesRealtime() {
    final builder = _quotes.query()
      ..order(Quotes_.stockCode, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<Quotes>> qoutesRealtimeWithQuery(
      String query, String? board) {
    final builder = _quotes.query(Quotes_.stockCode.equals(query) &
        (board == null
            ? Quotes_.board.equals('RG')
            : Quotes_.board.equals(board)))
      ..order(Quotes_.stockCode, flags: Order.descending);

    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<Quotes>> qoutesRealtimeWithQueryContainer(String query) {
    final builder = _quotes.query(
      Quotes_.stockCode.equals(query) & Quotes_.board.equals("RG"),
    )..order(Quotes_.stockCode, flags: Order.descending);

    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<StockGroupListModel>> stockGroupFavorit(String query) {
    final builder = _stockGroupList
        .query(StockGroupListModel_.clientId.equals(query))
      ..order(StockGroupListModel_.clientId, flags: Order.descending);
    // Future.delayed(Duration(seconds: 2));
    return builder.watch(triggerImmediately: true).map((event) => event.find());
  }

  static Stream<List<DailyIndexChartDatasModel>> streamChart(String indexCode) {
    final open = ObjectBoxDatabase.indexChartDaily;
    final query = open
        .query(DailyIndexChartDatasModel_.indexCode.equals(indexCode))
      ..order(DailyIndexChartDatasModel_.id, flags: Order.descending);

    return query.watch(triggerImmediately: true).map((event) => event.find());
  }

  static void close() {
    _store.close();
  }
}
