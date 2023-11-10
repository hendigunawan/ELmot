// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/pkg/info/cash_ledger.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/financial_history.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolio.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/portopolioreturn.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/tax_report.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/tradeconfirmation.pkg.dart';
import 'package:online_trading/module/ordering/pkg/info/transactionreport.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/account.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/account_info_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cash_withdraw_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cashledger_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/monthly_balance_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/portopolio_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/realizedgainloss_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/rightwarrant_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/statementaccount_financial_history_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/taxreportmain.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/trade_confirmation_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/transaction_and_holidays_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/transactionreport_main.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

// ignore: must_be_immutable
class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller =
        !Get.isRegistered<PinSave>() ? Get.put(PinSave()) : Get.find<PinSave>();
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          centerTitle: true,
          expandedHeight: 145.h,
          floating: false,
          pinned: true,
          automaticallyImplyLeading: false,
          title: Text(
            'My Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.people,
                  size: 55.sp,
                  color: putihop85,
                ),
                Obx(() {
                  return Text(
                    Get.find<LoginOrderController>()
                        .order!
                        .value
                        .loginId
                        .toString(),
                    style:
                        TextStyle(color: putihop85, fontSize: FontSizes.size15),
                  );
                }),
                GestureDetector(
                    onTap: () {
                      fokusNode = FocusNode();
                      controller.pin.value = '';
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const AccountInfoMain();
                      }));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue.withOpacity(0.6),
                            width: 1.w,
                          ),
                          borderRadius: BorderRadius.circular(
                            8.r,
                          ),
                        ),
                        width: 0.25.sw,
                        height: 23.h,
                        child: Text(
                          "Account Info",
                          style: TextStyle(
                            color: putihop85,
                            fontSize: FontSizes.size10,
                          ),
                        )))
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(10.w),
              margin: EdgeInsets.only(top: 10.h),
              width: double.infinity,
              height: 1.sh,
              decoration: BoxDecoration(
                color: bgabu,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listPortopolio!.clear();
                      listPortopolioreturn!.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return PortopolioMain();
                        },
                      ));
                      // showModalBottomSheet(
                      //   isScrollControlled: true,
                      //   context: context,
                      //   builder: (context) {
                      //     return DraggableScrollableSheet(
                      //       initialChildSize: 0.5.h,
                      //       snap: true,
                      //       maxChildSize: 0.5.h,
                      //       expand: false,
                      //       builder: (context, scrollController) {
                      //         return SingleChildScrollView(
                      //           controller: scrollController,
                      //           child: Column(
                      //             children: [
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               ListTile(title: Text('Item 1')),
                      //               ListTile(title: Text('Item 2')),
                      //               // ... tambahkan item lain di sini
                      //             ],
                      //           ),
                      //         );
                      //       },
                      //     );
                      //   },
                      // );
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.account_balance,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Portopolio & Portopolio Return",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listTransactionreportBYYEAR.clear();
                      listTransactionreportRemainyear.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TransactionReportMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.report_gmailerrorred,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Transaction Report",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RealizedGainLossMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.report_gmailerrorred,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Realized Gain/Loss",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listTaxReport.clear();
                      listtaxreportBYYEAR.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TaxReportWidget();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.account_box,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Tax Report",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listFinancialHistory.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return FinancialHistoryMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.money,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Statement of Account",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listcashLedger.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CashLedgerMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.money,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Cash Ledger",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listtradeconfirmationBYDATE.clear();
                      listtradeconfirmationREMAINDATE.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return TradeConfirmationMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.confirmation_num,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Trade Confirmation",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      listtradeconfirmationBYDATE.clear();
                      listtradeconfirmationREMAINDATE.clear();
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return CashWithDrawMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.confirmation_num,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Cash Withdraw",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const MonthlyBalanceMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.confirmation_num,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Monthly Balance",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      OrderMassage.reqTransactionnHolidays(reqType: 0);
                      OrderMassage.reqTransactionnHolidays(reqType: 1);
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const TransactionHolidaysMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.confirmation_num,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Transaction and Holidays",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return RightWarrantMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.confirmation_num,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Exercise Right/Warrant",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.pin.value = '';
                      fokusNode = FocusNode();
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const AccountMain();
                        },
                      ));
                    },
                    child: Container(
                      height: 50.h,
                      width: 1.sw,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: bgabu),
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 8.w,
                          right: 8.w,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.security,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                            Text(
                              " Security",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: FontSizes.size14),
                            ),
                            const Spacer(),
                            FittedBox(
                              fit: BoxFit.cover,
                              child: Icon(
                                Icons.keyboard_arrow_right,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
// porto summary
// Row(
//   children: [
//     Container(
//       width: constrain.maxWidth * 0.36,
//       height: constrain.maxHeight * 0.33,
//       decoration: BoxDecoration(
//           color: foregroundwidget.withOpacity(0.9)),
//       child: Center(
//         child: Text(
//           "Cash / Cash T+2",
//           style: TextStyle(
//               color: Colors.white.withOpacity(0.85),
//               fontSize: 12.sp),
//         ),
//       ),
//     ),
//     Container(
//       width: constrain.maxWidth * 0.32,
//       height: constrain.maxHeight * 0.33,
//       decoration:
//           const BoxDecoration(color: Colors.black),
//       child: Center(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             formattaCurrun(
//                 listPortopolio!.first.currentCash!),
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.85),
//                 fontSize: 12.sp),
//           ),
//         ),
//       ),
//     ),
//     Container(
//       padding: EdgeInsets.only(right: 5.w),
//       width: constrain.maxWidth * 0.32,
//       height: constrain.maxHeight * 0.33,
//       decoration:
//           const BoxDecoration(color: Colors.black),
//       child: Center(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             formattaCurrun(
//                 listPortopolio!.first.t2NetCash!),
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.85),
//                 fontSize: 12.sp),
//           ),
//         ),
//       ),
//     )
//   ],
// ),
// Row(
//   children: [
//     Container(
//       width: constrain.maxWidth * 0.36,
//       height: constrain.maxHeight * 0.33,
//       decoration: BoxDecoration(
//           color: foregroundwidget.withOpacity(0.9)),
//       child: Center(
//         child: Text(
//           "Interest / Remail TL",
//           style: TextStyle(
//               color: Colors.white.withOpacity(0.85),
//               fontSize: 12.sp),
//         ),
//       ),
//     ),
//     Container(
//       width: constrain.maxWidth * 0.32,
//       height: constrain.maxHeight * 0.33,
//       decoration:
//           const BoxDecoration(color: Colors.black),
//       child: Center(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             formattaCurrun(
//                 listPortopolio!.first.interest!),
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.85),
//                 fontSize: 12.sp),
//           ),
//         ),
//       ),
//     ),
//     Container(
//       padding: EdgeInsets.only(right: 5.w),
//       width: constrain.maxWidth * 0.32,
//       height: constrain.maxHeight * 0.33,
//       decoration:
//           const BoxDecoration(color: Colors.black),
//       child: Center(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             formattaCurrun(listPortopolio!
//                 .first.remainTradingLimit!),
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.85),
//                 fontSize: 12.sp),
//           ),
//         ),
//       ),
//     )
//   ],
// ),
// Row(
//   children: [
//     Container(
//       width: constrain.maxWidth * 0.36,
//       height: constrain.maxHeight * 0.33,
//       decoration: BoxDecoration(
//           color: foregroundwidget.withOpacity(0.9)),
//       child: Center(
//         child: Text(
//           "Market / Margin Ratio",
//           style: TextStyle(
//               color: Colors.white.withOpacity(0.85),
//               fontSize: 12.sp),
//         ),
//       ),
//     ),
//     Container(
//       width: constrain.maxWidth * 0.32,
//       height: constrain.maxHeight * 0.33,
//       decoration:
//           const BoxDecoration(color: Colors.black),
//       child: Center(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             formattaCurrun(
//                 listPortopolio!.first.marketRatio!),
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.85),
//                 fontSize: 12.sp),
//           ),
//         ),
//       ),
//     ),
//     Container(
//       padding: EdgeInsets.only(right: 5.w),
//       width: constrain.maxWidth * 0.32,
//       height: constrain.maxHeight * 0.33,
//       decoration:
//           const BoxDecoration(color: Colors.black),
//       child: Center(
//         child: Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             formattaCurrun(
//                 listPortopolio!.first.currentRatio!),
//             style: TextStyle(
//                 color: Colors.white.withOpacity(0.85),
//                 fontSize: 12.sp),
//           ),
//         ),
//       ),
//     )
//   ],
// )
