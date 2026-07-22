import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'game_loop.dart';
import 'state_machine.dart';
import 'event_bus.dart';
import 'performance_monitor.dart';
import '../constants/game_constants.dart';

class GameEngine {
  static GameEngine? _instance;
  static GameEngine get instance => _instance ??= GameEngine._();
  
  GameEngine._();
  
  late GameLoop _gameLoop;
  late StateMachine _stateMachine;
  late EventBus _eventBus;
  late PerformanceMonitor _performanceMonitor;
  
  bool _isInitialized = false;
  double _deltaTime = GameConstants.DELTA_TIME;
  
  // Stream controller lar
  final _fpsStreamController = StreamController<double>.broadcast();
  final _frameTimeStreamController = StreamController<double>.broadcast();
  final _memoryStreamController = StreamController<double>.broadcast();
  
  Stream<double> get fpsStream => _fpsStreamController.stream;
  Stream<double> get frameTimeStream => _frameTimeStreamController.stream;
  Stream<double> get memoryStream => _memoryStreamController.stream;
  
  Future<void> initialize() async {
    if (_isInitialized) return;
    
    // SharedPreferences ni yuklash
    final prefs = await SharedPreferences.getInstance();
    
    // O'yin holati mashinasini yaratish
    _stateMachine = StateMachine();
    
    // Event bus ni yaratish
    _eventBus = EventBus();
    
    // Performance monitor ni yaratish
    _performanceMonitor = PerformanceMonitor();
    
    // O'yin tsiklini yaratish
    _gameLoop = GameLoop(
      onUpdate: _update,
      onRender: _render,
      targetFps: 120,
    );
    
    _isInitialized = true;
  }
  
  void start() {
    if (!_isInitialized) return;
    _gameLoop.start();
    _performanceMonitor.start();
  }
  
  void pause() {
    _gameLoop.pause();
    _performanceMonitor.pause();
  }
  
  void resume() {
    _gameLoop.resume();
    _performanceMonitor.resume();
  }
  
  void stop() {
    _gameLoop.stop();
    _performanceMonitor.stop();
  }
  
  void _update(double deltaTime) {
    _deltaTime = deltaTime;
    
    // O'yin holatini yangilash
    _stateMachine.update(deltaTime);
    
    // Event larni qayta ishlash
    _eventBus.processEvents();
    
    // Performance ma'lumotlarini yig'ish
    _performanceMonitor.recordFrame(deltaTime);
    
    // Stream larga ma'lumotlarni yuborish
    _fpsStreamController.add(_performanceMonitor.currentFps);
    _frameTimeStreamController.add(deltaTime);
    _memoryStreamController.add(_performanceMonitor.memoryUsage);
  }
  
  void _render() {
    // Render qilish (UI orqali)
    // Bu yerda o'yin ekranini chizish
  }
  
  void dispose() {
    _gameLoop.stop();
    _performanceMonitor.stop();
    _fpsStreamController.close();
    _frameTimeStreamController.close();
    _memoryStreamController.close();
  }
  
  // Getter'lar
  GameState get currentState => _stateMachine.currentState;
  EventBus get eventBus => _eventBus;
  PerformanceMonitor get performanceMonitor => _performanceMonitor;
  bool get isInitialized => _isInitialized;
}
