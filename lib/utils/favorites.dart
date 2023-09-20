import 'package:flutter/cupertino.dart';
import 'package:pokemon/db/favorites.dart';
import 'package:pokemon/models/favorite.dart';

class FavoritesNotifier extends ChangeNotifier {
  final List<Favorite> _favs = [];
  List<Favorite> get favs => _favs;

  FavoritesNotifier() {
    syncDb();
  }

  void toggle(int pokeId) {
    isExist(pokeId) ? delete(pokeId) : add(pokeId);
  }

  bool isExist(int pokeId) {
    return _favs.indexWhere((fav) => fav.pokeId == pokeId) >= 0;
  }

  void syncDb() async {
    FavoritesDb.read().then(
      (val) => _favs
        ..clear()
        ..addAll(val),
    );
    notifyListeners();
  }

  void add(int pokeId) async {
    await FavoritesDb.create(Favorite(pokeId: pokeId));
    syncDb();
  }

  void delete(int pokeId) async {
    await FavoritesDb.delete(pokeId);
    syncDb();
  }
}
