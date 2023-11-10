import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:online_trading/helper/constant_style.dart';

class HeaderModel {
  Widget label;
  AlignmentGeometry? alignment;
  EdgeInsetsGeometry? padding;
  TableColumnWidth? widthCol;

  HeaderModel({
    required this.label,
    this.alignment,
    this.widthCol,
    this.padding,
  });
}

class BodyModel {
  List<Widget> body;

  BodyModel({required this.body});
}

class MainTable extends StatelessWidget {
  const MainTable({
    super.key,
    this.widthC,
    this.heightC,
    required this.header,
    this.alignment,
    this.padding,
    required this.body,
    this.border,
    this.isScroll = false,
  });
  final bool isScroll;
  final double? widthC;
  final double? heightC;
  final List<HeaderModel> header;
  final List<BodyModel> body;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final double? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightC == null || heightC == 0 ? 0.5.sh : heightC,
      width: widthC == null || widthC == 0 ? 1.sw : widthC,
      alignment: alignment ?? Alignment.topCenter,
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        children: [
          Table(
            border: border == null
                ? null
                : TableBorder.all(
                    width: border!,
                    color: Colors.white,
                  ),
            columnWidths: buildTableWidth(header),
            children: [
              _buildHeader(header),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: !isScroll ? const NeverScrollableScrollPhysics() : null,
              child: Table(
                border: border == null
                    ? null
                    : TableBorder.all(
                        width: border!,
                        color: Colors.white,
                      ),
                columnWidths: buildTableWidth(header),
                children: [..._buildTableRows(body)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Map<int, TableColumnWidth> buildTableWidth(List<HeaderModel> model) {
  Map<int, TableColumnWidth> mapWidth = {};
  for (int i = 0; i < model.length; i++) {
    if (model[i].widthCol != null) {
      mapWidth.addAll(
        {
          i: model[i].widthCol!,
        },
      );
    }
  }
  return mapWidth;
}

TableRow _buildHeader(List<HeaderModel> header) {
  return TableRow(
    decoration: const BoxDecoration(),
    children: header
        .map(
          (e) => Container(
            height: 0.05.sh,
            color: foregroundwidget,
            padding: e.padding ?? EdgeInsets.all(5.w),
            alignment: e.alignment,
            child: e.label,
          ),
        )
        .toList(),
  );
}

List<TableRow> _buildTableRows(List<BodyModel> body) {
  return body.map((data) {
    return TableRow(
      children: data.body,
    );
  }).toList();
}
