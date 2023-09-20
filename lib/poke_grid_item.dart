import 'package:flutter/material.dart';
import 'package:pokemon/const/pokeapi.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/poke_detail.dart';

class PokeGridItem extends StatelessWidget {
  final Pokemon? poke;
  const PokeGridItem({Key? key, required this.poke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (poke != null) {
      return Column(
        children: [
          InkWell(
            onTap: () => {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) => PokeDetail(poke: poke!),
                ),
              ),
            },
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: (pokeTypeColors[poke!.types.first] ?? Colors.grey[100])
                    ?.withOpacity(.3),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(poke!.imageUrl),
                ),
              ),
            ),
          ),
          Text(
            poke!.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        ],
      );
    } else {
      return const SizedBox(
        height: 100,
        width: 100,
        child: Center(
          child: Text('...'),
        ),
      );
    }
  }
}
