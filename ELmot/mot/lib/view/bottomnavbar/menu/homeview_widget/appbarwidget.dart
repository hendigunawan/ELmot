import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/homeview_widget/drawerwidget.dart';
import 'package:online_trading/view/login_view.dart';
import 'package:online_trading/view/tabbar_view/TabBarFavorit/tabbarview_favorit.dart';
import 'package:online_trading/view/tabbar_view/TabBarIndex/mainTabbarindex.dart';
import 'package:online_trading/view/tabbar_view/TabBarView1/tabbar_view1.dart';
import 'package:online_trading/view/tabbar_view/tradingView/tradingview.main.dart';
import 'package:online_trading/view/widget/notifikasi_popup.dart';
import 'package:online_trading/view/widget/search_widget.dart';

RxInt index = 0.obs;
late TabController tabController;

class WidgetAppBarHome extends StatefulWidget {
  const WidgetAppBarHome({super.key});

  @override
  State<WidgetAppBarHome> createState() => _WidgetAppBarHomeState();
}

class _WidgetAppBarHomeState extends State<WidgetAppBarHome>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: index.value,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Theme(
      data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(
                surfaceVariant: Colors.transparent,
              )),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(double.infinity, 100.h),
          child: AppBar(
              elevation: 0,
              bottomOpacity: 1,
              leading: Builder(builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Icon(
                    Icons.menu,
                    size: 25.sp,
                    color: putihop85,
                  ),
                );
              }),
              bottom: TabBar(
                controller: tabController,
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                onTap: (value) {
                  var open0 = ObjectBoxDatabase.indexMembers;
                  var open1 = ObjectBoxDatabase.StockCodeRangking;
                  var open2 = ObjectBoxDatabase.indexaja;
                  if (Get.put(ConnectionsController()).onReadys.value) {
                    Get.find<ControllerHandelSUB>().unBind();
                  }
                  if (value == 0) {
                    if (!open0.isEmpty()) {
                      var query = open0
                          .query(IndexMember_.indexCode.equals('LQ45'))
                          .build()
                          .findFirst();
                      if (query != null) {
                        for (var i = 0; i < query.array.length; i++) {
                          Get.find<ControllerHandelSUB>().addOrUpdateToSubList(
                            ModelSUB(
                              routingKey: 'QT.${query.array[i].stockCode}.RG',
                            ),
                          );
                        }
                      }
                    }
                    if (!open1.isEmpty()) {
                      if (Get.put(ConnectionsController()).onReadys.value) {
                        Get.find<ControllerHandelSUB>().unBind();
                      }
                      var query = open1
                          .query(StockData_.reqType.equals(1) &
                              StockData_.iBoard.equals(0))
                          .build()
                          .findFirst();
                      if (query != null && query.arrayData.isNotEmpty) {
                        for (var i = 0;
                            i <
                                (query.arrayData.length < 10
                                    ? query.arrayData.length
                                    : 10);
                            i++) {
                          Get.find<ControllerHandelSUB>().addOrUpdateToSubList(
                            ModelSUB(
                              routingKey:
                                  'QT.${query.arrayData[i].stockCode}.RG',
                            ),
                          );
                        }
                      }
                    }
                  } else if (value == 1) {
                    if (Get.put(ConnectionsController()).onReadys.value) {
                      Get.find<ControllerHandelSUB>().unBind();
                    }
                    if (!open2.isEmpty()) {
                      var query = open2.getAll();
                      if (query.isNotEmpty) {
                        for (var i = 0; i < query.length; i++) {
                          Get.find<ControllerHandelSUB>().addOrUpdateToSubList(
                            ModelSUB(
                              routingKey: 'ID.${query[i].indexCode}',
                            ),
                          );
                        }
                      }
                    }
                  }
                },
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 1.25.h,
                physics: const NeverScrollableScrollPhysics(),
                labelColor: const Color.fromARGB(255, 163, 124, 8),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color.fromARGB(255, 163, 124, 8),
                labelStyle: TextStyle(
                  fontSize: FontSizes.size13,
                ),
                tabs: const [
                  Tab(
                    text: "Stock",
                  ),
                  Tab(
                    text: "Index",
                  ),
                  Tab(
                    text: "Trading",
                  ),
                  Tab(
                    text: "Favorit",
                  ),
                ],
              ),
              backgroundColor: Colors.black,
              title: SearchWidget(
                controller: controller,
                onPressedX: () {
                  controller.clear();
                },
                onFinnis: (a) {
                  Navigator.pushNamed(
                    context,
                    '/goDetailview',
                    arguments: <String, String>{
                      'title': a,
                      'subtitle': '',
                      'board': 'RG',
                    },
                  );
                },
              ),
              titleSpacing: 15.w,
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          // ActivityRequest.reqAppFileHash();
                        },
                        child: Icon(
                          Icons.notifications_outlined,
                          size: 28.sp,
                          color: putihop85,
                        ),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      GestureDetector(
                        onTap: () {
                          NotifikasiPopup.showCANCEL(
                            onSubmit: () {
                              Get.put(LogoutController()).logoutReq();
                            },
                            text: "Are you sure want to logout?",
                          );
                        },
                        child: Icon(
                          Icons.logout,
                          color: putihop85,
                          size: 23.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
        drawer: const DrawerWidget(),
        body: SafeArea(
          child: TabBarView(
            controller: tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              const TabBarView1(),
              const MainTabbarIndex(),
              TradingViewMain(),
              const TabBarFavorit()
            ],
          ),
        ),
      ),
    );
  }
}
     // OrderMassage.reqTradeList(
                          //     accountId: '0010912', pin: '123456');
                          // final pdfFile = await CreatePdf.generate(
                          //     header: WigetPdf.header(title: 'Create Your PDF'),
                          //     body: <p.Widget>[
                          //       p.SizedBox(height: 0.5 * PdfPageFormat.cm),
                          //       p.Paragraph(
                          //         text:
                          //             'This is my custom font that displays also characters such as €, Ł, ...',
                          //         style: p.TextStyle(fontSize: 20),
                          //       ),
                          //       p.Header(child: p.Text('My Headline')),
                          //       WigetPdf.table(
                          //         border: 1,
                          //         header: [
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Estimation',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Estimation',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Estimation',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Estimation',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Estimation',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Estimation',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Transaction Fee',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Nett',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Nett',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Nett',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Nett',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //           TableModelHederPDF(
                          //             label: p.Text(
                          //               'Nett',
                          //               style: p.TextStyle(
                          //                 color: PdfColors.white,
                          //                 fontSize: FontSizes.size10,
                          //                 fontWeight: p.FontWeight.bold,
                          //               ),
                          //             ),
                          //             alignment: p.Alignment.center,
                          //           ),
                          //         ],
                          //         body: [
                          //           TableModelBodyPDF(
                          //             body: [
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //               p.Text(
                          //                 'Nett',
                          //                 style: p.TextStyle(
                          //                   color: PdfColors.black,
                          //                   fontSize: FontSizes.size10,
                          //                   fontWeight: p.FontWeight.bold,
                          //                 ),
                          //               ),
                          //             ],
                          //           ),
                          //         ],
                          //       ),
                          //     ]);

                          // Navigator.of(context).push(
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) => PdfMainPage(
                          //       path: pdfFile,
                          //     ),
                          //   ),
                          // );