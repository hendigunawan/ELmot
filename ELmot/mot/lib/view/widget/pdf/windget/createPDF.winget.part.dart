import 'dart:io';

import 'package:get/get.dart';
import 'package:online_trading/view/widget/pdf/apipd/savePdf.api.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as p;

RxString pdfPath = ''.obs;

class CreatePdfModelTableH {
  String? header;
  int? widthCol;
  bool isExpand;
  int? expand;
  CreatePdfModelTableH({
    this.header,
    this.widthCol,
    this.isExpand = false,
    this.expand,
  });
}

class CreatePdfModelTableF {
  String? header;
  int? widthCol;
  bool isExpand;
  int? expand;
  CreatePdfModelTableF({
    this.header,
    this.widthCol,
    this.isExpand = false,
    this.expand,
  });
}

class CreatePdfModelTableB {
  List<String>? body;
  CreatePdfModelTableB({
    this.body,
  });
}

class CreateTablePdf {
  List<CreatePdfModelTableH>? header;
  List<CreatePdfModelTableB>? body;
  List<CreatePdfModelTableF>? footer;
  CreateTablePdf({this.header, this.body, this.footer});
}

class CreatePdf {
  static Future<File> generate({
    String? nameFile,
    required p.Widget header,
    p.Widget? footer,
    required List<p.Widget> body,
  }) async {
    final pdf = p.Document();

    pdf.addPage(
      p.MultiPage(
        header: (context) => header,
        build: (context) => body,
        footer: (context) {
          final text = 'Page ${context.pageNumber} of ${context.pagesCount}';

          return p.Container(
            alignment: p.Alignment.centerRight,
            margin: const p.EdgeInsets.only(top: 1 * PdfPageFormat.cm),
            child: p.Text(
              text,
              style: const p.TextStyle(color: PdfColors.black),
            ),
          );
        },
      ),
    );

    return saveAndLaunchFile(pdf, nameFile ?? 'MOT.pdf');
  }
  // static Future openFile(File file) async {
  //   final url = file.path;

  //   await OpenFile.open(url);
  // }
}

// Future<void> createPdf({String? title = '', CreateTablePdf? dataTable}) async {
//   PdfDocument document = PdfDocument();
//   final page = document.pages.add();

// //HEADER OF PDF
//   PdfPageTemplateElement header = PdfPageTemplateElement(
//     Rect.fromLTWH(
//       0,
//       0,
//       document.pageSettings.size.width,
//       100,
//     ),
//   );

//   PdfDateTimeField dateAndTimeField = PdfDateTimeField(
//       font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
//       brush: PdfSolidBrush(PdfColor(0, 0, 0)));
//   dateAndTimeField.date = DateTime.now();
//   dateAndTimeField.dateFormatString = 'E, MM.dd.yyyy';

//   PdfCompositeField compositefields = PdfCompositeField(
//       font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
//       brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//       text: '{0}      $title',
//       fields: <PdfAutomaticField>[dateAndTimeField]);

//   compositefields.draw(header.graphics,
//       Offset(0, 10 - PdfStandardFont(PdfFontFamily.timesRoman, 11).height));

//   document.template.top = header;
// //END OF HEADER PDF

//   page.graphics.drawLine(PdfPen(PdfColor(165, 42, 42), width: 5),
//       Offset(100, 100), Offset(10, 200));

//   table(page, dataTable);

//   List<int> byte = document.saveSync();
//   document.dispose();

//   saveAndLaunchFile(byte, 'PdfExampleHendi.pdf');
// }

// Future<void> table(PdfPage? page, CreateTablePdf? dataTable) async {
// //TABLE OF PDF
//   if (dataTable != null) {
//     PdfGridStyle gridStyle = PdfGridStyle(
//       cellSpacing: 0,
//       cellPadding: PdfPaddings(left: 2, right: 3, top: 4, bottom: 5),
//       borderOverlapStyle: PdfBorderOverlapStyle.overlap,
//       backgroundBrush: PdfBrushes.lightGray,
//       font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
//     );

//     PdfGridRowStyle rowStyle = PdfGridRowStyle(
//         backgroundBrush: PdfBrushes.white,
//         font: PdfStandardFont(PdfFontFamily.timesRoman, 12));

//     PdfGrid grid = PdfGrid();
//     grid.style = PdfGridStyle(
//       font: PdfStandardFont(PdfFontFamily.helvetica, 11),
//       cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2),
//     );
//     if (dataTable.header != null) {
//       grid.columns.add(count: dataTable.header!.length);
//       grid.headers.add(1);

//       PdfGridRow headerGrid = grid.headers[0];
//       for (int i = 0; i < dataTable.header!.length; ++i) {
//         headerGrid.cells[i].value = dataTable.header![i].header;
//       }
//       for (var i = 0; i < dataTable.header!.length; i++) {
//         if (dataTable.header![i].isExpand) {
//           headerGrid.cells[i].columnSpan = dataTable.header![i].expand!;
//         }
//       }
//       for (var i = 0; i < dataTable.header!.length; i++) {
//         if (dataTable.header![i].widthCol != null) {
//           grid.columns[i].width = dataTable.header![i].widthCol!.toDouble();
//         }
//       }
//       grid.rows.applyStyle(gridStyle);
//     }

//     if (dataTable.body != null) {
//       for (var i = 0; i < dataTable.body!.length; i++) {
//         PdfGridRow row = grid.rows.add();
//         for (var x = 0; x < dataTable.body![i].body!.length; x++) {
//           row.cells[x].value = dataTable.body![i].body![x];
//         }
//         row.style = rowStyle;
//       }
//     }

//     PdfLayoutResult result = grid.draw(
//       page: page,
//       bounds: const Rect.fromLTWH(0, 0, 0, 0),
//     ) as PdfLayoutResult;
//     if (dataTable.footer != null) {
//       PdfGrid grid2 = PdfGrid();
//       grid2.columns.add(count: dataTable.footer!.length);
//       grid2.headers.add(1);

//       grid2.style = PdfGridStyle(
//         font: PdfStandardFont(PdfFontFamily.timesRoman, 12),
//         cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2),
//       );
//       grid2.rows.applyStyle(gridStyle);
//       PdfGridRow header1 = grid2.headers[0];
//       for (int i = 0; i < dataTable.footer!.length; ++i) {
//         header1.cells[i].value = dataTable.footer![i].header;
//       }
//       for (var i = 0; i < dataTable.footer!.length; i++) {
//         if (dataTable.footer![i].isExpand) {
//           header1.cells[i].columnSpan = dataTable.footer![i].expand!;
//         }
//       }

//       grid2.draw(
//         page: result.page,
//         bounds: Rect.fromLTWH(0, result.bounds.bottom, 0, 0),
//       );
//     }
//     //END FOOTER
//   }
// //END OF TABLE PDF
// }
