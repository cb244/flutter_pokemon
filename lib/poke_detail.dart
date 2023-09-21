import 'package:flutter/material.dart';
import 'package:pokemon/const/pokeapi.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/utils/favorites.dart';
import 'package:provider/provider.dart';

class PokeDetail extends StatelessWidget {
  final Pokemon poke;
  const PokeDetail({Key? key, required this.poke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesNotifier>(
      builder: (context, favs, child) => Scaffold(
        body: Container(
          color: (pokeTypeColors[poke.types.first] ?? Colors.grey[100])
              ?.withOpacity(.5),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    trailing: IconButton(
                      icon: favs.isExist(poke.id)
                          ? const Icon(Icons.star, color: Colors.orangeAccent)
                          : const Icon(Icons.star_outline),
                      onPressed: () => favs.toggle(poke.id),
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          height: 280,
                          width: 280,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(180),
                            color: Colors.white.withOpacity(.5),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(32),
                        child: Hero(
                          tag: poke.name,
                          child: Image.network(
                            poke.imageUrl,
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'No.${poke.id}',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    poke.name,
                    style: const TextStyle(
                        fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: poke.types
                        .map((type) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Chip(
                                backgroundColor:
                                    pokeTypeColors[type] ?? Colors.grey,
                                label: Text(
                                  type,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: ThemeData.estimateBrightnessForColor(
                                                pokeTypeColors[type] ??
                                                    Colors.grey) ==
                                            Brightness.light
                                        ? Colors.black
                                        : Colors.white,
                                  ),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
