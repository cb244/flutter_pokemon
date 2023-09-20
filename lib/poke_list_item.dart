import 'package:flutter/material.dart';
import 'package:pokemon/const/pokeapi.dart';
import 'package:pokemon/models/pokemon.dart';
import 'package:pokemon/poke_detail.dart';

class PokeListItem extends StatelessWidget {
  final Pokemon? poke;
  const PokeListItem({Key? key, required this.poke}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (poke != null) {
      return ListTile(
        leading: Container(
          width: 80,
          decoration: BoxDecoration(
            color: (pokeTypeColors[poke!.types.first] ?? Colors.grey[100])
                ?.withOpacity(.5),
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: NetworkImage(
                poke!.imageUrl,
              ),
            ),
          ),
        ),
        title: Text(
          poke!.name,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(poke!.types.first),
        trailing: const Icon(Icons.navigate_next),
        onTap: () => {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => PokeDetail(poke: poke!),
            ),
          ),
        },
      );
    } else {
      return const ListTile(
        title: Text('...'),
      );
    }
  }
}
