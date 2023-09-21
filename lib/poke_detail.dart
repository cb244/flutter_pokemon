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
                            height: 250,
                            width: 250,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(90),
                      color: Colors.white.withOpacity(.5),
                    ),
                    child: Text(
                      '#${poke.id.toString().padLeft(3, '0')}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      '${poke.name.substring(0, 1).toUpperCase()}${poke.name.substring(1)}',
                      style: const TextStyle(
                          fontSize: 36, fontWeight: FontWeight.bold),
                    ),
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
