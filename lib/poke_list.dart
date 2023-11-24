import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './models/pokemon.dart';
import './const/pokeapi.dart';
import './poke_list_item.dart';
import './db/favorite.dart';

class PokeList extends StatefulWidget {
  const PokeList({Key? key}) : super(key: key);
  @override
  _PokeListState createState() => _PokeListState();
}

class _PokeListState extends State<PokeList> {
  static const int pageSize = 30;
  //bool isFavoriteMode = false;
  bool isFavoriteMode = true;
  int _currentPage = 1;

  List<Favorite> favMock = [
    Favorite(pokeId: 1),
    Favorite(pokeId: 4),
    Favorite(pokeId: 7),
    Favorite(pokeId: 25),
  ];

  bool isLastPage(int page) {
    if (isFavoriteMode) {
      if (_currentPage * pageSize < favMock.length) {
        return false;
      }
      return true;
    } else {
      if (_currentPage * pageSize < pokeMaxId) {
        return false;
      }
      return true;
    }
  }

  // 表示個数
  int itemCount() {
    int ret = _currentPage * pageSize;
    if (isFavoriteMode && ret > favMock.length) {
      ret = favMock.length;
    }
    if (ret > pokeMaxId) {
      ret = pokeMaxId;
    }
    return ret;
  }

  int itemId(int index) {
    int ret = index + 1; // 通常モード
    if (isFavoriteMode) {
      ret = favMock[index].pokeId;
    }
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 24,
          alignment: Alignment.topRight,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(Icons.star_outline),
            onPressed: () => {setState(() => isFavoriteMode = !isFavoriteMode)},
          ),
        ),
        Expanded(
          child: Consumer<PokemonsNotifier>(
            builder: (context, pokes, child) => ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              itemCount: itemCount() + 1,
              itemBuilder: (context, index) {
                if (index == itemCount()) {
                  return OutlinedButton(
                    child: const Text('more'),
                    onPressed: isLastPage(_currentPage)
                        ? null
                        : () => {
                            setState(()=> _currentPage++),
                        },
                  );
                } else {
                  return PokeListItem(
                    poke: pokes.byId(itemId(index)),
                  );
                }
              },
            ),
          )
        ),
      ],
    );
    
  }
}
