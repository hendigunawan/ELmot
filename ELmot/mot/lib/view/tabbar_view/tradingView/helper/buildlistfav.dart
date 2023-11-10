import 'package:online_trading/module/model/favoritelocal_model.dart';
import 'package:online_trading/module/objectbox/crud/crud_.dart';

class BuildListFav {
  static List<FavoriteLoacalB> list() {
    final getData = ObjectBoxDatabase.FavoriteLoacalBody;

    return getData.getAll();
  }
}
