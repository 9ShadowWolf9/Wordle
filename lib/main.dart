import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wordle/screens/how_to_play.dart';
import 'package:wordle/screens/settings_screen.dart';
import 'package:wordle/themes/theme_provider.dart';
import 'models/local_dictionary.dart';
import 'screens/game_screen.dart';
import 'models/word_list.dart';
import 'models/game_logic.dart';
import 'package:url_launcher/url_launcher.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDictionary.loadDictionary();
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

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchGooglePlay() async {
    const url =
        'https://play.google.com/store/apps/details?id=pl.bocianpozyczki.portmoneta';
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Provider.of<ThemeProvider>(context).themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: scaffoldKey,
        drawer: Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Center(
                  child: Image(image: AssetImage('assets/bocian.png')),
                ),
              ),
              Builder(
                builder:
                    (context) => ListTile(
                      leading: Icon(Icons.home),
                      title: Text('Wordle'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
              ),
              Builder(
                builder:
                    (context) => ListTile(
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
              ),
              Builder(
                builder:
                    (context) => ListTile(
                      leading: Icon(Icons.question_mark),
                      title: Text('How To Play'),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HowToPlay()),
                        );
                      },
                    ),
              ),
              Spacer(),
              Builder(
                builder:
                    (context) => ListTile(
                      leading: Icon(Icons.open_in_new),
                      title: Text('Get Official App'),
                      onTap: () {
                        Navigator.pop(context);
                        _launchGooglePlay();
                      },
                    ),
              ),
            ],
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
                    Provider.of<GameState>(context, listen: false).reset();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<GameState>(
                      builder: (context, gameState, _) {
                        if (gameState.gameOver && !_isAnimating) {
                          _controller.repeat(reverse: true);
                          _isAnimating = true;
                        } else if (!gameState.gameOver && _isAnimating) {
                          _controller.stop();
                          _controller.reset();
                          _isAnimating = false;
                        }

                        return ScaleTransition(
                          scale: _scaleAnimation,
                          child: Icon(
                            Icons.refresh,
                            size: 32,
                            color:
                                gameState.gameOver ? Colors.red : Colors.black,
                          ),
                        );
                      },
                    ),
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
