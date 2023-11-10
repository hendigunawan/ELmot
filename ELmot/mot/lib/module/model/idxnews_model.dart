import 'package:objectbox/objectbox.dart';

@Entity(uid: 170720235)
class IDXNews {
  @Id()
  int? id = 0;
  int? newsDate;
  int? command;
  int? array;

  final arrayList = ToMany<ArrayNews>();
  IDXNews({this.newsDate, this.command, this.array});
}

@Entity(uid: 1707202339)
class ArrayNews {
  @Id()
  int? id = 0;
  int? newsId;
  int? time;
  int? subjectLen;
  String? subject;
  int? headlineLen;
  String? headline;
  int? contentLen;
  String? content;
  // edit ini this. nya ketinggalan
  ArrayNews({
    this.id,
    this.newsId,
    this.time,
    this.subjectLen,
    this.subject,
    this.headlineLen,
    this.headline,
    this.contentLen,
    this.content,
  });
}
