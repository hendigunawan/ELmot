// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, unrelated_type_equality_checks, camel_case_types, non_constant_identifier_names, constant_identifier_names, void_checks
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
// import 'package:horizontal_data_table/horizontal_data_table.dart';
// import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
// import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/objectbox.g.dart';
// import 'package:online_trading/view/bottomnavbar/menu/tradeviewdetail/trade_view.dart';
// import 'package:online_trading/view/checkoutview/mainchechout_view.dart';
// import 'package:online_trading/view/checkoutview/orderList/orderList.main.dart';
// import 'package:online_trading/view/checkoutview/tradelist/widget/widget.tradelist.dart';
// import 'package:online_trading/view/checkoutview/widgetcheckout/new_OrderSell.widget.dart';
// import 'package:online_trading/view/tabbar_view/tradingView/widget/streamlist.trading.dart';
// import 'package:online_trading/view/widget/notifikasi_popup.dart';
// import 'package:online_trading/view/widget/table/main_table.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/ordering/controllerGetx/loginOrder.controler.dart';
import 'package:online_trading/module/ordering/massage/activity_massage.order.dart';
import 'package:online_trading/module/ordering/model/info/stock_balance.model.dart';
import 'package:online_trading/module/ordering/model/order/reqOrder.model.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/widget_stock_balanace.dart';
import 'package:online_trading/view/widget/formattacurrency.dart';
import 'package:online_trading/view/widget/pin/pin.widget.dart';

// class LotDetail extends StatefulWidget {
//   int prevpp;
//   final String types;
//   final String stockCode;
//   LotDetail({
//     Key? key,
//     required this.prevpp,
//     this.types = 'BUY',
//     required this.stockCode,
//   }) : super(key: key);

//   @override
//   State<LotDetail> createState() => _LotDetailState();
// }

// class _LotDetailState extends State<LotDetail> {
//   final body = Get.put(BodyController());
//   final back = Get.put(Back());
//   String title = '';

//   @override
//   void initState() {
//     if (body.qtyController.text == '') body.qtyController.text = '0';

//     // priceController.clear();
//     // body.onClear();
//     back.type.value = widget.types;
//     ActivityRequest.parameterRequest(requestFlag: 1);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Container(
//           constraints: BoxConstraints(
//             maxHeight: !isMore.value ? 220.h : 350.h,
//             maxWidth: 0.9.sw,
//           ),
//           padding: EdgeInsets.all(5.w),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.circular(7.r),
//             border: Border.all(
//               width: 0.5.w,
//               color: Colors.grey.withOpacity(0.5),
//             ),
//           ),
//           child: Column(
//             children: [
//               _body(
//                 title: title == '' ? widget.stockCode : title,
//                 type: widget.types,
//               ),
//               _bottom(widget.types, context, widget.prevpp, (a) {
//                 if (a != widget.stockCode) {
//                   setState(() {
//                     title = a;
//                   });
//                 }
//               }),
//             ],
//           ));
//     });
//   }
// }

RxBool isMore = false.obs;
// final keyForm = GlobalKey<FormState>();

// class _body extends GetView<BodyController> {
//   final controllerBuilding = Get.put(BuildingMassageOrder());

//   String type;
//   String title;
//   _body({required this.type, required this.title});
//   @override
//   Widget build(BuildContext context) {
//     if (type == 'AMEND') return const Amend();
//     return BuyAndSell(
//       controller: controller,
//       type: type,
//       title: title,
//     );
//   }
// }

// class Amend extends StatelessWidget {
//   const Amend({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//     );
//   }
// }

// class BuyAndSell extends StatelessWidget {
//   const BuyAndSell({
//     super.key,
//     required this.controller,
//     required this.type,
//     required this.title,
//   });

//   final String type;
//   final BodyController controller;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//         child: Column(
//       children: [
//         SizedBox(
//           height: 4.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'Price: ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: FontSizes.size11,
//               ),
//             ),
//             Container(
//               width: 0.385.sw,
//               height: 26.h,
//               margin: EdgeInsets.only(
//                 bottom: 3.h,
//               ),
//               child: TextField(
//                 maxLength: 9,
//                 textAlign: TextAlign.right,
//                 textAlignVertical: TextAlignVertical.center,
//                 controller: controller.priceController,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                   CurrencyInputFormatter(
//                     thousandSeparator: ThousandSeparator.Comma,
//                     mantissaLength: 0,
//                   ),
//                 ],
//                 onTap: () {
//                   controller.priceController.text = controller
//                       .priceController.text
//                       .replaceAll(RegExp(r','), '');
//                   controller.priceController.selection = TextSelection(
//                     baseOffset: 0,
//                     extentOffset: controller.priceController.value.text.length,
//                   );
//                 },
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.zero,
//                   filled: true,
//                   counterText: '',
//                   fillColor: Colors.white.withOpacity(0.25),
//                   border: const OutlineInputBorder(),
//                   suffixIcon: SizedBox(
//                     width: 0.12.sw,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         GestureDetector(
//                           child: Icon(
//                             Icons.remove,
//                             color: Colors.white,
//                             size: 18.sp,
//                           ),
//                           onTap: () {
//                             var priceReg = controller.priceController.text
//                                 .replaceAll(RegExp(r','), '');
//                             if (Get.find<PinSave>()
//                                     .limit
//                                     .value
//                                     .remainTradingLimit ==
//                                 null) {
//                               NotifikasiPopup.show("Please Insert Pin");
//                               return;
//                             }
//                             int frac = controller.fraksiPrice(
//                                 (int.parse(priceReg) - 1).toString());
//                             controller.priceController.text =
//                                 formattaCurrun(int.parse(priceReg) - frac);
//                             controller.stockEstimasiData.value =
//                                 controller.stockEstimasi();
//                           },
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             var priceReg = controller.priceController.text
//                                 .replaceAll(RegExp(r','), '');
//                             if (Get.find<PinSave>()
//                                     .limit
//                                     .value
//                                     .remainTradingLimit ==
//                                 null) {
//                               NotifikasiPopup.show("Please Insert Pin");
//                               return;
//                             }

