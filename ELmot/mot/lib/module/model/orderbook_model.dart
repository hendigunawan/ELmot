import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202318)
class OrderBook {
  @Id()
  int id;
  String? stockC;
  int? stockCL;
  int? boardL;
  String? board;
  int? arrayOFBID; //nggak wajib di ambil hanya index array
  int? arrayOFOffer;
  @Property(type: PropertyType.date)
  int? lastUpdated;

  ToMany<Bid> arrayOBID = ToMany<Bid>();

  ToMany<Offer> arrayOOffer = ToMany<Offer>();

  OrderBook({
    this.id = 0,
    this.stockCL,
    this.stockC,
    this.boardL,
    this.board,
    this.arrayOFBID,
    // this.arrayOBID,
    this.arrayOFOffer,
    // this.arrayOOffer,
    this.lastUpdated,
  });
}

@Entity(uid: 1707202319)
class Bid {
  @Id()
  int id;
  int? bidPrice;
  int? bidVolume;
  int? bidNqueue;

  Bid({this.id = 0, this.bidPrice, this.bidVolume, this.bidNqueue});
}

@Entity(uid: 1707202340)
class Offer {
  @Id()
  int id;
  int? offerPrice;
  int? offerVolume;
  int? offerNqueue;

  Offer({this.id = 0, this.offerPrice, this.offerVolume, this.offerNqueue});
}
