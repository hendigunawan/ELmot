import 'package:flutter/material.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/tradebook/widget/build.table.dart';

class TradeBookWidget extends StatelessWidget {
  final String stockCsearch;
  final String board;
  final int? prevP;
  TradeBookWidget(
      {super.key, this.prevP, required this.stockCsearch, required this.board});
  final getObjectBoxTradeBook = ObjectBoxDatabase.tradebookaja;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ObjectBoxDatabase.tradeBookRealtimeWithQuery(
          stockCsearch.toUpperCase(), board.toString(), prevP!.toInt()),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BuildTableTradeBook.createTable(
            snapshot.data == null || snapshot.data!.isEmpty
                ? []
                : snapshot.data!.first.arrayList,
            snapshot.data == null || snapshot.data!.isEmpty
                ? 0
                : prevP!.toInt(),
            context,
          );
        } else if (snapshot.hasData) {
          return BuildTableTradeBook.createTable(
            snapshot.data == null || snapshot.data!.isEmpty
                ? []
                : snapshot.data!.first.arrayList,
            snapshot.data == null || snapshot.data!.isEmpty
                ? 0
                : prevP!.toInt(),
            context,
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text("${snapshot.hasError}"),
          );
        } else {
          return BuildTableTradeBook.createTable([], 0, context);
        }
      },
    );
  }
}
