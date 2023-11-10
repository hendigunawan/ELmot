import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202341)
class InfoMobile {
  @Id()
  int id = 0;
  String? clientTag;
  String? ipAddressMobile;
  String? ipAddressWifi;

  InfoMobile({this.ipAddressMobile, this.ipAddressWifi, this.clientTag});
}

@Entity(uid: 1707202342)
class ListSaham {
  @Id()
  int id = 0;
  String? stockCode;
  int? stockCodeL;

  ListSaham({this.stockCodeL, this.stockCode});
}

@Entity(uid: 1707202343)
class HashKey {
  @Id()
  int id = 0;
  int? codeName;
  int? hashKeyL;
  String? hashKeyOLD;
  String? hashKeyNEW;

  HashKey({this.codeName, this.hashKeyL, this.hashKeyOLD, this.hashKeyNEW});
}
