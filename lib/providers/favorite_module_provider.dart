import 'package:flutter/foundation.dart';
import 'package:pickeat_app/data/model/restaurant.dart';

class FavoriteModuleProvider with ChangeNotifier {
  final List<Restaurant> _favList = [];
  get favList => this._favList;

  static List<Restaurant> tf = [];

  void add(Restaurant restaurant) {
    _favList.add(restaurant);
    tf.add(restaurant);
    notifyListeners();
  }

  void remove(Restaurant restaurant) {
    _favList.remove(restaurant);
    notifyListeners();
  }
}
