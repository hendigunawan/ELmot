// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:online_trading/module/model/orderbook_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';

import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/widget/buildlist.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/orderbook/widget/build.table.dart';

// ignore: must_be_immutable
class SreamOBView extends StatelessWidget {
  String? stockCsearch;
  final int? prevP;
  final String? board;
  void Function(String)? onTapBid;
  void Function(String)? onTapOffer;
  SreamOBView({
    super.key,
    this.stockCsearch,
    this.prevP,
    this.board,
    this.onTapBid,
    this.onTapOffer,
  });
  final getObjectBox = ObjectBoxDatabase.indexMembers;
  final getObjectBoxOrderBook = ObjectBoxDatabase.orderBookBox;
  int? queryPrev;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ObjectBoxDatabase.orderBookRealtimeWithQuery(
          stockCsearch!.toUpperCase(), board ?? 'RG'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final dataList = snapshot.data!;
          if (prevP == null) {
            try {
              queryPrev = ObjectBoxDatabase.quotesBox
                  .query(Quotes_.stockCode.equals(stockCsearch!))
                  .build()
                  .findFirst()!
                  .prevPrice!;
            } catch (e) {
              queryPrev = 0;
            }
          }
          int totalRows = 10;

          List<Bid> dataSource1 = GetDataListOrderBook.getDataBID(
            totalRows,
            dataList.isEmpty ? [] : dataList.first.arrayOBID,
          );
          List<Offer> dataSource2 = GetDataListOrderBook.getDataOFTER(
            totalRows,
            dataList.isEmpty ? [] : dataList.first.arrayOOffer,
          );
          return BuildTableKomponenOrderBook.createTable(
              totalRows, dataSource1, dataSource2, prevP ?? queryPrev ?? 0,
              onTapBid: onTapBid, onTapOffer: onTapOffer);
        }
        return BuildTableKomponenOrderBook.createTable(
            0, [], [], prevP ?? queryPrev ?? 0);
      },
    );
  }
}
