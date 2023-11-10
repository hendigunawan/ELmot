import 'package:pdf/widgets.dart';

class TableModelHederPDF {
  Widget label;
  Alignment? alignment;
  EdgeInsets? padding;
  TableColumnWidth? widthCol;

  TableModelHederPDF({
    required this.label,
    this.alignment,
    this.padding,
    this.widthCol = const FlexColumnWidth(1),
  });
}

class TableModelBodyPDF {
  List<Widget> body;

  TableModelBodyPDF({required this.body});
}
