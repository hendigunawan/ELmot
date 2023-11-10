// ignore_for_file: constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:online_trading/core/rabbitmq/connection.controller.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/order/orderListReq.model.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
import 'package:online_trading/view/checkoutview/mainAmend.view.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/tabbar_view/tradingView/widget/streamlist.trading.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';
import 'package:searchfield/searchfield.dart';

List<RxBool> dataChack() {
  final data = Get.find<OrderListController>();

  List<RxBool> dataBool = List.generate(
      data.data.value.array == null ? 0 : data.data.value.array!.length,
      (index) => false.obs);
  return dataBool;
}

class OrderListController extends GetxController {
  RxString type = 'ALL'.obs;
  RxString status = 'ALL'.obs;
  Rx<OrderList> data = OrderList().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  List<SearchFieldListItem> dataSearch() {
    if (data.value.array == null || data.value.array!.isEmpty) return [];
    List<String> datas = [];
    for (var dat in data.value.array!) {
      if (datas.isEmpty) datas.add(dat.stockCode!);
      if ((datas.firstWhereOrNull((element) => element == dat.stockCode)) ==
          null) {
        datas.add(dat.stockCode!);
      }
    }
    return datas
        .map(
          (e) => SearchFieldListItem(
            e,
            item: e,
            child: Padding(
              padding: EdgeInsets.all(8.w),
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: FontSizes.size11,
                ),
              ),
            ),
          ),
        )
        .toList();
  }
}

enum Type { ALL, BUY, SELL }

enum Status {
  ALL,
  REJECTED,
  OPEN,
  MATCHED,
  AMENDING,
  WITHDRAWING,
  WITHDRAWN,
  AMENDED
}

void checkAll(List<RxBool> checkboxes) {
  for (var checkbox in checkboxes) {
    checkbox.value = true;
  }
}

void uncheckAll(List<RxBool> checkboxes) {
  for (var checkbox in checkboxes) {
    checkbox.value = false;
  }
}

RxBool iconSelected = false.obs;

class MainOrderListHome extends StatelessWidget {
  const MainOrderListHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainOrderList();
  }
}

