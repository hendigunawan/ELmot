import 'package:get/get.dart';
import 'package:online_trading/core/rabbitmq/data_proses.dart';
import 'package:online_trading/helper/constants.dart';
import 'package:online_trading/helper/encrypt.dart';
import 'model/idxnews_model.dart';

updateIDXNews() {
  var getController = Get.find<EncryptControll>();
  getController.readPos.value = Constans.PACKAGE_HEADER_LENGTH;
  IDXNews listIDXNews = IDXNews();
  List<ArrayNews> addDataNews = [];

  int newsDate = getController.encrypt4(buf);
  int command = getController.encrypt1(buf);
  int arrayData = getController.encrypt4(buf);
  for (int i = 0; i < arrayData; i++) {
    int addnewsId = getController.encrypt4(buf);
    int addtime = getController.encrypt4(buf);
    int addsubjectL = getController.encrypt2(buf);
    String addsubject = getController.getAsciiString(buf, addsubjectL);
    int addheadlineL = getController.encrypt2(buf);
    String addheadline = getController.getAsciiString(buf, addheadlineL);
    int addcontentL = getController.encrypt2(buf);
    String addcontent = getController.getAsciiString(buf, addcontentL);

    addDataNews.add(ArrayNews()
      ..newsId = addnewsId
      ..time = addtime
      ..subjectLen = addsubjectL
      ..subject = addsubject
      ..headlineLen = addheadlineL
      ..headline = addheadline
      ..contentLen = addcontentL
      ..content = addcontent);
  }
  listIDXNews = IDXNews(
    newsDate: newsDate.toInt(),
    command: command.toInt(),
    array: arrayData,
  );
  return listIDXNews.toString();
}
