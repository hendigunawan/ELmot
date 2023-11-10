import 'package:objectbox/objectbox.dart';

@Entity(uid: 2020220222)
class PERCOBAAN {
  @Id()
  int? id = 0;
  String? nama;
  int? newsDate;
  int? command;

  PERCOBAAN({this.newsDate, this.command, this.nama});
}