//                             int frac = controller.fraksiPrice(
//                               (int.parse(priceReg) + 1).toString(),
//                             );
//                             controller.priceController.text =
//                                 formattaCurrun(int.parse(priceReg) + frac);
//                             controller.stockEstimasiData.value =
//                                 controller.stockEstimasi();
//                           },
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.white,
//                             size: 18.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 maxLines: 1,
//                 textDirection: TextDirection.ltr,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: FontSizes.size12,
//                 ),
//                 onChanged: (a) => a,
//               ),
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () => Get.find<PinSave>().limit.value.cashonT3 == null
//                   ? NotifikasiPopup.show("Please Insert Pin")
//                   : controller.max(
//                       true,
//                       int.parse(controller.priceController.text
//                           .replaceAll(RegExp(r','), '')),
//                       0,
//                     ),
//               child: Container(
//                 width: 0.17.sw,
//                 height: 26.h,
//                 margin: EdgeInsets.only(bottom: 3.h, right: 5.w),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(
//                     3.r,
//                   ),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Max Cash',
//                   style: TextStyle(
//                     color: putihop85,
//                     fontSize: FontSizes.size11,
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               onTap: () =>
//                   Get.find<PinSave>().limit.value.remainTradingLimit == null
//                       ? NotifikasiPopup.show("Please Insert Pin")
//                       : controller.max(
//                           true,
//                           int.parse(controller.priceController.text
//                               .replaceAll(RegExp(r','), '')),
//                           1,
//                         ),
//               child: Container(
//                 width: 0.17.sw,
//                 height: 26.h,
//                 margin: EdgeInsets.only(
//                   bottom: 3.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(
//                     3.r,
//                   ),
//                 ),
//                 alignment: Alignment.center,
//                 child: Text(
//                   'Max Limit',
//                   style: TextStyle(
//                     color: putihop85,
//                     fontSize: FontSizes.size11,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               'QTY :  ',
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: FontSizes.size11,
//               ),
//             ),
//             Container(
//               width: 0.385.sw,
//               height: 26.h,
//               margin: EdgeInsets.only(
//                 bottom: 3.h,
//               ),
//               padding: EdgeInsets.zero,
//               child: TextField(
//                 onTap: () {
//                   controller.qtyController.text = controller.qtyController.text
//                       .replaceAll(RegExp(r','), '');
//                   controller.qtyController.selection = TextSelection(
//                     baseOffset: 0,
//                     extentOffset: controller.qtyController.value.text.length,
//                   );
//                 },
//                 maxLength: 9,
//                 textAlign: TextAlign.right,
//                 controller: controller.qtyController,
//                 inputFormatters: [
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                   CurrencyInputFormatter(
//                     thousandSeparator: ThousandSeparator.Comma,
//                     mantissaLength: 0,
//                   ),
//                 ],
//                 decoration: InputDecoration(
//                   contentPadding: EdgeInsets.zero,
//                   counterText: '',
//                   filled: true,
//                   fillColor: Colors.white.withOpacity(0.25),
//                   border: const OutlineInputBorder(),
//                   suffixIcon: SizedBox(
//                     width: 0.12.sw,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         GestureDetector(
//                           child: Icon(
//                             Icons.remove,
//                             color: Colors.white,
//                             size: 18.sp,
//                           ),
//                           onTap: () {
//                             if (Get.find<PinSave>()
//                                     .limit
//                                     .value
//                                     .remainTradingLimit ==
//                                 null) {
//                               NotifikasiPopup.show("Please Insert Pin");
//                               return;
//                             }
//                             controller.qtyController.text == '0'
//                                 ? null
//                                 : controller.qtyController.text =
//                                     (int.parse(controller.qtyController.text) -
//                                             1)
//                                         .toString();
//                             controller.stockEstimasiData.value =
//                                 controller.stockEstimasi();
//                           },
//                         ),
//                         GestureDetector(
//                           onTap: () {
//                             if (Get.find<PinSave>()
//                                     .limit
//                                     .value
//                                     .remainTradingLimit ==
//                                 null) {
//                               NotifikasiPopup.show("Please Insert Pin");
//                               return;
//                             }
//                             controller.qtyController.text =
//                                 (int.parse(controller.qtyController.text) + 1)
//                                     .toString();
//                             controller.stockEstimasiData.value =
//                                 controller.stockEstimasi();
//                           },
//                           child: Icon(
//                             Icons.add,
//                             color: Colors.white,
//                             size: 18.sp,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 maxLines: 1,
//                 textDirection: TextDirection.ltr,
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: FontSizes.size12,
//                 ),
//                 onChanged: (a) => a,
//               ),
//             ),
//             const Spacer(),
//             GestureDetector(
//               onTap: () {
//                 isMore.toggle();
//                 isMore.refresh();
//               },
//               child: Container(
//                 width: 0.355.sw,
//                 height: 26.h,
//                 margin: EdgeInsets.only(
//                   bottom: 3.h,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(
//                     5.r,
//                   ),
//                 ),
//                 alignment: Alignment.center,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.settings,
//                       color: putihop85,
//                       size: 18.sp,
//                     ),
//                     SizedBox(
//                       width: 3.w,
//                     ),
//                     Text(
//                       !isMore.value ? 'Advance Option' : 'Minimize Option',
//                       style: TextStyle(
//                         color: putihop85,
//                         fontSize: FontSizes.size11,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//         SizedBox(
//           height: 5.h,
//         ),
//         Container(
//           margin: EdgeInsets.only(right: 5.5.w, left: 5.5.w),
//           child: Obx(() {
//             return Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 type == "SELL"
//                     ? GestureDetector(
//                         onTap: Get.find<PinSave>().pin.value == ''
//                             ? () => NotifikasiPopup.show("Please Insert Pin")
//                             : () {
//                                 OrderMassage.stockBalance(
//                                   pin: Get.find<PinSave>().pin.value,
//                                   accountId: accountId.value == ''
//                                       ? Get.find<LoginOrderController>()
//                                           .order!
//                                           .value
//                                           .account!
//                                           .first
//                                           .accountId!
//                                       : accountId.value,
//                                 );
//                                 showStockbalance();
//                               },
//                         child: Container(
//                           constraints: BoxConstraints.expand(
//                             width: 0.3.sw,
//                             height: 27.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.blue.withOpacity(0.25),
//                             borderRadius: BorderRadius.circular(3.r),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             'Stock Balance',
//                             style: TextStyle(
//                               color: putihop85,
//                               fontSize: FontSizes.size11,
//                             ),
//                           ),
//                         ),
//                       )
//                     : Container(),
//                 SizedBox(
//                   width: 0.5.sw,
//                   child: _Switch(
//                     onToggle: (a) {
//                       if (Get.find<PinSave>().limit.value.remainTradingLimit ==
//                           null) {
//                         NotifikasiPopup.show("Please Insert Pin");
//                         return;
//                       }
//                       controller.sameOrder.value = a;
//                       controller.sameOrder.refresh();
//                     },
//                     value: controller.sameOrder.value,
//                     title: 'Prevent Same Order',
//                   ),
//                 ),
//               ],
//             );
//           }),
//         ),
//         !isMore.value
//             ? Container()
//             : Expanded(
//                 child: Container(
//                   alignment: Alignment.center,
//                   margin: EdgeInsets.only(top: 10.h),
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: 0.45.sw,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             _Switch(
//                               onToggle: (value) {
//                                 if (Get.find<PinSave>()
//                                         .limit
//                                         .value
//                                         .remainTradingLimit ==
//                                     null) {
//                                   NotifikasiPopup.show("Please Insert Pin");
//                                   return;
//                                 }
//                                 controller.randomSlit.value = value;
//                                 controller.randomSlit.refresh();
//                                 if (!controller.randomSlit.value) {
//                                   controller.splitTo.text = '0';
//                                 }
//                               },
//                               value: controller.randomSlit.value,
//                               title: 'Randomize Split',
//                             ),
//                             _Switch(
//                               onToggle: (value) {
//                                 if (Get.find<PinSave>()
//                                         .limit
//                                         .value
//                                         .remainTradingLimit ==
//                                     null) {
//                                   NotifikasiPopup.show("Please Insert Pin");
//                                   return;
//                                 }
//                                 controller.aPriceStap.value = value;
//                                 controller.aPriceStap.refresh();
//                                 if (!controller.aPriceStap.value) {
//                                   controller.priceStap.text = '0';
//                                 }
//                               },
//                               value: controller.aPriceStap.value,
//                               title: 'Activ PriceStep',
//                             ),
//                             _Switch(
//                               onToggle: (value) {
//                                 if (Get.find<PinSave>()
//                                         .limit
//                                         .value
//                                         .remainTradingLimit ==
//                                     null) {
//                                   NotifikasiPopup.show("Please Insert Pin");
//                                   return;
//                                 }
//                                 controller.aOrder.value = value;
//                                 controller.aOrder.refresh();
//                                 if (!controller.aOrder.value) {
//                                   controller.autoPrice.text = '0';
//                                 }
//                               },
//                               value: controller.aOrder.value,
//                               title: 'Automatic SELL',
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Spacer(),
//                       SizedBox(
//                         width: 0.4.sw,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             SizedBox(
//                               height: 25.h,
//                               child: Builder(
//                                 builder: (context) {
//                                   return TextField(
//                                     textAlign: TextAlign.right,
//                                     controller: controller.splitTo,
//                                     inputFormatters: [
//                                       FilteringTextInputFormatter.allow(
//                                           RegExp(r'[0-9]')),
//                                     ],
//                                     onTap: () {
//                                       controller.splitTo.selection =
//                                           TextSelection(
//                                         baseOffset: 0,
//                                         extentOffset: controller
//                                             .splitTo.value.text.length,
//                                       );
//                                     },
//                                     maxLength: 2,
//                                     decoration: InputDecoration(
//                                       counterText: '',
//                                       contentPadding: EdgeInsets.zero,
//                                       filled: true,
//                                       fillColor: Colors.white.withOpacity(0.25),
//                                       border: const OutlineInputBorder(),
//                                       suffixIcon: SizedBox(
//                                         width: 0.12.sw,
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.end,
//                                           children: [
//                                             GestureDetector(
//                                               child: Icon(
//                                                 Icons.remove,
//                                                 color: Colors.white,
//                                                 size: 18.sp,
//                                               ),
//                                               onTap: () {
//                                                 controller.splitTo.text == '0'
//                                                     ? null
//                                                     : controller.splitTo.text =
//                                                         (int.parse(controller
//                                                                     .splitTo
//                                                                     .text) -
//                                                                 1)
//                                                             .toString();
//                                               },
//                                             ),
//                                             GestureDetector(
//                                               onTap: () {
//                                                 controller.splitTo.text =
//                                                     (int.parse(controller
//                                                                 .splitTo.text) +
//                                                             1)
//                                                         .toString();
//                                               },
//                                               child: Icon(
//                                                 Icons.add,
//                                                 color: Colors.white,
//                                                 size: 18.sp,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                     enabled: controller.randomSlit.value,
//                                     maxLines: 1,
//                                     textDirection: TextDirection.ltr,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: FontSizes.size11,
//                                     ),
//                                     onChanged: (a) => a,
//                                   );
//                                 },
//                               ),
//                             ),
//                             const Spacer(),
//                             SizedBox(
//                               height: 25.h,
//                               child: TextField(
//                                 textAlign: TextAlign.right,
//                                 controller: controller.priceStap,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(
//                                       RegExp(r'[0-9]')),
//                                 ],
//                                 onTap: () {
//                                   controller.priceStap.selection =
//                                       TextSelection(
//                                     baseOffset: 0,
//                                     extentOffset:
//                                         controller.priceStap.value.text.length,
//                                   );
//                                 },
//                                 maxLength: 2,
//                                 decoration: InputDecoration(
//                                   counterText: '',
//                                   contentPadding: EdgeInsets.zero,
//                                   filled: true,
//                                   fillColor: Colors.white.withOpacity(0.25),
//                                   border: const OutlineInputBorder(),
//                                   // contentPadding: EdgeInsets.zero,
//                                   suffixIcon: SizedBox(
//                                     width: 0.12.sw,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         GestureDetector(
//                                           child: Icon(
//                                             Icons.remove,
//                                             color: Colors.white,
//                                             size: 18.sp,
//                                           ),
//                                           onTap: () {
//                                             controller.priceStap.text == '0'
//                                                 ? null
//                                                 : controller.priceStap.text =
//                                                     (int.parse(controller
//                                                                 .priceStap
//                                                                 .text) -
//                                                             1)
//                                                         .toString();
//                                           },
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             controller.priceStap.text =
//                                                 (int.parse(controller
//                                                             .priceStap.text) +
//                                                         1)
//                                                     .toString();
//                                           },
//                                           child: Icon(
//                                             Icons.add,
//                                             color: Colors.white,
//                                             size: 18.sp,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   enabled: controller.aPriceStap.value,
//                                 ),
//                                 maxLines: 1,
//                                 textDirection: TextDirection.ltr,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: FontSizes.size11,
//                                 ),
//                                 onChanged: (a) => a,
//                               ),
//                             ),
//                             const Spacer(),
//                             SizedBox(
//                               height: 25.h,
//                               child: TextField(
//                                 controller: controller.autoPrice,
//                                 textAlign: TextAlign.right,
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(
//                                     RegExp(
//                                       r'[0-9]',
//                                     ),
//                                   ),
//                                 ],
//                                 onTap: () {
//                                   controller.autoPrice.selection =
//                                       TextSelection(
//                                     baseOffset: 0,
//                                     extentOffset:
//                                         controller.autoPrice.value.text.length,
//                                   );
//                                 },
//                                 maxLength: 2,
//                                 decoration: InputDecoration(
//                                   counterText: '',
//                                   contentPadding: EdgeInsets.zero,
//                                   filled: true,
//                                   fillColor: Colors.white.withOpacity(0.25),
//                                   border: const OutlineInputBorder(),
//                                   suffixIcon: SizedBox(
//                                     width: 0.120.sw,
//                                     child: Row(
//                                       mainAxisAlignment: MainAxisAlignment.end,
//                                       children: [
//                                         GestureDetector(
//                                           child: Icon(
//                                             Icons.remove,
//                                             color: Colors.white,
//                                             size: 18.sp,
//                                           ),
//                                           onTap: () {
//                                             controller.autoPrice.text == '0'
//                                                 ? null
//                                                 : controller
//                                                         .qtyController.text =
//                                                     (int.parse(controller
//                                                                 .autoPrice
//                                                                 .text) -
//                                                             1)
//                                                         .toString();
//                                           },
//                                         ),
//                                         GestureDetector(
//                                           onTap: () {
//                                             controller.autoPrice.text =
//                                                 (int.parse(controller
//                                                             .autoPrice.text) +
//                                                         1)
//                                                     .toString();
//                                           },
//                                           child: Icon(
//                                             Icons.add,
//                                             color: Colors.white,
//                                             size: 18.sp,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   enabled: controller.aOrder.value,
//                                 ),
//                                 maxLines: 1,
//                                 textDirection: TextDirection.ltr,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: FontSizes.size11,
//                                 ),
//                                 onChanged: (a) => a,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//         SizedBox(
//           height: 8.h,
//         ),
//         Expanded(
//           child: Obx(() {
//             return MainTable(
//               header: [
//                 HeaderModel(
//                   label: Text(
//                     'Stock Estimation',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: FontSizes.size11,
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                 ),
//                 HeaderModel(
//                   label: Text(
//                     'Transaction Fee',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: FontSizes.size11,
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                 ),
//                 HeaderModel(
//                   label: Text(
//                     'Nett',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: FontSizes.size11,
//                     ),
//                   ),
//                   alignment: Alignment.center,
//                 ),
//               ],
//               body: [
//                 BodyModel(
//                   body: [
//                     Container(
//                       alignment: Alignment.centerRight,
//                       height: 30.h,
//                       child: Text(
//                         formattaCurrun(controller.stockEstimasiData.value),
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: FontSizes.size11,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       height: 30.h,
//                       child: Text(
//                         formattaCurrun(controller.fee(true)),
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: FontSizes.size11,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.centerRight,
//                       height: 30.h,
//                       padding: EdgeInsets.only(right: 5.w),
//                       child: Text(
//                         formattaCurrun(controller.nett(true)),
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: FontSizes.size11,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             );
//           }),
//         ),
//       ],
//     ));
//   }
// }