class MainOrderList extends GetView<OrderListController> {
  const MainOrderList({super.key});
  @override
  Widget build(BuildContext context) {
    controller.data.value = OrderList();
    return WillPopScope(
      onWillPop: () async {
        controller.data.value = OrderList();
        Get.put(PinSave()).onPop();
        Get.back();
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: PreferredSize(
            preferredSize: Size(double.infinity, 40.h),
            child: AppBar(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              title: Text(
                'Order List',
                style:
                    TextStyle(color: Colors.white, fontSize: FontSizes.size16),
              ),
              centerTitle: true,
              leading: GestureDetector(
                onTap: () {
                  controller.data.value = OrderList();
                  Get.put(PinSave()).onPop();
                  Get.back();
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 22.sp,
                ),
              ),
            ),
          ),
          body: Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10.h),
            child: Column(
              children: [
                Pin.show(
                  onComplete: (a) {
                    OrderMassage.orderListReq(
                      a,
                      accountId.value == ''
                          ? Get.find<LoginOrderController>()
                              .order!
                              .value
                              .account!
                              .first
                              .accountId!
                          : accountId.value,
                    );
                    Get.find<PinSave>().pin.value = a;
                    fokusNode.unfocus();
                  },
                ),
                SizedBox(
                  height: 5.h,
                ),
                _bodyS(),
                bodyT(),
              ],
            ),
          ),
          extendBody: true,
        ),
      ),
    );
  }

  Widget popUpBoard() {
    return PopupMenuButton(
      constraints: BoxConstraints.tightFor(
        height: 100.h,
        width: 0.15.sw,
      ),
      position: PopupMenuPosition.under,
      color: foregroundwidget,
      itemBuilder: (value) => [
        PopupMenuItem(
          value: BoardOption.RG,
          child: Center(
            child: Text(
              'RG',
              style: TextStyle(
                fontSize: 12.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: BoardOption.TN,
          child: Center(
            child: Text(
              'TN',
              style: TextStyle(
                fontSize: 12.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: BoardOption.NG,
          child: Center(
            child: Text(
              'NG',
              style: TextStyle(
                fontSize: 12.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
      ],
      child: Container(
        margin: EdgeInsets.only(left: 3.w),
        alignment: Alignment.center,
        height: 22.h,
        width: 0.15.sw,
        decoration: BoxDecoration(
            color: putihop85, borderRadius: BorderRadius.circular(5.r)),
        child: Obx(() {
          return Text(
            Get.find<ControllerBoard>().boards.value,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: FontSizes.size12,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ),
      onSelected: (value) {
        switch (value) {
          case BoardOption.TN:
            Get.find<ControllerBoard>().boards.value = 'TN';
            break;
          case BoardOption.NG:
            Get.find<ControllerBoard>().boards.value = 'NG';
            break;
          default:
            Get.find<ControllerBoard>().boards.value = 'RG';
        }
      },
    );
  }

  Widget popUpType() {
    return PopupMenuButton(
      constraints: BoxConstraints.tightFor(
        height: 100.h,
        width: 0.17.sw,
      ),
      position: PopupMenuPosition.under,
      color: foregroundwidget,
      itemBuilder: (value) => [
        PopupMenuItem(
          value: Type.ALL,
          child: Center(
            child: Text(
              'ALL',
              style: TextStyle(
                fontSize: 12.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Type.BUY,
          child: Center(
            child: Text(
              'BUY',
              style: TextStyle(
                fontSize: 12.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Type.SELL,
          child: Center(
            child: Text(
              'SELL',
              style: TextStyle(
                fontSize: 12.sp,
                color: putihop85,
              ),
            ),
          ),
        )
      ],
      child: Container(
        alignment: Alignment.center,
        height: 22.h,
        width: 0.17.sw,
        decoration: BoxDecoration(
            color: putihop85, borderRadius: BorderRadius.circular(5.r)),
        child: Obx(() {
          return Text(
            controller.type.value,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: FontSizes.size12,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ),
      onSelected: (value) {
        switch (value) {
          case Type.BUY:
            controller.type.value = 'BUY';
            break;
          case Type.SELL:
            controller.type.value = 'SELL';
            break;
          default:
            controller.type.value = 'ALL';
        }
      },
    );
  }

  Widget popUpStatus() {
    return PopupMenuButton(
      constraints: BoxConstraints.tightFor(
        height: 150.h,
        width: 0.3.sw,
      ),
      position: PopupMenuPosition.under,
      color: foregroundwidget,
      itemBuilder: (value) => [
        PopupMenuItem(
          value: Status.ALL,
          child: Center(
            child: Text(
              'ALL',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.AMENDED,
          child: Center(
            child: Text(
              'AMENDED',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.AMENDING,
          child: Center(
            child: Text(
              'AMENDING',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.MATCHED,
          child: Center(
            child: Text(
              'MATCHED',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.OPEN,
          child: Center(
            child: Text(
              'OPEN',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.REJECTED,
          child: Center(
            child: Text(
              'REJECTED',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.WITHDRAWING,
          child: Center(
            child: Text(
              'WITHDRAWING',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
        PopupMenuItem(
          value: Status.WITHDRAWN,
          child: Center(
            child: Text(
              'WITHDRAWN',
              style: TextStyle(
                fontSize: 11.sp,
                color: putihop85,
              ),
            ),
          ),
        ),
      ],
      child: Container(
        alignment: Alignment.center,
        height: 22.h,
        width: 0.3.sw,
        decoration: BoxDecoration(
            color: putihop85, borderRadius: BorderRadius.circular(5.r)),
        child: Obx(() {
          return Text(
            controller.status.value,
            style: TextStyle(
              color: Colors.black.withOpacity(0.8),
              fontSize: FontSizes.size12,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
      ),
      onSelected: (value) {
        switch (value) {
          case Status.AMENDED:
            controller.status.value = 'AMENDED';
            break;
          case Status.AMENDING:
            controller.status.value = 'AMENDING';
            break;
          case Status.MATCHED:
            controller.status.value = 'MATCHED';
            break;
          case Status.OPEN:
            controller.status.value = 'OPEN';
            break;
          case Status.REJECTED:
            controller.status.value = 'REJECTED';
            break;
          case Status.WITHDRAWING:
            controller.status.value = 'WITHDRAWING';
            break;
          case Status.WITHDRAWN:
            controller.status.value = 'WITHDRAWN';
            break;
          default:
            controller.status.value = 'ALL';
        }
      },
    );
  }

  Widget searchOrderList() {
    return ObxValue(
      (p) {
        return SearchField(
          searchInputDecoration: InputDecoration(
            border: InputBorder.none,
            hintStyle: TextStyle(
              color: Colors.black.withOpacity(
                0.8,
              ),
              fontSize: FontSizes.size11,
            ),
          ),
          hint: 'Search StockCode',

          suggestions: controller.dataSearch(),
          // focusNode: FocusNode(),
          searchStyle: TextStyle(
            color: Colors.black,
            fontSize: FontSizes.size11,
            textBaseline: TextBaseline.alphabetic,
          ),
          suggestionState: Suggestion.hidden,
          suggestionAction: SuggestionAction.unfocus,
          suggestionsDecoration: SuggestionDecoration(
            color: bgabu,
          ),
        );
      },
      controller.data,
    );
  }

  Widget _bodyS() {
    return Container(
      margin: EdgeInsets.only(left: 5.w),
      child: Column(
        children: [
          Row(
            children: [
              popUpBoard(),
              SizedBox(
                width: 10.w,
              ),
              popUpType(),
              SizedBox(
                width: 10.w,
              ),
              popUpStatus(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 0.5.sw,
                height: 25.h,
                padding: EdgeInsets.only(left: 10.w, top: 10.h),
                margin: EdgeInsets.only(top: 10.h),
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: putihop85, borderRadius: BorderRadius.circular(5.r)),
                child: Center(
                  child: searchOrderList(),
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              SizedBox(
                height: 25.h,
                width: 0.27.sw,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    print("Ini datanya:");
                    for (int i = 0; i < datsaa.length; i++) {
                      print("Data ${i + 1} = ${datsaa[i]}");
                    }
                  },
                  child: Center(
                    child: Text(
                      "Withdraw",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: FontSizes.size11,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

List<RxBool> datsaa = [];
Widget bodyT({bool type = true}) {
  var controller = Get.put(OrderListController());
  var controllerBody = Get.put(BodyController());
  Color color = foregroundwidget;

  List<RxBool>? datsa = [];
  return Expanded(
    child: Container(
      margin: EdgeInsets.only(top: 8.h),
      child: Obx(() {
        datsa = dataChack();
        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: HorizontalDataTable(
              leftHandSideColumnWidth: type ? 0.4.sw : 0.3.sw,
              rightHandSideColumnWidth: 0.98.sw,
              leftHandSideColBackgroundColor: Colors.transparent,
              rightHandSideColBackgroundColor: Colors.transparent,
              isFixedHeader: true,
              itemCount: controller.data.value.array == null
                  ? 0
                  : controller.data.value.array!.length,
              headerWidgets: [
                Row(
                  children: [
                    type
                        ? Container(
                            height: 66.h,
                            width: 0.1.sw,
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 66.h,
                                  width: 0.2.sw,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: color,
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.black,
                                        width: 1.w,
                                      ),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.data.value.array == null
                                          ? null
                                          : iconSelected.toggle();
                                      if (iconSelected.value) {
                                        checkAll(datsa!);
                                        datsaa = datsa!;
                                      } else {
                                        uncheckAll(datsa!);
                                      }
                                    },
                                    child: FittedBox(
                                      child: Obx(
                                        () {
                                          if (iconSelected.value) {
                                            return const Icon(
                                              Icons.check_box_rounded,
                                              color: Colors.blue,
                                            );
                                          } else {
                                            return const Icon(
                                              Icons.square_rounded,
                                              color: Colors.white,
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                      height: 66.h,
                      width: 0.1.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            width: 0.2.sw,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: color,
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: 1.w,
                                  ),
                                )),
                          ),
                          Container(
                            height: 33.h,
                            width: 0.2.sw,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: color,
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: 1.w,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 66.h,
                      width: 0.2.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            width: 0.2.sw,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: color,
                                border: Border(
                                    bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.w,
                                ))),
                            child: Text(
                              'Type',
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            width: 0.2.sw,
                            alignment: Alignment.center,
                            color: color,
                            child: Text(
                              'Code',
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
                  height: 66.h,
                  width: 0.23.sw,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 33.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color,
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
                          'Status',
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
                            color: color,
                            border: Border(
                              left: BorderSide(
                                color: Colors.black,
                                width: 1.w,
                              ),
                            )),
                        child: Text(
                          'Board',
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
                  height: 66.h,
                  width: 0.25.sw,
                  alignment: Alignment.center,
                  color: color,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 33.h,
                        width: 0.25.sw,
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
                          'Price',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: 33.h,
                        width: 0.25.sw,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color,
                            border: Border(
                              left: BorderSide(
                                color: Colors.black,
                                width: 1.w,
                              ),
                            )),
                        child: Text(
                          'Qty',
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
                  height: 66.h,
                  width: 0.25.sw,
                  alignment: Alignment.center,
                  color: foregroundwidget,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 33.h,
                        width: 0.25.sw,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color,
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
                          'Order Time',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: 33.h,
                        width: 0.25.sw,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color,
                            border: Border(
                              left: BorderSide(
                                color: Colors.black,
                                width: 1.w,
                              ),
                            )),
                        child: Text(
                          'Input User',
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
                  height: 66.h,
                  width: 0.25.sw,
                  alignment: Alignment.center,
                  color: foregroundwidget,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 33.h,
                        width: 0.25.sw,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color,
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
                          'Done Qty',
                          style: TextStyle(
                            color: putihop85,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      Container(
                        height: 33.h,
                        width: 0.25.sw,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: color,
                            border: Border(
                              left: BorderSide(
                                color: Colors.black,
                                width: 1.w,
                              ),
                            )),
                        child: Text(
                          'Rest Qty',
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
              leftSideItemBuilder: (context, index) => Obx(
                    () {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: controller.data.value.array == null ||
                                controller.data.value.array!.isEmpty
                            ? []
                            : [
                                type
                                    ? Container(
                                        height: 66.h,
                                        width: 0.1.sw,
                                        alignment: Alignment.center,
                                        color: index % 2 == 0
                                            ? Colors.black
                                            : bgabu.withOpacity(0.6),
                                        child: Checkbox(
                                          fillColor:
                                              MaterialStateColor.resolveWith(
                                                  (states) {
                                            if (states.contains(
                                                MaterialState.selected)) {
                                              return Colors.blue;
                                            }
                                            return Colors.white;
                                          }),
                                          checkColor: Colors.black,
                                          value: datsa![index].value,
                                          onChanged: (v) {
                                            datsa![index].value = v!;
                                            datsa![index].refresh();
                                            var data = datsa;
                                            print(data);
                                          },
                                        ),
                                      )
                                    : const Text(''),
                                controller.data.value.array![index]
                                            .orderStatus ==
                                        1
                                    ? Container(
                                        height: 66.h,
                                        width: 0.1.sw,
                                        alignment: Alignment.center,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                ActivityRequest
                                                    .parameterRequest(
                                                        requestFlag: 1);

                                                Get.find<ControllerHandelSUB>()
                                                    .unBind();
                                                ActivityRequest.quoteRequest(
                                                  packageId: Constans
                                                      .PACKAGE_ID_QUOTES,
                                                  commant: 1,
                                                  arrayStockCode: [
                                                    ArrayStockCode(
                                                      stockCode: controller
                                                          .data
                                                          .value
                                                          .array![index]
                                                          .stockCode!,
                                                      board: Get.put(
                                                              ControllerBoard())
                                                          .boards
                                                          .value,
                                                    )
                                                  ],
                                                );
                                                ActivityRequest
                                                    .orderBookRequest(
                                                  packageId: Constans
                                                      .PACKAGE_ID_ORDER_BOOK,
                                                  stockCode: controller
                                                      .data
                                                      .value
                                                      .array![index]
                                                      .stockCode!,
                                                  board:
                                                      Get.put(ControllerBoard())
                                                          .boards
                                                          .value,
                                                  commant: "1",
                                                );
                                                controllerBody
                                                        .priceController.text =
                                                    formattaCurrun(controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .price!);
                                                controllerBody
                                                        .qtyController.text =
                                                    formattaCurrun(((controller
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .oVolume! -
                                                            controller
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .tVolume!) ~/
                                                        Get.find<
                                                                LoginOrderController>()
                                                            .order!
                                                            .value
                                                            .lot!));
                                                controllerBody
                                                        .boardController.text =
                                                    controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .boardMarketCode!;
                                                controllerBody.bOrSController
                                                    .text = controller
                                                            .data
                                                            .value
                                                            .array![index]
                                                            .command! ==
                                                        1
                                                    ? 'SELL'
                                                    : 'BUY';
                                                controllerBody
                                                        .idxIdController.text =
                                                    controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .idxOrderId!;
                                                controllerBody.orderIdController
                                                        .text =
                                                    controller.data.value
                                                        .array![index].orderId!;
                                                controllerBody.accountId.text =
                                                    controller
                                                        .data.value.accountId!;
                                                types.value = 'AMEND';
                                                Navigator.pushNamed(
                                                  context,
                                                  '/goCheckoutviewAmendAndWD',
                                                  arguments: <String, String>{
                                                    'prevP':
                                                        "${ObjectBoxDatabase.quotesBox.query(Quotes_.stockCode.equals(controller.data.value.array![index].stockCode!)).build().findFirst()!.prevPrice!}",
                                                    'title':
                                                        '${controller.data.value.array![index].stockCode}',
                                                    'subtitle': '',
                                                    'board': Get.put(
                                                            ControllerBoard())
                                                        .boards
                                                        .value,
                                                    'typeCheckout': "AMEND",
                                                    'isFormC': '1'
                                                  },
                                                );
                                              },
                                              // onTap: () {
                                              //   ActivityRequest
                                              //       .parameterRequest(
                                              //           requestFlag: 1);

                                              //   Get.find<ControllerHandelSUB>()
                                              //       .unBind();
                                              //   ActivityRequest.quoteRequest(
                                              //     packageId: Constans
                                              //         .PACKAGE_ID_QUOTES,
                                              //     commant: 1,
                                              //     arrayStockCode: [
                                              //       ArrayStockCode(
                                              //         stockCode: controller
                                              //             .data
                                              //             .value
                                              //             .array![index]
                                              //             .stockCode!,
                                              //         board: Get.find<
                                              //                 ControllerBoard>()
                                              //             .boards
                                              //             .value,
                                              //       )
                                              //     ],
                                              //   );
                                              //   ActivityRequest
                                              //       .orderBookRequest(
                                              //     packageId: Constans
                                              //         .PACKAGE_ID_ORDER_BOOK,
                                              //     stockCode: controller
                                              //         .data
                                              //         .value
                                              //         .array![index]
                                              //         .stockCode!,
                                              //     board: Get.find<
                                              //             ControllerBoard>()
                                              //         .boards
                                              //         .value,
                                              //     commant: "1",
                                              //   );
                                              //   var query = ObjectBoxDatabase
                                              //       .quotesBox
                                              //       .query(Quotes_.stockCode
                                              //               .equals(controller
                                              //                   .data
                                              //                   .value
                                              //                   .array![index]
                                              //                   .stockCode!) &
                                              //           Quotes_.board.equals(
                                              //               Get.find<
                                              //                       ControllerBoard>()
                                              //                   .boards
                                              //                   .value))
                                              //       .build()
                                              //       .findFirst();
                                              //   Navigator.pushNamed(
                                              //     context,
                                              //     '/goCheckoutviewAmendAndWD',
                                              //     arguments: <String, String>{
                                              //       'prevP':
                                              //           "${query!.prevPrice}",
                                              //       'title': controller
                                              //           .data
                                              //           .value
                                              //           .array![index]
                                              //           .stockCode!,
                                              //       'board': Get.find<
                                              //               ControllerBoard>()
                                              //           .boards
                                              //           .value,
                                              //       'typeCheckout': "AMEND",
                                              //       'idxID': controller
                                              //           .data
                                              //           .value
                                              //           .array![index]
                                              //           .orderId!,
                                              //     },
                                              //   );
                                              // },
                                              child: Container(
                                                height: 33.h,
                                                width: 0.1.sw,
                                                alignment: Alignment.center,
                                                color: index % 2 == 0
                                                    ? Colors.black
                                                    : bgabu.withOpacity(0.6),
                                                child: Text(
                                                  "A",
                                                  style: TextStyle(
                                                    color: Colors.amber,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                ActivityRequest
                                                    .parameterRequest(
                                                        requestFlag: 1);

                                                Get.find<ControllerHandelSUB>()
                                                    .unBind();
                                                ActivityRequest.quoteRequest(
                                                  packageId: Constans
                                                      .PACKAGE_ID_QUOTES,
                                                  commant: 1,
                                                  arrayStockCode: [
                                                    ArrayStockCode(
                                                      stockCode: controller
                                                          .data
                                                          .value
                                                          .array![index]
                                                          .stockCode!,
                                                      board: Get.put(
                                                              ControllerBoard())
                                                          .boards
                                                          .value,
                                                    )
                                                  ],
                                                );
                                                ActivityRequest
                                                    .orderBookRequest(
                                                  packageId: Constans
                                                      .PACKAGE_ID_ORDER_BOOK,
                                                  stockCode: controller
                                                      .data
                                                      .value
                                                      .array![index]
                                                      .stockCode!,
                                                  board:
                                                      Get.put(ControllerBoard())
                                                          .boards
                                                          .value,
                                                  commant: "1",
                                                );
                                                controllerBody
                                                        .priceController.text =
                                                    formattaCurrun(controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .price!);
                                                controllerBody
                                                        .qtyController.text =
                                                    formattaCurrun(((controller
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .oVolume! -
                                                            controller
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .tVolume!) ~/
                                                        Get.find<
                                                                LoginOrderController>()
                                                            .order!
                                                            .value
                                                            .lot!));
                                                controllerBody
                                                        .boardController.text =
                                                    controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .boardMarketCode!;
                                                controllerBody.bOrSController
                                                    .text = controller
                                                            .data
                                                            .value
                                                            .array![index]
                                                            .command! ==
                                                        1
                                                    ? 'SELL'
                                                    : 'BUY';
                                                controllerBody
                                                        .idxIdController.text =
                                                    controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .idxOrderId!;
                                                controllerBody.orderIdController
                                                        .text =
                                                    controller.data.value
                                                        .array![index].orderId!;
                                                controllerBody.accountId.text =
                                                    controller
                                                        .data.value.accountId!;
                                                types.value = 'WITHDRAWN';
                                                Navigator.pushNamed(
                                                  context,
                                                  '/goCheckoutviewAmendAndWD',
                                                  arguments: <String, String>{
                                                    'prevP':
                                                        "${ObjectBoxDatabase.quotesBox.query(Quotes_.stockCode.equals(controller.data.value.array![index].stockCode!)).build().findFirst()!.prevPrice!}",
                                                    'title':
                                                        '${controller.data.value.array![index].stockCode}',
                                                    'subtitle': '',
                                                    'board': Get.put(
                                                            ControllerBoard())
                                                        .boards
                                                        .value,
                                                    'typeCheckout': "WITHDRAWN",
                                                    'isFormC': '1'
                                                  },
                                                );
                                              },
                                              // onTap: () {
                                              //   ActivityRequest
                                              //       .parameterRequest(
                                              //           requestFlag: 1);

                                              //   Get.find<ControllerHandelSUB>()
                                              //       .unBind();
                                              //   ActivityRequest.quoteRequest(
                                              //     packageId: Constans
                                              //         .PACKAGE_ID_QUOTES,
                                              //     commant: 1,
                                              //     arrayStockCode: [
                                              //       ArrayStockCode(
                                              //         stockCode: controller
                                              //             .data
                                              //             .value
                                              //             .array![index]
                                              //             .stockCode!,
                                              //         board: Get.find<
                                              //                 ControllerBoard>()
                                              //             .boards
                                              //             .value,
                                              //       )
                                              //     ],
                                              //   );
                                              //   ActivityRequest
                                              //       .orderBookRequest(
                                              //     packageId: Constans
                                              //         .PACKAGE_ID_ORDER_BOOK,
                                              //     stockCode: controller
                                              //         .data
                                              //         .value
                                              //         .array![index]
                                              //         .stockCode!,
                                              //     board: Get.find<
                                              //             ControllerBoard>()
                                              //         .boards
                                              //         .value,
                                              //     commant: "1",
                                              //   );
                                              //   var query = ObjectBoxDatabase
                                              //       .quotesBox
                                              //       .query(Quotes_.stockCode
                                              //               .equals(controller
                                              //                   .data
                                              //                   .value
                                              //                   .array![index]
                                              //                   .stockCode!) &
                                              //           Quotes_.board.equals(
                                              //               Get.find<
                                              //                       ControllerBoard>()
                                              //                   .boards
                                              //                   .value))
                                              //       .build()
                                              //       .findFirst();
                                              //   Navigator.pushNamed(
                                              //     context,
                                              //     '/goCheckoutviewAmendAndWD',
                                              //     arguments: <String, String>{
                                              //       'prevP':
                                              //           "${query!.prevPrice}",
                                              //       'title': controller
                                              //           .data
                                              //           .value
                                              //           .array![index]
                                              //           .stockCode!,
                                              //       'board': Get.find<
                                              //               ControllerBoard>()
                                              //           .boards
                                              //           .value,
                                              //       'typeCheckout': "WITHDRAW",
                                              //       'idxID': controller
                                              //           .data
                                              //           .value
                                              //           .array![index]
                                              //           .orderId!,
                                              //     },
                                              //   );
                                              // },
                                              child: Container(
                                                height: 33.h,
                                                width: 0.1.sw,
                                                alignment: Alignment.center,
                                                color: index % 2 == 0
                                                    ? Colors.black
                                                    : bgabu.withOpacity(0.6),
                                                child: Text(
                                                  "W",
                                                  style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 12.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : controller.data.value.array![index]
                                                .orderStatus ==
                                            0
                                        ? GestureDetector(
                                            onTap: () => OrderMassage
                                                .reqRejectedOrderMassage(
                                              orderID: controller.data.value
                                                  .array![index].orderId!,
                                              pin:
                                                  Get.find<PinSave>().pin.value,
                                              accountId: controller
                                                  .data.value.accountId!,
                                            ),
                                            child: Container(
                                              height: 66.h,
                                              width: 0.1.sw,
                                              color: index % 2 == 0
                                                  ? Colors.black
                                                  : bgabu.withOpacity(0.6),
                                              child: Icon(
                                                Icons.info_outline,
                                                color: Colors.blue,
                                                size: 15.sp,
                                              ),
                                            ),
                                          )
                                        : Container(
                                            height: 66.h,
                                            width: 0.1.sw,
                                            color: index % 2 == 0
                                                ? Colors.black
                                                : bgabu.withOpacity(0.6),
                                          ),
                                Container(
                                  height: 66.h,
                                  width: 0.2.sw,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 33.h,
                                        width: 0.2.sw,
                                        alignment: Alignment.center,
                                        color: index % 2 == 0
                                            ? Colors.black
                                            : bgabu.withOpacity(0.6),
                                        child: Text(
                                          controller.data.value.array![index]
                                                      .command ==
                                                  0
                                              ? "B"
                                              : controller
                                                          .data
                                                          .value
                                                          .array![index]
                                                          .command ==
                                                      1
                                                  ? "S"
                                                  : controller
                                                              .data
                                                              .value
                                                              .array![index]
                                                              .command ==
                                                          2
                                                      ? "M"
                                                      : controller
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .command ==
                                                              3
                                                          ? "SS"
                                                          : "",
                                          style: TextStyle(
                                              color: controller
                                                          .data
                                                          .value
                                                          .array![index]
                                                          .command ==
                                                      0
                                                  ? Colors.red
                                                  : controller
                                                              .data
                                                              .value
                                                              .array![index]
                                                              .command ==
                                                          1
                                                      ? Colors.green
                                                      : controller
                                                                  .data
                                                                  .value
                                                                  .array![index]
                                                                  .command ==
                                                              2
                                                          ? Colors.orange
                                                          : controller
                                                                      .data
                                                                      .value
                                                                      .array![
                                                                          index]
                                                                      .command ==
                                                                  3
                                                              ? Colors.blue
                                                              : null,
                                              fontSize: 11.sp),
                                        ),
                                      ),
                                      Container(
                                        height: 33.h,
                                        width: 0.2.sw,
                                        alignment: Alignment.center,
                                        color: index % 2 == 0
                                            ? Colors.black
                                            : bgabu.withOpacity(0.6),
                                        child: Text(
                                          controller.data.value.array![index]
                                              .stockCode
                                              .toString(),
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
                      );
                    },
                  ),
              rightSideItemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      height: 66.h,
                      width: 0.23.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () => OrderMassage.reqRejectedOrderMassage(
                              orderID:
                                  controller.data.value.array![index].orderId!,
                              pin: Get.find<PinSave>().pin.value,
                              accountId: controller.data.value.accountId!,
                            ),
                            child: Container(
                              height: 33.h,
                              color: index % 2 == 0
                                  ? Colors.black
                                  : bgabu.withOpacity(0.6),
                              alignment: Alignment.center,
                              child: Text(
                                controller.data.value.array![index]
                                            .orderStatus ==
                                        1
                                    ? 'Open'
                                    : controller.data.value.array![index]
                                                .orderStatus ==
                                            2
                                        ? 'Matched'
                                        : controller.data.value.array![index]
                                                    .orderStatus ==
                                                3
                                            ? 'Amending'
                                            : controller
                                                        .data
                                                        .value
                                                        .array![index]
                                                        .orderStatus ==
                                                    4
                                                ? 'Withdrawing'
                                                : controller
                                                            .data
                                                            .value
                                                            .array![index]
                                                            .orderStatus ==
                                                        5
                                                    ? 'Withdrawn'
                                                    : controller
                                                                .data
                                                                .value
                                                                .array![index]
                                                                .orderStatus ==
                                                            6
                                                        ? 'Amended'
                                                        : 'Rejected',
                                style: TextStyle(
                                  color: putihop85,
                                  fontSize: 11.sp,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            alignment: Alignment.center,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Text(
                              controller
                                  .data.value.array![index].boardMarketCode
                                  .toString(),
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 20.h,
                    //   width: 0.15.sw,
                    //   child: Align(
                    //     alignment: Alignment.center,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           controller.data.value.array![index]
                    //                       .orderStatus ==
                    //                   1
                    //               ? 'Open'
                    //               : controller.data.value.array![index]
                    //                           .command ==
                    //                       2
                    //                   ? 'Matched'
                    //                   : controller.data.value.array![index]
                    //                               .command ==
                    //                           3
                    //                       ? 'Amending'
                    //                       : controller
                    //                                   .data
                    //                                   .value
                    //                                   .array![index]
                    //                                   .command ==
                    //                               4
                    //                           ? 'Withdrawing'
                    //                           : controller
                    //                                       .data
                    //                                       .value
                    //                                       .array![index]
                    //                                       .command ==
                    //                                   5
                    //                               ? 'Withdrawn'
                    //                               : controller
                    //                                           .data
                    //                                           .value
                    //                                           .array![index]
                    //                                           .command ==
                    //                                       6
                    //                                   ? 'Amended'
                    //                                   : 'Rejected',
                    //           style: TextStyle(
                    //               color: putihop85, fontSize: 11.sp),
                    //           textAlign: TextAlign.center,
                    //         ),
                    //         controller.data.value.array![index].command == 0
                    //             ? const Icon(Icons.info_outline)
                    //             : Text(''),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            width: 0.25.sw,
                            alignment: Alignment.centerRight,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Text(
                              formattaCurrun(
                                  controller.data.value.array![index].price!),
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            width: 0.25.sw,
                            alignment: Alignment.centerRight,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Text(
                              formattaCurrun(
                                  controller.data.value.array![index].oVolume!),
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
                      height: 66.h,
                      width: 0.25.sw,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            width: 0.25.sw,
                            alignment: Alignment.center,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Text(
                              formatJam(controller
                                      .data.value.array![index].orderTime
                                      .toString())
                                  .replaceAll(RegExp(r' '), ''),
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            width: 0.25.sw,
                            alignment: Alignment.center,
                            color: index % 2 == 0
                                ? Colors.black
                                : bgabu.withOpacity(0.6),
                            child: Text(
                              controller.data.value.array![index].inputUser
                                  .toString(),
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
                      padding: EdgeInsets.only(right: 5.w),
                      height: 66.h,
                      width: 0.25.sw,
                      color: index % 2 == 0
                          ? Colors.black
                          : bgabu.withOpacity(0.6),
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 33.h,
                            width: 0.25.sw,
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  controller.data.value.array![index].tVolume!),
                              style: TextStyle(
                                color: putihop85,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          Container(
                            height: 33.h,
                            width: 0.25.sw,
                            alignment: Alignment.centerRight,
                            child: Text(
                              formattaCurrun(
                                  controller.data.value.array![index].rVolume!),
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
                );
              }),
        );
      }),
    ),
  );
}
