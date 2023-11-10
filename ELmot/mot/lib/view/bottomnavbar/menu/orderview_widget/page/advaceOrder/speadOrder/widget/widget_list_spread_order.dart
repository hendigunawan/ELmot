import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';

class WidgetListSpreadOrder extends StatelessWidget {
  const WidgetListSpreadOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return HorizontalDataTable(
        elevation: 0,
        rowSeparatorWidget: Divider(
          height: 2.h,
          thickness: 0.05,
        ),
        leftHandSideColumnWidth: 0.6.sw,
        rightHandSideColumnWidth: 2.sw,
        isFixedHeader: true,
        leftHandSideColBackgroundColor: Colors.black,
        rightHandSideColBackgroundColor: Colors.black,
      );
    });
  }
}
