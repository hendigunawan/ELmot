// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:online_trading/module/model/packagestocklist_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';
import 'package:online_trading/module/request/activity/acty_request.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/lotdetail.dart';
import 'package:online_trading/view/checkoutview/widgetcheckout/quotescheckout.dart';

import 'package:searchfield/searchfield.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget(
      {super.key,
      required this.onFinnis,
      this.hint,
      this.onPressedX,
      required this.controller,
      this.typescreen,
      this.autofocuskeyboard,
      this.onCheckout,
      this.actiontype,
      this.onGTC,
      this.isEmptyandhide});
  final RxBool? isEmptyandhide;
  final bool? autofocuskeyboard;
  final bool? typescreen;
  final bool? onCheckout;
  final bool? onGTC;
  final TextEditingController? controller;
  final String? hint;

  final Function(String) onFinnis;
  void Function()? onPressedX;
  final String? actiontype;
  final open = ObjectBoxDatabase.stockList;
  List<SearchFieldListItem<PackageStockList>> generateSearchSuggestions(
      String query) {
    final List<PackageStockList> filteredList = open.getAll().where((item) {
      final String stockC = item.stcokCode.toString().toLowerCase();
      final String id = item.stockName.toString().toLowerCase();
      final String lowerQuery = query.toLowerCase();

      return stockC.contains(lowerQuery) || id.contains(lowerQuery);
    }).toList();

    return filteredList
        .map((e) => SearchFieldListItem(
              e.stockName.toString() + e.stcokCode.toString(),
              item: e,
              child: TapRegion(
                onTapInside: (a) {
                  FocusScope.of(Get.context!).requestFocus();
                },
                onTapOutside: (a) {
                  FocusScope.of(Get.context!).unfocus();
                },
                child: Container(
                  width: double.infinity,
                  height: 50.h,
                  color: Colors.transparent,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.stcokCode.toString(),
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size12),
                      ),
                      Text(
                        e.stockName.toString(),
                        style: TextStyle(
                            color: putihop85, fontSize: FontSizes.size12),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    focusNode.requestFocus();
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(
        right: 10.w,
      ),
      color: Colors.transparent,
      alignment: Alignment.center,
      child: SearchField<PackageStockList>(
        focusNode: autofocuskeyboard == true ? focusNode : FocusNode(),
        itemHeight: 50.h,
        controller: controller,
        suggestions: generateSearchSuggestions(controller!.text),
        searchStyle: TextStyle(
          color: Colors.white,
          fontSize: FontSizes.size14,
          textBaseline: TextBaseline.alphabetic,
        ),
        textInputAction: TextInputAction.search,
        onSuggestionTap: (value) {
          onFinnis(value.item!.stcokCode!);

          if (isSearchq.value == true) isSearchq.toggle();
          if (isMore.value == true) {
            isMore.toggle();
            isMore.refresh();
          }
        },
        suggestionsDecoration: SuggestionDecoration(
          padding: EdgeInsets.only(
            left: 10.w,
          ),
          color: bgabu,
        ),
        suggestionState: Suggestion.hidden,
        suggestionAction: SuggestionAction.unfocus,
        validator: (p0) {
          return null;
        },
        searchInputDecoration: InputDecoration(
          contentPadding: EdgeInsets.all(10.w),
          isCollapsed: true,
          prefixIcon: Padding(
            padding: EdgeInsets.only(right: 5.w, left: 5.w),
            child: Icon(
              Icons.search,
              color: foregroundwidget2,
              size: 18.sp,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 30.h,
            maxWidth: 30.w,
          ),
          suffixIcon: GestureDetector(
            onTap: onPressedX,
            child: Padding(
                padding: EdgeInsets.only(right: 5.w, left: 5.w),
                child: Icon(
                  Icons.close,
                  color: foregroundwidget2,
                  size: 20.sp,
                )),
          ),
          suffixIconConstraints: BoxConstraints(
            maxHeight: 30.h,
            maxWidth: 30.w,
          ),
          filled: true,
          fillColor: bgabu,
          border: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

void activity(String stockCode) {
  ActivityRequest.quoteRequest(
    packageId: Constans.PACKAGE_ID_QUOTES,
    arrayStockCode: [
      ArrayStockCode(
        stockCode: stockCode,
        board: "RG",
      )
    ],
    commant: 1,
  );

  ActivityRequest.orderBookRequest(
    packageId: Constans.PACKAGE_ID_ORDER_BOOK,
    stockCode: stockCode,
    commant: '1',
    board: 'RG',
  );
}
