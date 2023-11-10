import 'package:flutter/material.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/main.dart';
import 'package:online_trading/view/bottomnavbar/maincheckout_frombotttomview.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/account_info_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cash_withdraw_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/cashledger_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/statementaccount_financial_history_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/portopolio_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/realizedgainloss_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/taxreportmain.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/trade_confirmation_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/accountview_widget/part/transactionreport_main.dart';
import 'package:online_trading/view/bottomnavbar/menu/homeview_widget/widget/settings.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/newBreakOrder.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/breakOrder/widget/list_break_order.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/listGTC/listGTCOrder.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/gtcOrder/newGTC/newGTC.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/speadOrder/main_list_spread_order.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/list_trailing/main_list_trailing.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/advaceOrder/tralingOrder/newTralingOrder/newTralingOrder.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/orderview_widget/page/orderMenu/historicalOrder/historicalOrder.main.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/historical_tradelist/historical_tradelist_main.dart';
import 'package:online_trading/view/checkoutview/mainAmend.view.dart';
import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
import 'package:online_trading/view/checkoutview/tradelist/tradeList.main.dart';
import 'package:online_trading/view/leading/landing_page.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/notificationview/notifikasimain.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/part/detail_index.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:online_trading/windowshome/mainhome.dart';
import 'package:page_transition/page_transition.dart';
import 'view/bottomnavbar/bottomnavbarwidget.dart';
import 'view/checkoutview/mainchechout_view.dart';
import 'package:get/get.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    if (Get.put(ConnectionsController()).onReadys.value) {
      try {
        Get.find<ControllerHandelSUB>().unBind();
      } catch (e) {
        print(e);
      }
    }

    switch (settings.name) {
      case '/':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );
      case '/splashView':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
          settings: settings,
        );
      case '/loginview':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const LoginView(),
          settings: settings,
        );

      case '/homeview':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const BottomNavbarWidget(),
          settings: settings,
        );

      case '/SettingsView':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const SettingsView(),
          settings: settings,
        );

      case '/orderList':
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const MainOrderListHome(),
          settings: settings,
        );
      case '/historiOrder':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const HistoricalOrder(),
          settings: settings,
        );
      case '/tradeList':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const TradeListMain(),
          settings: settings,
        );
      case '/historicalTradeList':
        Get.put(PinSave()).onPop();

        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const HistoricalTradeListMain(),
          settings: settings,
        );
      case '/notifikasiview':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const NotifikasiPage(),
          settings: settings,
        );
      case '/homeWindows':
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => const HomeMain(),
          settings: settings,
        );
      case '/newGTC':
        fokusNode = FocusNode();
        if (args is Map<String, String>) {
          if (args['title'] == null || args['title'] == '') {
            Get.put(PinSave()).onPop();
          }
          return MaterialPageRoute(
            builder: (_) => NewGTCMain(
              title: args['title'] == null ? '' : args['title'].toString(),
            ),
            settings: settings,
          );
        }
      case '/newTraling':
        fokusNode = FocusNode();
        if (args is Map<String, String>) {
          if (args['title'] == null || args['title'] == '') {
            Get.put(PinSave()).onPop();
          }
          return MaterialPageRoute(
            builder: (_) => NewTralingOrderMain(
              title: args['title'] == null || args['title'] == ''
                  ? 'ANTM'
                  : args['title'].toString(),
            ),
            settings: settings,
          );
        }
      case '/newBreak':
        fokusNode = FocusNode();
        if (args is Map<String, String>) {
          if (args['title'] == null || args['title'] == '') {
            Get.put(PinSave()).onPop();
          }
          return MaterialPageRoute(
            builder: (_) => NewBreakOrderMain(
              title: args['title'] == null || args['title'] == ''
                  ? 'ANTM'
                  : args['title'].toString(),
            ),
            settings: settings,
          );
        }
      case '/newListTraling':
        fokusNode = FocusNode();
        Get.put(PinSave()).onPop();
        return MaterialPageRoute(
          builder: (_) => ListTrailingMain(),
          settings: settings,
        );
      case '/ListSpreadOrderView':
        fokusNode = FocusNode();
        Get.put(PinSave()).onPop();
        return MaterialPageRoute(
          builder: (_) => MainListSpreadOrder(),
          settings: settings,
        );
      case '/ListBreakOrderMain':
        fokusNode = FocusNode();
        Get.put(PinSave()).onPop();
        return MaterialPageRoute(
          builder: (_) => ListBreakOrderMain(),
          settings: settings,
        );
      case '/listGTC':
        Get.put(PinSave()).onPop();
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (_) => ListGTCOrderMain(),
          settings: settings,
        );
      // case '/checkoutview':
      //   accountId.value = '';
      //   Get.put(PinSave()).onPop();
      //   fokusNode = FocusNode();
      //   if (args is Map<String, String>) {
      //     return MaterialPageRoute(
      //       builder: (_) => MainCheckOutView(
      //         prevP: args['prevP'] == null
      //             ? 0
      //             : int.parse(args['prevP'].toString()),
      //         typeCheckout: args['typeCheckout'].toString(),
      //         title: args['title'].toString(),
      //         subtitle: args['subtitle'].toString(),
      //         board: args['board'].toString(),
      //       ),
      //     );
      //   }
      // case '/checkoutviewAmendAndWithdraw':
      //   fokusNode = FocusNode();
      //   if (args is Map<String, String>) {
      //     if (args['isFormC'] == '' || args['isFormC'] == null) {
      //       accountId.value = '';
      //       Get.put(PinSave()).onPop();
      //     }
      //     return MaterialPageRoute(
      //       builder: (_) => MainCheckOutView(
      //         prevP: args['prevP'] == null
      //             ? 0
      //             : int.parse(args['prevP'].toString()),
      //         typeCheckout: args['typeCheckout'].toString(),
      //         title: args['title'].toString(),
      //         subtitle: args['subtitle'].toString(),
      //         board: args['board'].toString(),
      //       ),
      //     );
      //   }
      case '/detailview':
        fokusNode = FocusNode();
        if (args is Map<String, String>) {
          return PageTransition(
            child: TradeViewMain(
              title: args['title'].toString(),
              subTitle: args['subtitle'].toString(),
              board: args['board'].toString(),
            ),
            settings: settings,
            duration: const Duration(milliseconds: 300),
            type: PageTransitionType.rightToLeft,
          );
        }
      case '/backtoHome':
        fokusNode = FocusNode();
        return PageTransition(
          child: const BottomNavbarWidget(),
          type: PageTransitionType.leftToRight,
          settings: settings,
          duration: const Duration(milliseconds: 300),
        );
      case '/backtoDetailview':
        fokusNode = FocusNode();
        if (args is Map<String, String>) {
          return PageTransition(
            child: TradeViewMain(
              title: args['title'].toString(),
              subTitle: args['subtitle'].toString(),
              board: args['board'].toString(),
            ),
            type: PageTransitionType.leftToRight,
            settings: settings,
            duration: const Duration(milliseconds: 300),
          );
        }
      case '/goDetailview':
        fokusNode = FocusNode();
        if (args is Map<String, String>) {
          return PageTransition(
            child: TradeViewMain(
              title: args['title'].toString(),
              subTitle: args['subtitle'].toString(),
              board: args['board'].toString(),
            ),
            type: previousRouteObserver.previousRoute == '/goDetailview'
                ? PageTransitionType.fade
                : PageTransitionType.rightToLeft,
            settings: settings,
            duration: const Duration(milliseconds: 300),
          );
        }
      case '/goStackdetailview':
        if (args is Map<String, String>) {
          fokusNode = FocusNode();
          return PageTransition(
            child: TradeViewMain(
              title: args['title'].toString(),
              subTitle: args['subtitle'].toString(),
              board: args['board'].toString(),
            ),
            type: PageTransitionType.fade,
            settings: settings,
            duration: const Duration(milliseconds: 400),
          );
        }
      // case '/goStackcheckoutview':
      //   if (args is Map<String, String>) {
      //     fokusNode = FocusNode();
      //     return PageTransition(
      //       child: MainCheckOutView(
      //         prevP: args['prevP'] == null
      //             ? 0
      //             : int.parse(args['prevP'].toString()),
      //         typeCheckout: args['typeCheckout'].toString(),
      //         title: args['title'].toString(),
      //         subtitle: args['subtitle'].toString(),
      //         board: args['board'].toString(),
      //       ),
      //       type: PageTransitionType.fade,
      //       settings: settings,
      //       duration: const Duration(milliseconds: 400),
      //     );
      //   }
      case '/goCheckoutview':
        if (args is Map<String, String>) {
          fokusNode = FocusNode();
          return PageTransition(
            child: MainCheckOutView(
              prevP: args['prevP'] == null || args['prevP'] == ''
                  ? 0
                  : int.parse(args['prevP'].toString()),
              typeCheckout: args['typeCheckout'].toString(),
              title: args['title'].toString(),
              subtitle: args['subtitle'].toString(),
              board: args['board'].toString(),
            ),
            type: PageTransitionType.rightToLeft,
            settings: settings,
            duration: const Duration(milliseconds: 300),
          );
        }
      // Ini yang bottom
      case '/goCheckoutviewBottom':
        if (args is Map<String, String>) {
          fokusNode = FocusNode();
          return PageTransition(
            child: MainCheckOutFromBottomView(
              prevP: args['prevP'] == null || args['prevP'] == ''
                  ? 0
                  : int.parse(args['prevP'].toString()),
              typeCheckout: args['typeCheckout'].toString(),
              title: args['title'].toString(),
              subtitle: args['subtitle'].toString(),
              board: args['board'].toString(),
            ),
            type: PageTransitionType.rightToLeft,
            settings: settings,
            duration: const Duration(milliseconds: 300),
          );
        }
      case '/goCheckoutviewAmendAndWD':
        if (args is Map<String, String>) {
          fokusNode = FocusNode();
          return PageTransition(
            child: AmendAndWithDraw(
              type: args['typeCheckout'].toString(),
              stockCode: args['title'].toString(),
              idxCode: args['idxID'].toString(),
            ),
            type: PageTransitionType.rightToLeft,
            settings: settings,
            duration: const Duration(milliseconds: 500),
          );
        }
      case '/DetailIndexTop':
        if (args is Map<String, String>) {
          return MaterialPageRoute(
            builder: (context) {
              return DetailIndexTop(indexCode: args["indexCode"].toString());
            },
            settings: settings,
          );
        }
      case '/portopolioView':
        fokusNode = FocusNode();
        return PageTransition(
          child: PortopolioMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/taxreportView':
        fokusNode = FocusNode();
        return PageTransition(
          child: TaxReportWidget(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/transactionreportView':
        fokusNode = FocusNode();
        return PageTransition(
          child: TransactionReportMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/realizedgainlossView':
        fokusNode = FocusNode();
        return PageTransition(
          child: RealizedGainLossMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/accountinfoView':
        fokusNode = FocusNode();
        return PageTransition(
          child: const AccountInfoMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );

      case '/financialhistoryView':
        fokusNode = FocusNode();
        return PageTransition(
          child: FinancialHistoryMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/cashledgerView':
        fokusNode = FocusNode();
        return PageTransition(
          child: CashLedgerMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/tradeconfirmationView':
        fokusNode = FocusNode();
        return PageTransition(
          child: TradeConfirmationMain(),
          type: PageTransitionType.rightToLeft,
          duration: const Duration(milliseconds: 300),
          settings: settings,
        );
      case '/cashwithdrawView':
        fokusNode = FocusNode();
        return MaterialPageRoute(
          builder: (context) {
            return CashWithDrawMain();
          },
          settings: settings,
        );
      // PageTransition(
      //   child: CashWithDrawMain(),
      //   type: PageTransitionType.rightToLeft,
      //   duration: const Duration(milliseconds: 300),
      // );
      default:
        return _errorRoute(settings);
    }
    return null;
  }

  static Route<dynamic> _errorRoute(RouteSettings? settings) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('ERROR'),
          ),
        );
      },
      settings: settings,
    );
  }
}
