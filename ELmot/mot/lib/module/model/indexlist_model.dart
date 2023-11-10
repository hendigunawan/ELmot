// import 'package:online_trading/objectbox.g.dart';

// @Entity(uid: 0608202301)
// class IndexTopList {
//   @Id()
//   int id = 0;
//   int? arrayL;
//   final array = ToMany<ArrayIndexTopList>();

//   IndexTopList({this.arrayL});
// }

// @Entity(uid: 0608202302)
// class ArrayIndexTopList {
//   @Id()
//   int id = 0;
//   int? indexCL;
//   String? indexC;
//   int? indexNL;
//   String? indexN;

// ignore_for_file: non_constant_identifier_names

//   ArrayIndexTopList({
//     this.indexCL,
//     this.indexC,
//     this.indexNL,
//     this.indexN,
//   });
// }
import 'package:objectbox/objectbox.dart';

@Entity(uid: 0508202356)
class IndexListTop45 {
  @Id()
  int id = 0;

  int? arrayL;
  final array = ToMany<ArrayIndexListTop45>();

  IndexListTop45({
    this.arrayL,
  });
}

@Entity(uid: 0508202357)
class ArrayIndexListTop45 {
  @Id()
  int id = 0;
  int? IndexCodeL;
  String? IndexCode;
  int? HashKeyL;
  String? HashKey;
  ArrayIndexListTop45(
      {this.IndexCodeL, this.IndexCode, this.HashKeyL, this.HashKey});
}
