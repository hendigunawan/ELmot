// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';

const List<String> gtcIdData = [
  "Sub Date",
  "Sub Time",
  "StockCode",
  "Command",
  "Effect Date",
  "Due Date",
  "SessionId",
  "Flags",
  "ExchangeCode",
  "MarketCode",
  "Expiry",
  "Price",
  "OQty",
  "RQty",
  "TQty",
  "Price Step",
  "Sub Status",
  "SourceId",
  "InputUser",
  "CancelUser"
];

List<Widget> getHeaderWidgetGTC() {
  List<String> dataHeader = gtcIdData.sublist(4);
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
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                child: Text(
                  gtcIdData[0],
                  style: TextStyle(
                    color: putihop85,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              Container(
                height: 33.h,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.w,
                    ),
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  gtcIdData[1],
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
                  gtcIdData[2],
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
                  gtcIdData[3],
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
              dataHeader[12],
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
              dataHeader[14],
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
              dataHeader[15],
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
