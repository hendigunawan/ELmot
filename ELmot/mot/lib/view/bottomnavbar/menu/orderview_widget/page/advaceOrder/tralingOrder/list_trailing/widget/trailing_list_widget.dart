import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/model/order/requestTralingList.model.dart';
import 'package:online_trading/module/ordering/pkg/order/requestTralingList.pkg.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/tradewidget/candle/candle.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';

Widget tableTrailingList(
    {void Function(ArrayRequestTralingOrderModel)? onTapX}) {
  return Obx(() {
    return HorizontalDataTable(
        elevation: 0,
        rowSeparatorWidget: Divider(
          height: 2.h,
          thickness: 0.05,
        ),
        leftHandSideColumnWidth: 0.6.sw,
        rightHandSideColumnWidth: 2.5.sw,
        isFixedHeader: true,
        leftHandSideColBackgroundColor: Colors.black,
        rightHandSideColBackgroundColor: Colors.black,
        headerWidgets: getHeaderWidget(),
        itemCount: listTrailingOrder.isEmpty
            ? 0
            : listTrailingOrder.first.array!.length,
        leftSideItemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                  alignment: Alignment.center,
                  height: 66.h,
                  width: 0.1.sw,
                  color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                  child: listTrailingOrder.first.array![index].orderStatus == 1
                      ? GestureDetector(
                          onTap: () {
                            // showDialog(
                            //   context: context,
                            //   builder: (context) {
                            //     return AlertDialog(
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(
                            //           5.r,
                            //         ),
                            //       ),
                            //       backgroundColor: putihop85,
                            //       title: Center(
                            //         child: Text(
                            //           "Confirm\nCancel",
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //               color: Colors.black,
                            //               fontSize: 14.sp,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //       content: Container(
                            //         alignment: Alignment.center,
                            //         padding: EdgeInsets.all(8.w),
                            //         height: 70.h,
                            //         decoration: BoxDecoration(
                            //           color: const Color.fromARGB(
                            //               255, 184, 182, 182),
                            //           borderRadius: BorderRadius.circular(
                            //             5.r,
                            //           ),
                            //         ),
                            //         child: Text(
                            //           "Are you sure want to\ncancel?\nStockcode : ${listTrailingOrder.first.array![index].stockCode}",
                            //           textAlign: TextAlign.center,
                            //           style: TextStyle(
                            //             color: Colors.black,
                            //             fontSize: 12.sp,
                            //           ),
                            //         ),
                            //       ),
                            //       actionsAlignment: MainAxisAlignment.center,
                            //       actions: [
                            //         SizedBox(
                            //           height: 30.h,
                            //           width: 0.24.sw,
                            //           child: ElevatedButton(
                            //               style: ElevatedButton.styleFrom(
                            //                 shape: RoundedRectangleBorder(
                            //                     borderRadius:
                            //                         BorderRadius.circular(5.r)),
                            //                 backgroundColor: Colors.red,
                            //               ),
                            //               onPressed: () {
                            //                 Navigator.pop(context);
                            //               },
                            //               child: Center(
                            //                 child: Text(
                            //                   "Cancel",
                            //                   style: TextStyle(
                            //                       color: Colors.black,
                            //                       fontSize: 10.sp,
                            //                       fontWeight: FontWeight.bold),
                            //                 ),
                            //               )),
                            //         ),
                            //         SizedBox(
                            //           width: 5.w,
                            //         ),
                            //         SizedBox(
                            //           height: 30.h,
                            //           width: 0.24.sw,
                            //           child: ElevatedButton(
                            //               style: ElevatedButton.styleFrom(
                            //                   shape: RoundedRectangleBorder(
                            //                       borderRadius:
                            //                           BorderRadius.circular(
                            //                               5.r)),
                            //                   backgroundColor: Colors.blue),
                            //               onPressed: () async {
                            //                 Navigator.pop(context);
                            //               },
                            //               child: Center(
                            //                 child: Text(
                            //                   "Ok",
                            //                   style: TextStyle(
                            //                       color: Colors.black,
                            //                       fontSize: 10.sp,
                            //                       fontWeight: FontWeight.bold),
                            //                 ),
                            //               )),
                            //         ),
                            //       ],
                            //     );
                            //   },
                            // );
                            onTapX!(listTrailingOrder.first.array![index]);
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                        )
                      : null),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].orderStatus == 0
                            ? 'Rejected'
                            : listTrailingOrder
                                        .first.array![index].orderStatus ==
                                    1
                                ? 'Open'
                                : listTrailingOrder
                                            .first.array![index].orderStatus ==
                                        2
                                    ? 'Executed'
                                    : 'Withdrawn',
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].command == 0
                            ? 'Buy'
                            : listTrailingOrder.first.array![index].command == 1
                                ? 'Sell'
                                : listTrailingOrder
                                            .first.array![index].orderStatus ==
                                        2
                                    ? 'Margin Buy'
                                    : 'Short Sell',
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].stockCode!,
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].marketCode!,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: putihop85,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        rightSideItemBuilder: (context, index) {
          return Row(
            children: [
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].execPrice! == 0
                            ? '  Best ${listTrailingOrder.first.array![index].command == 0 ? 'Offer' : 'Bid'}'
                            : listTrailingOrder
                                        .first.array![index].execPrice! ==
                                    1
                                ? '  Best ${listTrailingOrder.first.array![index].command == 0 ? 'Offer' : 'Bid'} +1'
                                : listTrailingOrder
                                            .first.array![index].execPrice! ==
                                        2
                                    ? '  Best ${listTrailingOrder.first.array![index].command == 0 ? 'Offer' : 'Bid'} +2'
                                    : listTrailingOrder.first.array![index]
                                                .execPrice! ==
                                            3
                                        ? '  Best ${listTrailingOrder.first.array![index].command == 0 ? 'Offer' : 'Bid'} +3'
                                        : listTrailingOrder.first.array![index]
                                                    .execPrice! ==
                                                4
                                            ? '  Best ${listTrailingOrder.first.array![index].command == 0 ? 'Offer' : 'Bid'} +4'
                                            : '  Best ${listTrailingOrder.first.array![index].command == 0 ? 'Offer' : 'Bid'} +5',
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        formattaCurrun(
                          listTrailingOrder.first.array![index].volume!,
                        ),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].autoPriceStep == 0
                            ? 'Not Active'
                            : listTrailingOrder
                                .first.array![index].autoPriceStep
                                .toString(),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattaCurrun(
                            listTrailingOrder.first.array![index].dropPrice!),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder
                                    .first.array![index].trailingPriceType ==
                                0
                            ? 'Best Bid'
                            : listTrailingOrder.first.array![index]
                                        .trailingPriceType ==
                                    1
                                ? 'Best Offer'
                                : listTrailingOrder.first.array![index]
                                            .trailingPriceType ==
                                        2
                                    ? 'Last Price'
                                    : listTrailingOrder.first.array![index]
                                                .trailingPriceType ==
                                            3
                                        ? 'Avg Price'
                                        : listTrailingOrder.first.array![index]
                                                    .trailingPriceType ==
                                                4
                                            ? 'High Price'
                                            : 'Low Price',
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattaCurrun(listTrailingOrder
                                .first.array![index].trailingStep! ~/
                            Get.find<LoginOrderController>().order!.value.lot!),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattaCurrun(
                          listTrailingOrder.first.array![index].stopPrice!,
                        ),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.centerRight,
                      child: Text(
                        formattaCurrun(listTrailingOrder
                            .first.array![index].trailingPrice!),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        dateAjaGarisMiring(
                            listTrailingOrder.first.array![index].startDate),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].dueDate == 0
                            ? ''
                            : dateAjaGarisMiring(
                                listTrailingOrder.first.array![index].dueDate),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].orderDate == 0
                            ? ''
                            : dateAjaGarisMiring(listTrailingOrder
                                .first.array![index].orderDate),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].orderTime == 0
                            ? ''
                            : dateTimeAJa(listTrailingOrder
                                .first.array![index].orderTime),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].sentDate == 0
                            ? ''
                            : dateAjaGarisMiring(
                                listTrailingOrder.first.array![index].sentDate),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].sentTime == 0
                            ? ''
                            : dateTimeAJa(
                                listTrailingOrder.first.array![index].sentTime),
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Container(
                  height: 66.h,
                  alignment: Alignment.center,
                  child: Text(
                    formattaCurrun(
                        listTrailingOrder.first.array![index].executedPrice!),
                    maxLines: 1,
                    style: TextStyle(
                      color: putihop85,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].inputUser!,
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Text(
                        listTrailingOrder.first.array![index].withdrawBy!,
                        maxLines: 1,
                        style: TextStyle(
                          color: putihop85,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: index % 2 == 0 ? Colors.black : bgabu.withOpacity(0.6),
                height: 66.h,
                width: 0.25.sw,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 0.18.sw,
                            child: Text(
                              " ${listTrailingOrder.first.array![index].description!}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.05.sw,
                            child: listTrailingOrder
                                        .first.array![index].description ==
                                    ''
                                ? null
                                : GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              backgroundColor: foregroundwidget,
                                              title: Center(
                                                child: Text(
                                                  "Description!",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                              content: Text(
                                                "${listTrailingOrder.first.array![index].description}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.blue,
                                      size: 16.sp,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 33.h,
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 0.18.sw,
                            child: Text(
                              " ${listTrailingOrder.first.array![index].resultNote!}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.05.sw,
                            child: listTrailingOrder
                                        .first.array![index].resultNote! ==
                                    ''
                                ? null
                                : GestureDetector(
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                              ),
                                              backgroundColor: foregroundwidget,
                                              title: Center(
                                                child: Text(
                                                  "Result Note!",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14.sp,
                                                  ),
                                                ),
                                              ),
                                              content: Text(
                                                "${listTrailingOrder.first.array![index].resultNote}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            );
                                          });
                                    },
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.blue,
                                      size: 16.sp,
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  });
}

const List<String> trailingListData = [
  'Status',
  'Command',
  'Stockcode',
  'Board',
  'Exec Price',
  'Volume',
  'Auto PS',
  'Drop Price',
  'Trailing Type',
  'Trailing Step',
  'Stop Price',
  'Trailing Price',
  'Start Date',
  'Due Date',
  'Order Date',
  'Order Time',
  'Send Date',
  'Send Time',
  'Executed Price',
  'Input User',
  'Withdraw By',
  'Description',
  'Result Note',
];

List<Widget> getHeaderWidget() {
  List<String> dataHeader = trailingListData.sublist(4);
  return [
    Row(
      children: [
        Container(
          color: foregroundwidget,
          height: 66.h,
          width: 0.1.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 66.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          color: foregroundwidget,
          height: 66.h,
          width: 0.25.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 33.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  trailingListData[0],
                  style: TextStyle(
                    color: putihop85,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                height: 33.h,
                alignment: Alignment.center,
                child: Text(
                  trailingListData[1],
                  style: TextStyle(
                    color: putihop85,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          color: foregroundwidget,
          height: 66.h,
          width: 0.25.sw,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 33.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  trailingListData[2],
                  style: TextStyle(
                    color: putihop85,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                height: 33.h,
                alignment: Alignment.center,
                child: Text(
                  trailingListData[3],
                  style: TextStyle(
                    color: putihop85,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[0],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[1],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[2],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[3],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[4],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[5],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[6],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[7],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[8],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[9],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[10],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[11],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[12],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[13],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Container(
        height: 66.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border(
          left: BorderSide(
            color: Colors.black,
            width: 1.w,
          ),
        )),
        child: Text(
          dataHeader[14],
          style: TextStyle(
            color: putihop85,
            fontSize: 12.sp,
          ),
        ),
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[15],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[16],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
    Container(
      color: foregroundwidget,
      height: 66.h,
      width: 0.25.sw,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ))),
            child: Text(
              dataHeader[17],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
          Container(
            height: 33.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border(
              left: BorderSide(
                color: Colors.black,
                width: 1.w,
              ),
            )),
            child: Text(
              dataHeader[18],
              style: TextStyle(
                color: putihop85,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    ),
  ];
}
