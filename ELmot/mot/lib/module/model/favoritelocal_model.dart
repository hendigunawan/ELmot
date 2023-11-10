import 'package:objectbox/objectbox.dart';

@Entity(uid: 11082023028)
class FavoriteLoacalH {
  @Id()
  int id = 0;
  String? clientTag;
  FavoriteLoacalH({this.clientTag});
}

@Entity(uid: 11082023029)
class FavoriteLoacalB {
  @Id()
  int id = 0;
  String? groupTag;
  final header = ToOne<FavoriteLoacalH>();
  final member = ToMany<FavoriteLocalM>();
  FavoriteLoacalB({this.groupTag});
}

@Entity(uid: 11082023030)
class FavoriteLocalM {
  @Id()
  int id = 0;
  String? stockCode;
  FavoriteLocalM({this.stockCode});
}
