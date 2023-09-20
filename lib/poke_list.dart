import 'package:flutter/material.dart';
import 'package:pokemon/const/pokeapi.dart';
import 'package:pokemon/models/favorite.dart';
import 'package:pokemon/poke_grid_item.dart';
import 'package:pokemon/poke_list_item.dart';
import 'package:pokemon/utils/favorites.dart';
import 'package:pokemon/utils/poke_map.dart';
import 'package:pokemon/view_mode_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;
  bool isFavoriteMode = true;
  bool isGridMode = true;
  int _currentPage = 1;

  int itemCount(int page, List<Favorite> favs) {
    int ret = page * pageSize;
    if (isFavoriteMode) {
      ret = (ret > favs.length) ? favs.length : ret;
    }
    return (ret > pokeMaxId) ? pokeMaxId : ret;
  }

  int itemId(int index, List<Favorite> favs) {
    return isFavoriteMode ? favs[index].pokeId : index + 1;
  }

  bool isLastPage(int page, List<Favorite> favs) {
    if (isFavoriteMode) {
      return (page * pageSize) >= favs.length;
    } else {
      return (page * pageSize) >= pokeMaxId;
    }
  }

  void changeFavoriteMode() {
    setState(() => isFavoriteMode = !isFavoriteMode);
  }

  void changeGridMode() {
    setState(() => isGridMode = !isGridMode);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, favs, child) => Column(
        children: [
          Container(
            height: 24,
            alignment: Alignment.topRight,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(Icons.auto_awesome_outlined),
              onPressed: () async {
                var ret = await showModalBottomSheet<String>(
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return ViewModeBottomSheet(
                      favMode: isFavoriteMode,
                      gridMode: isGridMode,
                    );
                  },
                );
                if (ret != null) {
                  if (ret == 'fav') changeFavoriteMode();
                  if (ret == 'grid') changeGridMode();
                }
              },
            ),
          ),
          Expanded(
            child: Consumer<PokemonNotifier>(
              builder: (context, pokes, child) {
                if (itemCount(_currentPage, favs.favs) == 0) {
                  return const Text('no data');
                } else {
                  if (isGridMode) {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: itemCount(_currentPage, favs.favs),
                      itemBuilder: (context, index) {
                        if (index == itemCount(_currentPage, favs.favs)) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              onPressed: isLastPage(_currentPage, favs.favs)
                                  ? null
                                  : () => {setState(() => _currentPage++)},
                              child: const Text('more'),
                            ),
                          );
                        } else {
                          return PokeGridItem(
                            poke: pokes.byId(itemId(index, favs.favs)),
                          );
                        }
                      },
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 16),
                      itemCount: itemCount(_currentPage, favs.favs) + 1,
                      itemBuilder: (context, index) {
                        if (index == itemCount(_currentPage, favs.favs)) {
                          return OutlinedButton(
                            onPressed: isLastPage(_currentPage, favs.favs)
                                ? null
                                : () => {setState(() => _currentPage++)},
                            child: const Text('more'),
                          );
                        } else {
                          return PokeListItem(
                            poke: pokes.byId(itemId(index, favs.favs)),
                          );
                        }
                      },
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
