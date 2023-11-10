import 'package:flutter/material.dart';
import 'package:online_trading/module/model/orderbook_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/windowshome/widget/home_dekstop/dashboard/widget/cardhorizontal.dart';

class HorizontalDesktop extends StatelessWidget {
  const HorizontalDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.03),
      width: size.width * 1,
      height: size.height * 0.22,
      child: StreamBuilder(
          stream: ObjectBoxDatabase.orderBookRealtime(),
          builder: (builder, snapshot) {
            if (snapshot.data == null) {
              return Container();
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else {
              var length = snapshot.data!.length;

              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (builder, index) {
                    final List<Bid> databid = snapshot.data![index].arrayOBID;
                    return CardHorizontalDesktop(
                        stockC: snapshot.data![index].stockC,
                        bidPrice: databid.isEmpty ? 0 : databid.first.bidPrice,
                        bidVolume:
                            databid.isEmpty ? 0 : databid.first.bidVolume);
                  });
            }
          }),
    );
  }
}
