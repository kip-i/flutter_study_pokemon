import 'package:flutter/material.dart';
import '../db/favorites.dart';

class FavoritesNotifier extends ChangeNotifier {
  final List<Favorite> _favs = [];

  List<Favorite> get favs => _favs;

  void add(Favorite fav) {
    favs.add(fav);
    notifyListeners();
  }

  void delete(Favorite fav) {
    var res = favs.remove(fav);
    if (res) {
      notifyListeners();
    }
    // エラー処理あった方が良い
  }
}
