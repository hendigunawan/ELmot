import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

import '../model/tablePDF.model.dart';

class WigetPdf {
  static Widget header({required String title}) {
    return Container(
      height: 60.h,
      padding: const EdgeInsets.only(bottom: 3 * PdfPageFormat.mm),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: PdfColors.blue,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, color: PdfColors.blue),
          ),
        ],
      ),
    );
  }

  static Widget table({
    required List<TableModelHederPDF> header,
    List<TableModelBodyPDF>? body,
    List<TableModelHederPDF>? footer,
    double? border,
  }) {
    return Column(
      children: [
        Table(
          border: border == null ? null : TableBorder.all(width: border),
          columnWidths: _buildTableWidthPDF(header),
          children: [_buildHeader(header)],
        ),
        if (body != null)
          Table(
            border: border == null ? null : TableBorder.all(width: border),
            columnWidths: _buildTableWidthPDF(header),
            children: [..._buildTableRows(body)],
          ),
        if (footer != null)
          Table(
            border: border == null ? null : TableBorder.all(width: border),
            columnWidths: _buildTableWidthPDF(footer),
            children: [_buildHeader(footer)],
          ),
      ],
    );
  }
}

Map<int, TableColumnWidth> _buildTableWidthPDF(List<TableModelHederPDF> model) {
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

TableRow _buildHeader(List<TableModelHederPDF> header) {
  return TableRow(
    decoration: const BoxDecoration(),
    children: header
        .map(
          (e) => Container(
            height: Get.height * 0.05,
            color: const PdfColor.fromInt(0xFF5B6063),
            padding: e.padding ?? const EdgeInsets.all(5),
            alignment: e.alignment,
            child: e.label,
          ),
        )
        .toList(),
  );
}

List<TableRow> _buildTableRows(List<TableModelBodyPDF> body) {
  return body.map((data) {
    return TableRow(
      children: data.body,
    );
  }).toList();
}
