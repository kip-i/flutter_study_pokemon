import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/pokemon.dart';
import './const/pokeapi.dart';
import './poke_list_item.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;
  int _currentPage = 1;

  // 表示個数
  int itemCount() {
    int ret = _currentPage * pageSize;
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PokemonsNotifier>(
      builder: (context, pokes, child) => ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        itemCount: itemCount() + 1,
        itemBuilder: (context, index) {
          if (index == itemCount()) {
            return OutlinedButton(
              child: const Text('more'),
              onPressed: () => {
                setState(() => _currentPage++),
              },
            );
          } else {
            return PokeListItem(
              poke: pokes.byId(index + 1),
            );
          }
        },
      ),
    );
  }
}
