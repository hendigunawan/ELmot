import 'dart:io';

import 'package:online_trading/view/widget/pdf/windget/createPDF.winget.part.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as p;

///To save the pdf file in the device
Future<File> saveAndLaunchFile(p.Document bytes, String fileName) async {
  //Get the storage folder location using path_provider package.
  String? path;
  if (Platform.isAndroid ||
      Platform.isIOS ||
      Platform.isLinux ||
      Platform.isWindows) {
    if (Platform.isAndroid) {
      var paths = "/storage/emulated/0/Download/MOT";
      // Create the Downloads directory if it doesn't exist
      if (!await Directory(paths).exists()) {
        await Directory(paths).create(recursive: true);
      }

      /// CREATING THE FILE NAME WITH THE GIVEN NAME
      // final file = File("$path/$fileName.pdf");
      path = paths;
    } else {
      final Directory directory = await getApplicationDocumentsDirectory();
      path = directory.path;
    }
  }
  final File file =
      File(Platform.isWindows ? '$path\\$fileName' : '$path/$fileName');
  await file.writeAsBytes(await bytes.save(), flush: true);
  if (Platform.isAndroid || Platform.isIOS) {
    //Launch the file (used open_file package)
    // await open_file.OpenFile.open('$path/$fileName', type: '.pdf');
    pdfPath.value = '$path/$fileName';
  } else if (Platform.isWindows) {
    await Process.run('start', <String>['$path\\$fileName'], runInShell: true);
  } else if (Platform.isMacOS) {
    await Process.run('open', <String>['$path/$fileName'], runInShell: true);
  } else if (Platform.isLinux) {
    await Process.run('xdg-open', <String>['$path/$fileName'],
        runInShell: true);
  }
  return file;
}
