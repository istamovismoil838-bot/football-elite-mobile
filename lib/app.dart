import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'core/engine/game_engine.dart';
import 'core/engine/performance_monitor.dart';
import 'core/constants/app_constants.dart';
import 'ui/themes/app_theme.dart';
import 'screens/main_menu.dart';
import 'screens/loading_screen.dart';

class FootballEliteApp extends StatefulWidget {
  const FootballEliteApp({super.key});

  @override
  State<FootballEliteApp> createState() => _FootballEliteAppState();
}

class _FootballEliteAppState extends State<FootballEliteApp> {
  bool _isLoading = true;
  String _loadingText = 'Initializing...';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // GetIt (Dependency Injection) ni sozlash
    final getIt = GetIt.instance;
    getIt.registerSingleton<GameEngine>(GameEngine());
    getIt.registerSingleton<PerformanceMonitor>(PerformanceMonitor());
    
    // O'yin dvigatelini ishga tushirish
    await getIt<GameEngine>().initialize();
    
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.APP_NAME,
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: _isLoading 
        ? LoadingScreen(loadingText: _loadingText)
        : const MainMenu(),
    );
  }
}
