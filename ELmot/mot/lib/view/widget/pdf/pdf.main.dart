import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';
import 'package:online_trading/helper/fontstyleConstans.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfMainPage extends StatelessWidget {
  final File path;
  const PdfMainPage({super.key, required this.path});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: PreferredSize(
          preferredSize: Size(1.sw, 40.h),
          child: AppBar(
            backgroundColor: Colors.black,
            leading: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: SizedBox(
                height: 10.h,
                width: 50.w,
                child: Icon(
                  Icons.arrow_back,
                  size: 25.sp,
                  color: putihop85,
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              "PDF",
              style: TextStyle(
                color: putihop85,
                fontSize: FontSizes.size16,
              ),
            ),
          ),
        ),
        body: SfPdfViewer.file(path),
      ),
    );
  }
}
