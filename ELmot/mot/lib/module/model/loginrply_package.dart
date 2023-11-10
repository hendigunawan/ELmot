import 'package:objectbox/objectbox.dart';

@Entity(uid: 1707202313)
class loginObject {
  @Id()
  int id = 0;
  int? loginIdL;
  String? loginId;
  int? errorCode;
  int? lotSize;
  loginObject({this.loginIdL, this.loginId, this.errorCode, this.lotSize});
}
