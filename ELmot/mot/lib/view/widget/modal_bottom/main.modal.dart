import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

double bottomPaddingForButton = 1.sw;
const double buttonHeight = 56.0;
double pagePadding = 0.8.sp;
const double pageBreakpoint = 768.0;
const double heroImageHeight = 200.0;

class BottomModal {
  static final pageIndexNotifier = ValueNotifier(0);

  static WoltModalSheetPage page1(
      BuildContext modalSheetContext, TextTheme textTheme, Widget child,
      {double? padding, String? title}) {
    return WoltModalSheetPage.withSingleChild(
      mainContentPadding: EdgeInsetsDirectional.zero,
      backgroundColor: bgabu,
      stickyActionBar: Padding(
        padding: EdgeInsets.all(padding ?? pagePadding),
        // child: Column(
        //   children: [
        //     ElevatedButton(
        //       onPressed: () => Navigator.of(modalSheetContext).pop(),
        //       child: const SizedBox(
        //         height: buttonHeight,
        //         width: double.infinity,
        //         child: Center(child: Text('Cancel')),
        //       ),
        //     ),
        //     const SizedBox(height: 8),
        //     ElevatedButton(
        //       onPressed: () =>
        //           pageIndexNotifier.value = pageIndexNotifier.value + 1,
        //       child: const SizedBox(
        //         height: buttonHeight,
        //         width: double.infinity,
        //         child: Center(child: Text('Next page')),
        //       ),
        //     ),
        //   ],
        // ),
      ),
      pageTitle: Center(
        child: Text(
          title ?? 'Filter Running Trades',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.sp,
          ),
        ),
      ),
      // isTopBarVisibleWhenScrolled: false,
      closeButton: IconButton(
        padding: EdgeInsets.all(pagePadding),
        icon: Icon(
          Icons.close,
          color: Colors.white,
          size: 25.sp,
        ),
        onPressed: Navigator.of(modalSheetContext).pop,
      ),
      child: Container(
        // padding: EdgeInsets.fromLTRB(
        //   pagePadding,
        //   pagePadding,
        //   pagePadding,
        //   bottomPaddingForButton,
        // ),
        padding: EdgeInsets.zero,
        // padding: EdgeInsets.fromLTRB(
        //   pagePadding,
        //   pagePadding,
        //   pagePadding,
        //   bottomPaddingForButton,
        // ),
        child: child,
      ),
    );
  }

  static WoltModalSheetPage page2(
    BuildContext modalSheetContext,
    TextTheme textTheme, {
    void Function()? onBack,
    required Widget sliverList,
  }) {
    return WoltModalSheetPage.withCustomSliverList(
      backgroundColor: bgabu,
      // stickyActionBar: Padding(
      //   padding:
      //       const EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, pagePadding),
      //   child: ElevatedButton(
      //     onPressed: () {
      //       Navigator.of(modalSheetContext).pop();
      //       pageIndexNotifier.value = 0;
      //     },
      //     child: const SizedBox(
      //       height: buttonHeight,
      //       width: double.infinity,
      //       child: Center(child: Text('Close')),
      //     ),
      //   ),
      // ),
      backButton: IconButton(
        padding: EdgeInsets.all(pagePadding),
        icon: Icon(
          Icons.arrow_back_rounded,
          color: Colors.white,
          size: 25.sp,
        ),
        onPressed: () {
          onBack;
          pageIndexNotifier.value = pageIndexNotifier.value - 1;
        },
      ),
      closeButton: IconButton(
        padding: EdgeInsets.all(pagePadding),
        icon: Icon(
          Icons.close,
          color: Colors.white,
          size: 25.sp,
        ),
        onPressed: () {
          Navigator.of(modalSheetContext).pop();
          pageIndexNotifier.value = 0;
        },
      ),
      sliverList: Container(child: sliverList),
    );
  }
}
