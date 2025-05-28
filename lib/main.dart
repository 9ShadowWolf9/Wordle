import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/screens/settings_screen.dart';
import 'package:wordle/themes/theme_provider.dart';
import 'screens/game_screen.dart';
import 'models/word_list.dart';
import 'models/game_logic.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => GameState()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    print(WordList.getRandomWord().word);
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Builder(
            builder: (BuildContext context) {
              return ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    child: Center(child: Icon(Icons.account_balance, size: 40)),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Wordle'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              );
            },
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.settings, size: 32),
                  ),
                ),
              ),
              Text(
                'WORDLE',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Material(
                color: Colors.transparent,
                shape: CircleBorder(),
                child: InkWell(
                  customBorder: CircleBorder(),
                  onTap: () {
                    var word = WordList.getRandomWord();
                    print(word.word);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.refresh, size: 32),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: GameScreen(),
      ),
    );
  }
}
