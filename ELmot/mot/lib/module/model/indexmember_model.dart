import 'package:objectbox/objectbox.dart';

@Entity()
class IndexMember {
  @Id()
  int id;
  int? indexCodeL;
  String? indexCode;
  int? arrayL;
  final array = ToMany<ListMember>();

  IndexMember({
    this.id = 0,
    this.indexCodeL,
    this.indexCode,
    this.arrayL,
  });
}

@Entity()
class ListMember {
  @Id()
  int id;
  int? stockCodeL;
  String? stockCode;

  ListMember({this.id = 0, this.stockCodeL, this.stockCode});
}
