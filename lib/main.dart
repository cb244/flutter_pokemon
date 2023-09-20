import 'package:flutter/material.dart';
import 'package:pokemon/poke_list.dart';
import 'package:pokemon/settings.dart';
import 'package:pokemon/utils/favorites.dart';
import 'package:pokemon/utils/poke_map.dart';
import 'package:pokemon/utils/theme_mode.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // runApp前にFlutterEngineの機能を使いたい場合に呼び出すメソッド
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final themeModeNotifier = ThemeModeNotifier(pref);
  final pokemonNotifier = PokemonNotifier();
  final favoritesNotifier = FavoritesNotifier();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeModeNotifier>(
        create: (context) => themeModeNotifier,
      ),
      ChangeNotifierProvider<PokemonNotifier>(
        create: (context) => pokemonNotifier,
      ),
      ChangeNotifierProvider<FavoritesNotifier>(
        create: (context) => favoritesNotifier,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModeNotifier>(
      builder: (context, mode, child) => MaterialApp(
        title: 'Pokemon Flutter',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: mode.mode,
        home: const TopPage(),
      ),
    );
  }
}

class TopPage extends StatefulWidget {
  const TopPage({Key? key}) : super(key: key);

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  int currentbnb = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentbnb,
          children: const [PokeList(), Settings()],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => {
          setState(
            () => currentbnb = index,
          )
        },
        currentIndex: currentbnb,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'settings',
          ),
        ],
      ),
    );
  }
}
