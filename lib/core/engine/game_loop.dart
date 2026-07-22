import 'dart:async';
import 'dart:ui' as ui;

class GameLoop {
  final void Function(double delta) onUpdate;
  final void Function() onRender;
  final int targetFps;
  
  Timer? _timer;
  bool _isRunning = false;
  bool _isPaused = false;
  double _deltaTime = 0.0;
  int _frameCount = 0;
  double _fps = 0.0;
  DateTime? _lastTime;
  
  GameLoop({
    required this.onUpdate,
    required this.onRender,
    this.targetFps = 60,
  });
  
  void start() {
    if (_isRunning) return;
    
    _isRunning = true;
    _isPaused = false;
    _frameCount = 0;
    _lastTime = DateTime.now();
    
    final tickDuration = Duration(microseconds: (1000000 / targetFps).round());
    
    _timer = Timer.periodic(tickDuration, (timer) {
      if (_isPaused) return;
      
      final now = DateTime.now();
      final delta = now.difference(_lastTime!).inMicroseconds / 1000000.0;
      _lastTime = now;
      
      // Delta vaqtni cheklash (agar o'yin to'xtab qolsa)
      _deltaTime = delta.clamp(0.001, 0.05);
      
      // Yangilash
      onUpdate(_deltaTime);
      
      // Render qilish
      onRender();
      
      // FPS hisoblash
      _frameCount++;
      if (_frameCount >= targetFps) {
        _fps = _frameCount / 1.0;
        _frameCount = 0;
      }
    });
  }
  
  void pause() {
    _isPaused = true;
  }
  
  void resume() {
    _isPaused = false;
    _lastTime = DateTime.now();
  }
  
  void stop() {
    _isRunning = false;
    _timer?.cancel();
    _timer = null;
  }
  
  double get deltaTime => _deltaTime;
  double get fps => _fps;
  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
}
