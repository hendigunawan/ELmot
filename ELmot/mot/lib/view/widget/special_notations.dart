import 'package:online_trading/helper/constants.dart';

StringBuffer specialNotations(string) {
  List<String> getString = string.toString().substring(0).split('');
  // print(getString);
  // List<String> list = [];
  StringBuffer add = StringBuffer();
  for (String getS in getString) {
    if (getS.toString() == 'A') {
      add.write('A: ${Constans.A}\n');
    } else if (getS.toString() == 'B') {
      add.write('B: ${Constans.B}\n');
    } else if (getS.toString() == 'C') {
      add.write('C: ${Constans.C}\n');
    } else if (getS.toString() == 'D') {
      add.write('D: ${Constans.D}\n');
    } else if (getS.toString() == 'E') {
      add.write('E: ${Constans.E}\n');
    } else if (getS.toString() == 'F') {
      add.write('F: ${Constans.F}\n');
    } else if (getS.toString() == 'G') {
      add.write('G: ${Constans.G}\n');
    } else if (getS.toString() == 'I') {
      add.write('I: ${Constans.I}\n');
    } else if (getS.toString() == 'K') {
      add.write('K: ${Constans.K}\n');
    } else if (getS.toString() == 'L') {
      add.write('L: ${Constans.L}\n');
    } else if (getS.toString() == 'M') {
      add.write('M: ${Constans.M}\n');
    } else if (getS.toString() == 'N') {
      add.write('N: ${Constans.N}\n');
    } else if (getS.toString() == 'V') {
      add.write('V: ${Constans.V}\n');
    } else if (getS.toString() == 'X') {
      add.write('X: ${Constans.X}\n');
    }
  }
  return add;
}