// Widget _bottom(String type, BuildContext context, int prevpp,
//     void Function(String) title) {
//   BuildingMassageOrder contollerBuilding = Get.find();
//   final bodyControl = Get.find<BodyController>();
//   var getLimit = Get.find<PinSave>();
//   return SizedBox(
//     height: 30.h,
//     width: 0.9.sw,
//     child: LayoutBuilder(
//       builder: (BuildContext context, BoxConstraints constraints) {
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             GestureDetector(
//               onTap: () {
//                 if (getLimit.limit.value.remainTradingLimit == null) {
//                   // ignore: void_checks
//                   return NotifikasiPopup.showWarning('Please Insert Pin');
//                 }

//                 var controllers = Get.put(OrderListController());
//                 OrderMassage.orderListReq(
//                   Get.find<PinSave>().pin.value,
//                   accountId.value == ''
//                       ? Get.find<LoginOrderController>()
//                           .order!
//                           .value
//                           .account!
//                           .first
//                           .accountId!
//                       : accountId.value,
//                 );
//                 showModalBottomSheet(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         topRight: Radius.circular(20.r)),
//                   ),
//                   useSafeArea: true,
//                   enableDrag: true,
//                   backgroundColor: bgabu,
//                   context: Get.context!,
//                   builder: (context) {
//                     return SizedBox(
//                       height: 0.5.sh,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.only(top: 3.h, bottom: 5.h),
//                             width: 0.25.sw,
//                             height: 10.h,
//                             child: Divider(
//                               color: foregroundwidget2,
//                               thickness: 2.h,
//                               height: 3.h,
//                             ),
//                           ),
//                           Text(
//                             "Order List",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: putihop85,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           Expanded(
//                             child: Container(
//                               margin: EdgeInsets.only(top: 8.h),
//                               child: Obx(
//                                 () {
//                                   return ScrollConfiguration(
//                                     behavior: const ScrollBehavior()
//                                         .copyWith(overscroll: false),
//                                     child: HorizontalDataTable(
//                                       leftHandSideColumnWidth: 0.3.sw,
//                                       rightHandSideColumnWidth: 1.42.sw,
//                                       leftHandSideColBackgroundColor:
//                                           Colors.transparent,
//                                       rightHandSideColBackgroundColor:
//                                           Colors.transparent,
//                                       isFixedHeader: true,
//                                       itemCount:
//                                           controllers.data.value.array == null
//                                               ? 0
//                                               : controllers
//                                                   .data.value.array!.length,
//                                       headerWidgets: [
//                                         Row(
//                                           children: [
//                                             Container(
//                                               height: 66.h,
//                                               width: 0.1.sw,
//                                               alignment: Alignment.center,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                     height: 33.h,
//                                                     width: 0.2.sw,
//                                                     alignment: Alignment.center,
//                                                     decoration: BoxDecoration(
//                                                         color: foregroundwidget,
//                                                         border: Border(
//                                                           right: BorderSide(
//                                                             color: Colors.black,
//                                                             width: 1.w,
//                                                           ),
//                                                         )),
//                                                   ),
//                                                   Container(
//                                                     height: 33.h,
//                                                     width: 0.2.sw,
//                                                     alignment: Alignment.center,
//                                                     decoration: BoxDecoration(
//                                                         color: foregroundwidget,
//                                                         border: Border(
//                                                           right: BorderSide(
//                                                             color: Colors.black,
//                                                             width: 1.w,
//                                                           ),
//                                                         )),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Container(
//                                               height: 66.h,
//                                               width: 0.2.sw,
//                                               alignment: Alignment.center,
//                                               child: Column(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment.center,
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.center,
//                                                 children: [
//                                                   Container(
//                                                     height: 33.h,
//                                                     width: 0.2.sw,
//                                                     alignment: Alignment.center,
//                                                     decoration: BoxDecoration(
//                                                         color: foregroundwidget,
//                                                         border: Border(
//                                                             bottom: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ))),
//                                                     child: Text(
//                                                       'Type',
//                                                       style: TextStyle(
//                                                         color: putihop85,
//                                                         fontSize: 12.sp,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 33.h,
//                                                     width: 0.2.sw,
//                                                     alignment: Alignment.center,
//                                                     color: foregroundwidget,
//                                                     child: Text(
//                                                       'Code',
//                                                       style: TextStyle(
//                                                         color: putihop85,
//                                                         fontSize: 12.sp,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                         Container(
//                                           height: 66.h,
//                                           width: 0.16.sw,
//                                           alignment: Alignment.center,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.16.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                         left: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ),
//                                                         bottom: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ))),
//                                                 child: Text(
//                                                   'ST',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.16.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                       left: BorderSide(
//                                                         color: Colors.black,
//                                                         width: 1.w,
//                                                       ),
//                                                     )),
//                                                 child: Text(
//                                                   'MKT',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           height: 66.h,
//                                           width: 0.25.sw,
//                                           alignment: Alignment.center,
//                                           color: foregroundwidget,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.25.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     border: Border(
//                                                         left: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ),
//                                                         bottom: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ))),
//                                                 child: Text(
//                                                   'Price',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.25.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                       left: BorderSide(
//                                                         color: Colors.black,
//                                                         width: 1.w,
//                                                       ),
//                                                     )),
//                                                 child: Text(
//                                                   'Qty',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           height: 66.h,
//                                           width: 0.25.sw,
//                                           alignment: Alignment.center,
//                                           color: foregroundwidget,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.25.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                         left: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ),
//                                                         bottom: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ))),
//                                                 child: Text(
//                                                   'Order Time',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.25.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                       left: BorderSide(
//                                                         color: Colors.black,
//                                                         width: 1.w,
//                                                       ),
//                                                     )),
//                                                 child: Text(
//                                                   'Input User',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           height: 66.h,
//                                           width: 0.25.sw,
//                                           alignment: Alignment.center,
//                                           color: foregroundwidget,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.25.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                         left: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ),
//                                                         bottom: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ))),
//                                                 child: Text(
//                                                   'Done Qty',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.25.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                       left: BorderSide(
//                                                         color: Colors.black,
//                                                         width: 1.w,
//                                                       ),
//                                                     )),
//                                                 child: Text(
//                                                   'Rest Qty',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           height: 66.h,
//                                           width: 0.50.sw,
//                                           alignment: Alignment.center,
//                                           color: foregroundwidget,
//                                           child: Column(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children: [
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.50.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                         left: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ),
//                                                         bottom: BorderSide(
//                                                           color: Colors.black,
//                                                           width: 1.w,
//                                                         ))),
//                                                 child: Text(
//                                                   'Order ID',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                               Container(
//                                                 height: 33.h,
//                                                 width: 0.50.sw,
//                                                 alignment: Alignment.center,
//                                                 decoration: BoxDecoration(
//                                                     color: foregroundwidget,
//                                                     border: Border(
//                                                       left: BorderSide(
//                                                         color: Colors.black,
//                                                         width: 1.w,
//                                                       ),
//                                                     )),
//                                                 child: Text(
//                                                   'Idx ID',
//                                                   style: TextStyle(
//                                                     color: putihop85,
//                                                     fontSize: 12.sp,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                       leftSideItemBuilder: (context, index) =>
//                                           Obx(
//                                         () {
//                                           return Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             crossAxisAlignment:
//                                                 CrossAxisAlignment.center,
//                                             children:
//                                                 controllers.data.value.array ==
//                                                             null ||
//                                                         controllers.data.value
//                                                             .array!.isEmpty
//                                                     ? []
//                                                     : [
//                                                         controllers
//                                                                     .data
//                                                                     .value
//                                                                     .array![
//                                                                         index]
//                                                                     .orderStatus ==
//                                                                 1
//                                                             ? Container(
//                                                                 height: 66.h,
//                                                                 width: 0.1.sw,
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 child: Column(
//                                                                   children: [
//                                                                     GestureDetector(
//                                                                       onTap:
//                                                                           () {
//                                                                         bodyControl.priceController.text = formattaCurrun(controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .price!);
//                                                                         bodyControl
//                                                                             .qtyController
//                                                                             .text = formattaCurrun(((controllers.data.value.array![index].oVolume! -
//                                                                                 controllers.data.value.array![index].tVolume!) ~/
//                                                                             Get.find<LoginOrderController>().order!.value.lot!));
//                                                                         bodyControl.boardController.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .boardMarketCode!;
//                                                                         bodyControl
//                                                                             .bOrSController
//                                                                             .text = controllers.data.value.array![index].command! ==
//                                                                                 1
//                                                                             ? 'SELL'
//                                                                             : 'BUY';
//                                                                         bodyControl.idxIdController.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .idxOrderId!;
//                                                                         bodyControl.orderIdController.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .orderId!;
//                                                                         bodyControl.accountId.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .accountId!;
//                                                                         Get.back();
//                                                                         title(controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .stockCode!);
//                                                                         Navigator
//                                                                             .pushNamed(
//                                                                           context,
//                                                                           '/goCheckoutviewAmendAndWD',
//                                                                           arguments: <String,
//                                                                               String>{
//                                                                             'prevP':
//                                                                                 "$prevpp",
//                                                                             'title':
//                                                                                 '${controllers.data.value.array![index].stockCode}',
//                                                                             'subtitle':
//                                                                                 '',
//                                                                             'board':
//                                                                                 Get.find<ControllerBoard>().boards.value,
//                                                                             'typeCheckout':
//                                                                                 "AMEND",
//                                                                             'isFormC':
//                                                                                 '1'
//                                                                           },
//                                                                         );
//                                                                       },
//                                                                       child:
//                                                                           Container(
//                                                                         height:
//                                                                             33.h,
//                                                                         width: 0.1
//                                                                             .sw,
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         color: index % 2 ==
//                                                                                 0
//                                                                             ? Colors.black
//                                                                             : bgabu.withOpacity(0.6),
//                                                                         child:
//                                                                             Text(
//                                                                           "A",
//                                                                           style:
//                                                                               TextStyle(
//                                                                             color:
//                                                                                 Colors.amber,
//                                                                             fontSize:
//                                                                                 12.sp,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                     GestureDetector(
//                                                                       onTap:
//                                                                           () {
//                                                                         bodyControl.priceController.text = formattaCurrun(controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .price!);
//                                                                         bodyControl
//                                                                             .qtyController
//                                                                             .text = formattaCurrun(((controllers.data.value.array![index].oVolume! -
//                                                                                 controllers.data.value.array![index].tVolume!) ~/
//                                                                             Get.find<LoginOrderController>().order!.value.lot!));
//                                                                         bodyControl.boardController.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .boardMarketCode!;
//                                                                         bodyControl
//                                                                             .bOrSController
//                                                                             .text = controllers.data.value.array![index].command! ==
//                                                                                 1
//                                                                             ? 'SELL'
//                                                                             : 'BUY';
//                                                                         bodyControl.idxIdController.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .idxOrderId!;
//                                                                         bodyControl.orderIdController.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .array![index]
//                                                                             .orderId!;
//                                                                         bodyControl.accountId.text = controllers
//                                                                             .data
//                                                                             .value
//                                                                             .accountId!;
//                                                                         Get.back();
//                                                                         Navigator
//                                                                             .pushNamed(
//                                                                           context,
//                                                                           '/goCheckoutviewAmendAndWD',
//                                                                           arguments: <String,
//                                                                               String>{
//                                                                             'prevP':
//                                                                                 "$prevpp",
//                                                                             'title':
//                                                                                 '${controllers.data.value.array![index].stockCode}',
//                                                                             'subtitle':
//                                                                                 '',
//                                                                             'board':
//                                                                                 Get.find<ControllerBoard>().boards.value,
//                                                                             'typeCheckout':
//                                                                                 "WITHDRAWN",
//                                                                             'isFormC':
//                                                                                 '1'
//                                                                           },
//                                                                         );
//                                                                       },
//                                                                       child:
//                                                                           Container(
//                                                                         height:
//                                                                             33.h,
//                                                                         width: 0.1
//                                                                             .sw,
//                                                                         alignment:
//                                                                             Alignment.center,
//                                                                         color: index % 2 ==
//                                                                                 0
//                                                                             ? Colors.black
//                                                                             : bgabu.withOpacity(0.6),
//                                                                         child:
//                                                                             Text(
//                                                                           "W",
//                                                                           style:
//                                                                               TextStyle(
//                                                                             color:
//                                                                                 Colors.green,
//                                                                             fontSize:
//                                                                                 12.sp,
//                                                                           ),
//                                                                         ),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               )
//                                                             : Container(
//                                                                 height: 66.h,
//                                                                 width: 0.1.sw,
//                                                                 color: index %
//                                                                             2 ==
//                                                                         0
//                                                                     ? Colors
//                                                                         .black
//                                                                     : bgabu
//                                                                         .withOpacity(
//                                                                             0.6),
//                                                               ),
//                                                         Container(
//                                                           height: 66.h,
//                                                           width: 0.2.sw,
//                                                           alignment:
//                                                               Alignment.center,
//                                                           child: Column(
//                                                             mainAxisAlignment:
//                                                                 MainAxisAlignment
//                                                                     .center,
//                                                             crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .center,
//                                                             children: [
//                                                               Container(
//                                                                 height: 33.h,
//                                                                 width: 0.2.sw,
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 color: index %
//                                                                             2 ==
//                                                                         0
//                                                                     ? Colors
//                                                                         .black
//                                                                     : bgabu
//                                                                         .withOpacity(
//                                                                             0.6),
//                                                                 child: Text(
//                                                                   controllers
//                                                                               .data
//                                                                               .value
//                                                                               .array![index]
//                                                                               .command ==
//                                                                           0
//                                                                       ? "B"
//                                                                       : controllers.data.value.array![index].command == 1
//                                                                           ? "S"
//                                                                           : controllers.data.value.array![index].command == 2
//                                                                               ? "M"
//                                                                               : controllers.data.value.array![index].command == 3
//                                                                                   ? "SS"
//                                                                                   : "",
//                                                                   style: TextStyle(
//                                                                       color: controllers.data.value.array![index].command == 0
//                                                                           ? Colors.red
//                                                                           : controllers.data.value.array![index].command == 1
//                                                                               ? Colors.green
//                                                                               : controllers.data.value.array![index].command == 2
//                                                                                   ? Colors.orange
//                                                                                   : controllers.data.value.array![index].command == 3
//                                                                                       ? Colors.blue
//                                                                                       : null,
//                                                                       fontSize: 11.sp),
//                                                                 ),
//                                                               ),
//                                                               Container(
//                                                                 height: 33.h,
//                                                                 width: 0.2.sw,
//                                                                 alignment:
//                                                                     Alignment
//                                                                         .center,
//                                                                 color: index %
//                                                                             2 ==
//                                                                         0
//                                                                     ? Colors
//                                                                         .black
//                                                                     : bgabu
//                                                                         .withOpacity(
//                                                                             0.6),
//                                                                 child: Text(
//                                                                   controllers
//                                                                       .data
//                                                                       .value
//                                                                       .array![
//                                                                           index]
//                                                                       .stockCode
//                                                                       .toString(),
//                                                                   style:
//                                                                       TextStyle(
//                                                                     color:
//                                                                         putihop85,
//                                                                     fontSize:
//                                                                         12.sp,
//                                                                   ),
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                       ],
//                                           );
//                                         },
//                                       ),
//                                       rightSideItemBuilder: (context, index) {
//                                         return Row(
//                                           children: List.generate(
//                                             1,
//                                             (i) {
//                                               return Row(
//                                                 children: [
//                                                   Container(
//                                                     height: 66.h,
//                                                     width: 0.16.sw,
//                                                     alignment: Alignment.center,
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         GestureDetector(
//                                                           onTap: () => OrderMassage
//                                                               .reqRejectedOrderMassage(
//                                                             orderID: controllers
//                                                                 .data
//                                                                 .value
//                                                                 .array![index]
//                                                                 .orderId!,
//                                                             pin: Get.find<
//                                                                     PinSave>()
//                                                                 .pin
//                                                                 .value,
//                                                             accountId:
//                                                                 controllers
//                                                                     .data
//                                                                     .value
//                                                                     .accountId!,
//                                                           ),
//                                                           child: Container(
//                                                             height: 33.h,
//                                                             width: 0.16.sw,
//                                                             color: index % 2 ==
//                                                                     0
//                                                                 ? Colors.black
//                                                                 : bgabu
//                                                                     .withOpacity(
//                                                                         0.6),
//                                                             alignment: Alignment
//                                                                 .center,
//                                                             child: Text(
//                                                               controllers
//                                                                           .data
//                                                                           .value
//                                                                           .array![
//                                                                               index]
//                                                                           .orderStatus ==
//                                                                       1
//                                                                   ? 'Open'
//                                                                   : controllers
//                                                                               .data
//                                                                               .value
//                                                                               .array![index]
//                                                                               .orderStatus ==
//                                                                           2
//                                                                       ? 'Matched'
//                                                                       : controllers.data.value.array![index].orderStatus == 3
//                                                                           ? 'Amending'
//                                                                           : controllers.data.value.array![index].orderStatus == 4
//                                                                               ? 'Withdrawing'
//                                                                               : controllers.data.value.array![index].orderStatus == 5
//                                                                                   ? 'Withdrawn'
//                                                                                   : controllers.data.value.array![index].orderStatus == 6
//                                                                                       ? 'Amended'
//                                                                                       : 'Rejected',
//                                                               style: TextStyle(
//                                                                 color:
//                                                                     putihop85,
//                                                                 fontSize: 11.sp,
//                                                               ),
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.16.sw,
//                                                           alignment:
//                                                               Alignment.center,
//                                                           color: index % 2 == 0
//                                                               ? Colors.black
//                                                               : bgabu
//                                                                   .withOpacity(
//                                                                       0.6),
//                                                           child: Text(
//                                                             controllers
//                                                                 .data
//                                                                 .value
//                                                                 .array![index]
//                                                                 .boardMarketCode
//                                                                 .toString(),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 66.h,
//                                                     width: 0.25.sw,
//                                                     alignment: Alignment.center,
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.25.sw,
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           color: index % 2 == 0
//                                                               ? Colors.black
//                                                               : bgabu
//                                                                   .withOpacity(
//                                                                       0.6),
//                                                           child: Text(
//                                                             formattaCurrun(
//                                                                 controllers
//                                                                     .data
//                                                                     .value
//                                                                     .array![
//                                                                         index]
//                                                                     .price!),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.25.sw,
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           color: index % 2 == 0
//                                                               ? Colors.black
//                                                               : bgabu
//                                                                   .withOpacity(
//                                                                       0.6),
//                                                           child: Text(
//                                                             formattaCurrun(
//                                                                 controllers
//                                                                     .data
//                                                                     .value
//                                                                     .array![
//                                                                         index]
//                                                                     .oVolume!),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     height: 66.h,
//                                                     width: 0.25.sw,
//                                                     alignment: Alignment.center,
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.25.sw,
//                                                           alignment:
//                                                               Alignment.center,
//                                                           color: index % 2 == 0
//                                                               ? Colors.black
//                                                               : bgabu
//                                                                   .withOpacity(
//                                                                       0.6),
//                                                           child: Text(
//                                                             formatJam(controllers
//                                                                     .data
//                                                                     .value
//                                                                     .array![
//                                                                         index]
//                                                                     .orderTime
//                                                                     .toString())
//                                                                 .replaceAll(
//                                                                     RegExp(
//                                                                         r' '),
//                                                                     ''),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.25.sw,
//                                                           alignment:
//                                                               Alignment.center,
//                                                           color: index % 2 == 0
//                                                               ? Colors.black
//                                                               : bgabu
//                                                                   .withOpacity(
//                                                                       0.6),
//                                                           child: Text(
//                                                             controllers
//                                                                 .data
//                                                                 .value
//                                                                 .array![index]
//                                                                 .inputUser
//                                                                 .toString(),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         right: 5.w),
//                                                     height: 66.h,
//                                                     width: 0.25.sw,
//                                                     color: index % 2 == 0
//                                                         ? Colors.black
//                                                         : bgabu
//                                                             .withOpacity(0.6),
//                                                     alignment: Alignment.center,
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.25.sw,
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Text(
//                                                             formattaCurrun(
//                                                                 controllers
//                                                                     .data
//                                                                     .value
//                                                                     .array![
//                                                                         index]
//                                                                     .tVolume!),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.25.sw,
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Text(
//                                                             formattaCurrun(
//                                                                 controllers
//                                                                     .data
//                                                                     .value
//                                                                     .array![
//                                                                         index]
//                                                                     .rVolume!),
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                   Container(
//                                                     padding: EdgeInsets.only(
//                                                         right: 5.w),
//                                                     height: 66.h,
//                                                     width: 0.50.sw,
//                                                     color: index % 2 == 0
//                                                         ? Colors.black
//                                                         : bgabu
//                                                             .withOpacity(0.6),
//                                                     alignment: Alignment.center,
//                                                     child: Column(
//                                                       mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .center,
//                                                       crossAxisAlignment:
//                                                           CrossAxisAlignment
//                                                               .center,
//                                                       children: [
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.50.sw,
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Text(
//                                                             controllers
//                                                                 .data
//                                                                 .value
//                                                                 .array![index]
//                                                                 .orderId!,
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           height: 33.h,
//                                                           width: 0.50.sw,
//                                                           alignment: Alignment
//                                                               .centerRight,
//                                                           child: Text(
//                                                             controllers
//                                                                 .data
//                                                                 .value
//                                                                 .array![index]
//                                                                 .idxOrderId!,
//                                                             style: TextStyle(
//                                                               color: putihop85,
//                                                               fontSize: 12.sp,
//                                                             ),
//                                                           ),
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               );
//                                             },
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                           )
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 width: 0.25.sw,
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(5.r),
//                   border: Border.all(),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Order List',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: FontSizes.size14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             Obx(() {
//               return GestureDetector(
//                 onTap: !onTapConfirm.value
//                     ? () {}
//                     : () {
//                         if (getLimit.limit.value.remainTradingLimit == null) {
//                           // ignore: void_checks
//                           return NotifikasiPopup.show("Please Insert Pin");
//                         }

//                         if (bodyControl.qtyController.text == '0') {
//                           // ignore: void_checks
//                           return NotifikasiPopup.show("Please Insert Qty");
//                         }
//                         showDialog(
//                           useSafeArea: true,
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(20.r),
//                               ),
//                               backgroundColor: Colors.white,
//                               titlePadding: EdgeInsets.only(top: 5.h),
//                               title: Column(
//                                 children: [
//                                   Text(
//                                     type,
//                                     style: TextStyle(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15.sp),
//                                   ),
//                                   Text(
//                                     'Confirmation',
//                                     style: TextStyle(
//                                         color: Colors.red,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 15.sp),
//                                   ),
//                                   SizedBox(height: 2.h),
//                                   Text(
//                                     '${getLimit.stockCode.value} - ${ObjectBoxDatabase.stockList.query(PackageStockList_.stcokCode.equals(getLimit.stockCode.value)).build().findFirst()!.stockName!}',
//                                     style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: FontSizes.size13,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                     maxLines: 2,
//                                   ),
//                                   SizedBox(height: 5.h),
//                                   Container(
//                                     padding: EdgeInsets.only(
//                                       left: 3.w,
//                                       right: 3.w,
//                                     ),
//                                     width: 300.w,
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           'Account ID: ',
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: FontSizes.size13,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                           maxLines: 1,
//                                         ),
//                                         SizedBox(
//                                           width: 200.w,
//                                           child: Text(
//                                             '${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountId : accountId.value} - ${accountId.value == '' ? Get.find<LoginOrderController>().order!.value.account!.first.accountName : Get.find<LoginOrderController>().order!.value.account!.firstWhere((element) => element.accountId == accountId.value).accountName}',
//                                             style: TextStyle(
//                                               fontWeight: FontWeight.bold,
//                                               fontSize: FontSizes.size13,
//                                               overflow: TextOverflow.ellipsis,
//                                             ),
//                                             maxLines: 1,
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               contentPadding: EdgeInsets.zero,
//                               actionsAlignment: MainAxisAlignment.center,
//                               actions: <Widget>[
//                                 GestureDetector(
//                                   onTap: () => Navigator.of(context).pop(),
//                                   child: Container(
//                                     width: 70.w,
//                                     height: 30.h,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5.r),
//                                       color: Colors.red,
//                                     ),
//                                     alignment: AlignmentDirectional.center,
//                                     child: Text(
//                                       'Cancel',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: FontSizes.size12),
//                                     ),
//                                   ),
//                                 ),
//                                 GestureDetector(
//                                   onTap: () {
//                                     contollerBuilding.building.value.stockCode =
//                                         getLimit.stockCode.value;
//                                     contollerBuilding.building.value.volume =
//                                         int.parse(
//                                               bodyControl.qtyController.text
//                                                   .replaceAll(
//                                                 RegExp(r','),
//                                                 '',
//                                               ),
//                                             ) *
//                                             Get.find<LoginOrderController>()
//                                                 .order!
//                                                 .value
//                                                 .lot!;
//                                     contollerBuilding.building.value.price =
//                                         int.parse(
//                                       bodyControl.priceController.value.text
//                                           .replaceAll(
//                                         RegExp(r','),
//                                         '',
//                                       ),
//                                     );
//                                     contollerBuilding.building.value.board =
//                                         Get.find<ControllerBoard>().boards ==
//                                                 'RG'
//                                             ? 0
//                                             : 1;
//                                     contollerBuilding.building.value.pin =
//                                         int.parse(
//                                             Get.find<PinSave>().pin.value);
//                                     contollerBuilding.building.value.command =
//                                         0;
//                                     contollerBuilding
//                                             .building.value.prevSameOrder =
//                                         bodyControl.sameOrder.value == false
//                                             ? 0
//                                             : 1;
//                                     contollerBuilding
//                                             .building.value.rendomSplit =
//                                         bodyControl.randomSlit.value == false
//                                             ? 0
//                                             : 1;
//                                     contollerBuilding.building.value.nSplit =
//                                         int.parse(
//                                             bodyControl.splitTo.value.text);
//                                     contollerBuilding
//                                             .building.value.activPriceStep =
//                                         bodyControl.aPriceStap.value == false
//                                             ? 0
//                                             : 1;
//                                     contollerBuilding
//                                             .building.value.autoOrderPriceStep =
//                                         int.parse(
//                                             bodyControl.autoPrice.value.text);
//                                     bodyControl.aOrder.value == false ? 0 : 1;
//                                     contollerBuilding.building.value.priceStep =
//                                         int.parse(
//                                             bodyControl.priceStap.value.text);
//                                     contollerBuilding.building.refresh();
//                                     contollerBuilding.see();
//                                     onTapConfirm.toggle();
//                                     onChackOut.value = 'goCheckoutview';
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Container(
//                                     width: 70.w,
//                                     height: 30.h,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(5.r),
//                                       color: Colors.blue,
//                                     ),
//                                     alignment: AlignmentDirectional.center,
//                                     child: Text(
//                                       'Confirm',
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontSize: FontSizes.size12),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                               content: Container(
//                                 margin: EdgeInsets.only(top: 5.h),
//                                 padding: EdgeInsets.only(
//                                     top: 5.w, left: 5.w, right: 5.w),
//                                 height: 0.35.sh,
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.circular(5.r),
//                                 ),
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Table(
//                                           columnWidths: {
//                                             0: FixedColumnWidth(0.2.sw),
//                                             1: FixedColumnWidth(0.05.sw),
//                                             2: FixedColumnWidth(0.13.sw),
//                                           },
//                                           children: [
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Price',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl
//                                                           .priceController.text,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Vol',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl
//                                                           .qtyController.text,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         Table(
//                                           columnWidths: {
//                                             0: FixedColumnWidth(0.17.sw),
//                                             1: FixedColumnWidth(0.05.sw),
//                                             2: FixedColumnWidth(0.15.sw),
//                                           },
//                                           children: [
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Market',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     height: 25,
//                                                     child: Text(
//                                                       Get.find<ControllerBoard>()
//                                                                   .boards
//                                                                   .value ==
//                                                               'RG'
//                                                           ? 'Regular '
//                                                           : 'Cash ',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Divider(
//                                       color: bgabu,
//                                       height: 2.h,
//                                       thickness: 1.h,
//                                     ),
//                                     Container(
//                                       alignment: Alignment.centerLeft,
//                                       child: Table(
//                                         columnWidths: {
//                                           0: FixedColumnWidth(0.3.sw),
//                                           1: FixedColumnWidth(0.05.sw),
//                                           2: FixedColumnWidth(0.1.sw),
//                                         },
//                                         children: [
//                                           TableRow(
//                                             children: [
//                                               TableCell(
//                                                 child: Container(
//                                                   alignment:
//                                                       Alignment.centerLeft,
//                                                   height: 25,
//                                                   child: Text(
//                                                     'Prevent same order',
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize:
//                                                           FontSizes.size11,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               TableCell(
//                                                 child: Container(
//                                                   alignment: Alignment.center,
//                                                   height: 25,
//                                                   child: Text(
//                                                     ':',
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize:
//                                                           FontSizes.size11,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                               TableCell(
//                                                 child: Container(
//                                                   alignment: Alignment.center,
//                                                   height: 25,
//                                                   child: Text(
//                                                     bodyControl.sameOrder.value
//                                                         ? 'ON'
//                                                         : 'OFF',
//                                                     style: TextStyle(
//                                                       fontWeight:
//                                                           FontWeight.bold,
//                                                       fontSize:
//                                                           FontSizes.size10,
//                                                       color: bodyControl
//                                                               .sameOrder.value
//                                                           ? greenOn
//                                                           : Colors.red,
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         Table(
//                                           columnWidths: {
//                                             0: FixedColumnWidth(0.3.sw),
//                                             1: FixedColumnWidth(0.05.sw),
//                                             2: FixedColumnWidth(0.1.sw),
//                                           },
//                                           children: [
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Randomize Split',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl
//                                                               .randomSlit.value
//                                                           ? 'ON'
//                                                           : 'OFF',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                         color: bodyControl
//                                                                 .randomSlit
//                                                                 .value
//                                                             ? greenOn
//                                                             : Colors.red,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Price Step',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl
//                                                               .aPriceStap.value
//                                                           ? 'ON'
//                                                           : 'OFF',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                         color: bodyControl
//                                                                 .aPriceStap
//                                                                 .value
//                                                             ? greenOn
//                                                             : Colors.red,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Auto SELL',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl.aOrder.value
//                                                           ? 'ON'
//                                                           : 'OFF',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                         color: bodyControl
//                                                                 .aOrder.value
//                                                             ? greenOn
//                                                             : Colors.red,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         Table(
//                                           columnWidths: {
//                                             0: FixedColumnWidth(0.13.sw),
//                                             1: FixedColumnWidth(0.05.sw),
//                                             2: FixedColumnWidth(0.08.sw),
//                                           },
//                                           children: [
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Split to',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl.splitTo.text,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Value',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl
//                                                           .priceStap.text,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             TableRow(
//                                               children: [
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerLeft,
//                                                     height: 25,
//                                                     child: Text(
//                                                       'Value',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     height: 25,
//                                                     child: Text(
//                                                       ':',
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 TableCell(
//                                                   child: Container(
//                                                     alignment:
//                                                         Alignment.centerRight,
//                                                     height: 25,
//                                                     child: Text(
//                                                       bodyControl
//                                                           .autoPrice.text,
//                                                       style: TextStyle(
//                                                         fontWeight:
//                                                             FontWeight.bold,
//                                                         fontSize:
//                                                             FontSizes.size11,
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Expanded(
//                                         child: MainTable(
//                                       header: [
//                                         HeaderModel(
//                                           label: Text(
//                                             'Estimation',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: FontSizes.size11,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           alignment: Alignment.center,
//                                         ),
//                                         HeaderModel(
//                                           label: Text(
//                                             'Transaction Fee',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: FontSizes.size11,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           alignment: Alignment.center,
//                                         ),
//                                         HeaderModel(
//                                           label: Text(
//                                             'Nett',
//                                             style: TextStyle(
//                                               color: Colors.white,
//                                               fontSize: FontSizes.size11,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                           ),
//                                           alignment: Alignment.center,
//                                         ),
//                                       ],
//                                       body: [
//                                         BodyModel(
//                                           body: [
//                                             Container(
//                                               margin: EdgeInsets.only(top: 5.h),
//                                               child: Text(
//                                                 formattaCurrun(bodyControl
//                                                     .stockEstimasi()),
//                                                 style: TextStyle(
//                                                   color: Colors.black
//                                                       .withOpacity(0.8),
//                                                   fontSize: FontSizes.size11,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 textAlign: TextAlign.right,
//                                               ),
//                                             ),
//                                             Container(
//                                               margin: EdgeInsets.only(top: 5.h),
//                                               child: Text(
//                                                 formattaCurrun(
//                                                     bodyControl.fee(true)),
//                                                 style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontSize: FontSizes.size11,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 textAlign: TextAlign.right,
//                                               ),
//                                             ),
//                                             Container(
//                                               margin: EdgeInsets.only(
//                                                   top: 5.h, right: 3.w),
//                                               child: Text(
//                                                 formattaCurrun(
//                                                     bodyControl.nett(true)),
//                                                 style: TextStyle(
//                                                   color: Colors.red,
//                                                   fontSize: FontSizes.size11,
//                                                   fontWeight: FontWeight.bold,
//                                                 ),
//                                                 textAlign: TextAlign.right,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ))
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         );
//                       },
//                 child: Container(
//                   width: 0.30.sw,
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     borderRadius: BorderRadius.circular(5.r),
//                     border: Border.all(),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: !onTapConfirm.value
//                         ? MainAxisAlignment.spaceAround
//                         : MainAxisAlignment.center,
//                     children: [
//                       !onTapConfirm.value
//                           ? SizedBox(
//                               width: 20.w,
//                               height: 20.h,
//                               child: const CircularProgressIndicator(),
//                             )
//                           : Container(),
//                       Center(
//                         child: Text(
//                           'BUY',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: FontSizes.size14,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//             GestureDetector(
//               onTap: () {
//                 if (getLimit.limit.value.remainTradingLimit == null) {
//                   // ignore: void_checks
//                   return NotifikasiPopup.showWarning('Please Insert Pin');
//                 }

//                 showModalBottomSheet(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(20.r),
//                         topRight: Radius.circular(20.r)),
//                   ),
//                   useSafeArea: true,
//                   enableDrag: true,
//                   backgroundColor: bgabu,
//                   context: context,
//                   builder: (context) {
//                     return SizedBox(
//                       height: 0.5.sh,
//                       child: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             alignment: Alignment.center,
//                             margin: EdgeInsets.only(top: 3.h, bottom: 5.h),
//                             width: 0.25.sw,
//                             height: 10.h,
//                             child: Divider(
//                               color: foregroundwidget2,
//                               thickness: 2.h,
//                               height: 3.h,
//                             ),
//                           ),
//                           Text(
//                             "Trade List",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: putihop85,
//                                 fontSize: 15.sp,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(
//                             height: 5.h,
//                           ),
//                           const Expanded(child: WidgetTradeList())
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//               child: Container(
//                 width: 0.25.sw,
//                 decoration: BoxDecoration(
//                   color: Colors.blue.withOpacity(0.25),
//                   borderRadius: BorderRadius.circular(5.r),
//                   border: Border.all(),
//                 ),
//                 child: Center(
//                   child: Text(
//                     'Trade List',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: FontSizes.size14,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       },
//     ),
//   );
// }

Widget _Switch(
    {required void Function(bool) onToggle,
    required bool value,
    required String title}) {
  return Row(
    children: [
      Text(
        '$title: ',
        style: TextStyle(
          color: Colors.white,
          fontSize: FontSizes.size11,
        ),
      ),
      const Spacer(),
      FlutterSwitch(
        valueFontSize: FontSizes.size10,
        // showOnOff: true,
        padding: 2.1.sp,
        width: 38.w,
        height: 20.h,
        value: value,
        onToggle: onToggle,
      ),
    ],
  );
}

void showStockbalance({void Function(StockBalanceARRAY)? onTapCode}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
    ),
    useSafeArea: true,
    backgroundColor: bgabu,
    context: Get.context!,
    builder: (context) {
      return SizedBox(
        height: 0.5.sh,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 3.h, bottom: 5.h),
              width: 0.25.sw,
              height: 10.h,
              child: Divider(
                color: foregroundwidget2,
                thickness: 2.h,
                height: 3.h,
              ),
            ),
            Text(
              "Stock Balance",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: putihop85,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: StockBalanceWidget(
                onTapCode: (a) {
                  onTapCode!(a);

                  // ActivityRequest.quoteRequest(
                  //   packageId: Constans.PACKAGE_ID_QUOTES,
                  //   commant: 1,
                  //   arrayStockCode: [
                  //     ArrayStockCode(
                  //       stockCode: a.stockCode!,
                  //       board: Get.find<ControllerBoard>().boards.value,
                  //     )
                  //   ],
                  // );
                  // ActivityRequest.orderBookRequest(
                  //   packageId: Constans.PACKAGE_ID_ORDER_BOOK,
                  //   stockCode: a.stockCode!,
                  //   board: Get.find<ControllerBoard>().boards.value,
                  //   commant: "1",
                  // );
                  // Future.delayed(const Duration(milliseconds: 500), () {
                  //   Navigator.of(context).pop();

                  //   controller.qtyController.text = (a.balance! ~/
                  //           Get.find<LoginOrderController>()
                  //               .order!
                  //               .value
                  //               .lot!)
                  //       .toString();

                  //   controller.stockEstimasiData.value = 0;
                  //   Future.delayed(
                  //       Duration.zero,
                  //       () => controller.stockEstimasiData.value =
                  //           controller.stockEstimasi());
                  //   if (a.stockCode != title) {
                  //     Navigator.pushReplacementNamed(
                  //       context,
                  //       '/goCheckoutview',
                  //       arguments: <String, String>{
                  //         'prevP': "0",
                  //         'title': a.stockCode!,
                  //         'subtitle': ObjectBoxDatabase.stockList
                  //             .query(PackageStockList_.stcokCode.equals(
                  //                 Get.find<ControllerBoard>()
                  //                     .stockCodes
                  //                     .value))
                  //             .build()
                  //             .findFirst()!
                  //             .stockName!,
                  //         'board': Get.find<ControllerBoard>().boards.value,
                  //         'typeCheckout': "SELL",
                  //       },
                  //     );
                  //   }
                  // });
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}

class BuildingMassageOrder extends GetxController {
  Rx<BuildingMassageOrderModel> building = BuildingMassageOrderModel().obs;

  void addToBuilding(BuildingMassageOrderModel builder) {
    building.value = builder;
    building.refresh();
  }

  void see() {
    OrderMassage.reqOrderMassage(data: building.value);
    building.value;
  }
}

class BodyController extends GetxController {
  var getAccount = Get.find<LoginOrderController>();
  var getLimit = Get.put(PinSave());
  RxBool randomSlit = false.obs;
  RxBool aPriceStap = false.obs;
  RxBool aOrder = false.obs;
  RxBool sameOrder = true.obs;
  RxList<StockBalance> stockBalance = <StockBalance>[].obs;
  final priceController = TextEditingController();
  final qtyController = TextEditingController(text: '0');
  final splitTo = TextEditingController(text: '0');
  final priceStap =
      TextEditingController(text: '0'); //Automatic Order Price Step
  final autoPrice = TextEditingController(text: '0'); //PriceStep
  Rx<DataFraksi> fraksi = DataFraksi().obs;

  //Amend sama WD Controller
  final idxIdController = TextEditingController();
  final orderIdController = TextEditingController();
  final boardController = TextEditingController();
  final bOrSController = TextEditingController();
  final cashT2Controller = TextEditingController();
  final accountId = TextEditingController();
  final stockCode = TextEditingController();

  //TEST
  RxInt stockEstimasiData = 0.obs;

  @override
  void onInit() {
    // ever(getLimit.pin, (callback) {
    //   if (callback == '') {
    //     priceController.text = '';
    //     qtyController.text = '0';

    //     // getLimit.dispose();
    //   }
    // });
    super.onInit();
  }

  int fraksiPrice(String price) {
    int frac = 0;
    for (var i = fraksi.value.array!.length - 1; i >= 0; i--) {
      if (int.parse(price) > fraksi.value.array![i].price!) {
        frac = fraksi.value.array![i].fraction!;
        break;
      }
    }
    return frac;
  }

  int max(bool cashLimit, int price, int type) {
    if (cashLimit == false) {
      return maxSell(type, price);
    } else {
      return maxBuy(type, price);
    }
  }

  int maxSell(int type, int price) {
    if (type == 0) {
      double getfee = getAccount.order!.value.account!.first.onlineFeeSell!;
      double data = (getLimit.limit.value.cashonT3! * (1.0 + getfee)) /
          (price * getAccount.order!.value.lot!);
      qtyController.text = formattaCurrun(data.toInt());
      return data.toInt();
    } else {
      double getfee = getAccount.order!.value.account!.first.onlineFeeSell!;
      double data =
          (getLimit.limit.value.remainTradingLimit! * (1.0 + getfee)) /
              (price * getAccount.order!.value.lot!);
      qtyController.text = formattaCurrun(data.toInt());
      return data.toInt();
    }
  }

  int maxBuy(int type, int price) {
    if (type == 0) {
      double getfee = getAccount.order!.value.account!.first.onlineFeeBuy!;
      double data = getLimit.limit.value.cashonT3! /
          (price * (1.0 + getfee) * getAccount.order!.value.lot!);

      qtyController.text = formattaCurrun(data.toInt());
      return data.toInt();
    } else {
      double getfee = getAccount.order!.value.account!.first.onlineFeeBuy!;
      double data = getLimit.limit.value.remainTradingLimit! /
          (price * (1.0 + getfee) * getAccount.order!.value.lot!);

      qtyController.text = formattaCurrun(data.toInt());
      return data.toInt();
    }
  }

  int fee(bool sB, {String? price = '', String? qty = ''}) {
    return ((!sB
                ? getAccount.order!.value.account!.first.onlineFeeSell!
                : getAccount.order!.value.account!.first.onlineFeeBuy!) *
            stockEstimasi(price: price ?? '', qty: qty ?? ''))
        .toInt();
  }

  int stockEstimasi({String? price = '', String? qty = ''}) {
    return int.parse(
          qty != ''
              ? qty!.replaceAll(RegExp(r','), '')
              : qtyController.text.replaceAll(RegExp(r','), '') != ''
                  ? qtyController.text.replaceAll(RegExp(r','), '')
                  : '0',
        ) *
        int.parse(price != ''
            ? price!.replaceAll(RegExp(r','), '')
            : priceController.text != ''
                ? priceController.text.replaceAll(RegExp(r','), '')
                : '0') *
        getAccount.order!.value.lot!;
  }

  int nett(bool sB, {String? price = '', String? qty = ''}) {
    return (sB
            ? fee(sB, price: price ?? '', qty: qty ?? '') +
                stockEstimasi(price: price ?? '', qty: qty ?? '')
            : stockEstimasi(price: price ?? '', qty: qty ?? '') -
                fee(sB, price: price ?? '', qty: qty ?? ''))
        .toInt();
  }

  void onClear() {
    // Rx<TradingLimit> limit = TradingLimit().obs;
    // priceController.text = TextEditingController();
    if (aOrder.value == true) aOrder.toggle();
    if (randomSlit.value == true) randomSlit.toggle();
    if (aPriceStap.value == true) aPriceStap.toggle();
    if (sameOrder.value == false) sameOrder.toggle();
    stockEstimasiData.value = 0;
    qtyController.text = '0';
    splitTo.text = '0';
    priceStap.text = '0'; //Automatic Order Price Step
    autoPrice.text = '0'; //PriceStep

    idxIdController.text = '';
    orderIdController.text = '';
    boardController.text = '';
    bOrSController.text = '';
    cashT2Controller.text = '';
    accountId.text = '';
    stockCode.text = '';
  }
}

class Back extends GetxController {
  RxString type = ''.obs;
  Rx<ReqOrder> backOrder = ReqOrder().obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // ever(
    //   backOrder,
    //   (callback) {
    //     Get.defaultDialog(
    //       titleStyle: TextStyle(
    //         fontSize: FontSizes.size15,
    //         color: Colors.white,
    //       ),
    //       backgroundColor: foregroundwidget,
    //       title: 'Success',
    //       middleText: '',
    //     );
    //     Get.find<BodyController>().onClear();
    //   },
    // );
  }
}

class BuildingMassageOrderModel {
  int price;
  int pin;
  String stockCode;
  int board;
  int command;
  int volume; //lots
  int rendomSplit;
  int nSplit;
  int activPriceStep;
  int priceStep;
  int activAutoOrder;
  int autoOrderPriceStep;
  int prevSameOrder;

  BuildingMassageOrderModel({
    this.price = 0,
    this.pin = 0,
    this.stockCode = '',
    this.volume = 0,
    this.rendomSplit = 0,
    this.command = 0,
    this.nSplit = 0,
    this.activPriceStep = 0,
    this.priceStep = 0,
    this.activAutoOrder = 0,
    this.autoOrderPriceStep = 0,
    this.prevSameOrder = 0,
    this.board = 0,
  });
}

class DataFraksi {
  final int? flag;
  final List<ArrayFaksi>? array;

  DataFraksi({
    this.flag,
    this.array,
  });
}

class ArrayFaksi {
  final int? price;
  final int? fraction;

  ArrayFaksi({
    this.price,
    this.fraction,
  });
}

enum BoardOrder { REGULAR, CASH }
// Container(
//   padding: EdgeInsets.only(
//       left: size.width * 0.03, right: size.width * 0.03),
//   decoration: BoxDecoration(
//       color: bgabu, borderRadius: BorderRadius.circular(5)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     crossAxisAlignment: CrossAxisAlignment.center,
//     children: [
//       GestureDetector(
//         onTap: () {
//           controller.getPriceValue(10);
//           // setState(() {});
//         },
//         child: const Icon(
//           Icons.remove,
//           color: Colors.white,
//         ),
//       ),
//       SizedBox(
//         width: size.width * 0.2,
//         child: Center(
//           child: Text(
//             "$value",
//             style: const TextStyle(
//               color: Colors.white,
//             ),
//             textScaleFactor:
//                 ScaleSize.textScaleFactor(context) / 0.9,
//           ),
//         ),
//       ),
//       GestureDetector(
//         onTap: () {
//           increment();
//         },
//         child: const Icon(
//           Icons.add,
//           color: Colors.white,
//         ),
//       )
//     ],
//   ),
// )

bool delistingStock(String stockCode) {
  var stockSearce = ObjectBoxDatabase.stockList
      .query(PackageStockList_.stcokCode.equals(stockCode))
      .build()
      .findFirst();
  if (stockSearce != null) {
    return true;
  } else {
    return false;
  }
}
