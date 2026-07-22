enum GameState {
  IDLE,
  LOADING,
  MENU,
  MATCH_PREVIEW,
  MATCH_RUNNING,
  MATCH_PAUSED,
  MATCH_ENDED,
  GOAL_REPLAY,
  VAR_CHECK,
  HALF_TIME,
  PENALTY_SHOOTOUT,
  SUBSTITUTION,
  INJURY,
  TRAINING,
  CAREER_MODE,
  ULTIMATE_TEAM,
  ONLINE_MATCHMAKING,
  ONLINE_MATCH,
  SETTINGS,
  STORE,
  REPLAY,
}

class StateMachine {
  GameState _currentState = GameState.IDLE;
  GameState _previousState = GameState.IDLE;
  
  final List<StateTransition> _transitionHistory = [];
  final Map<GameState, List<GameState>> _allowedTransitions = {
    GameState.IDLE: [GameState.LOADING],
    GameState.LOADING: [GameState.MENU],
    GameState.MENU: [
      GameState.MATCH_PREVIEW,
      GameState.CAREER_MODE,
      GameState.ULTIMATE_TEAM,
      GameState.TRAINING,
      GameState.SETTINGS,
      GameState.STORE,
    ],
    GameState.MATCH_PREVIEW: [GameState.MATCH_RUNNING, GameState.MENU],
    GameState.MATCH_RUNNING: [
      GameState.MATCH_PAUSED,
      GameState.GOAL_REPLAY,
      GameState.VAR_CHECK,
      GameState.SUBSTITUTION,
      GameState.INJURY,
      GameState.HALF_TIME,
      GameState.MATCH_ENDED,
    ],
    GameState.MATCH_PAUSED: [GameState.MATCH_RUNNING, GameState.MENU],
    GameState.MATCH_ENDED: [GameState.MENU, GameState.REPLAY],
    GameState.GOAL_REPLAY: [GameState.MATCH_RUNNING],
    GameState.VAR_CHECK: [GameState.MATCH_RUNNING, GameState.MATCH_ENDED],
    GameState.HALF_TIME: [GameState.MATCH_RUNNING],
    GameState.PENALTY_SHOOTOUT: [GameState.MATCH_ENDED],
    GameState.SUBSTITUTION: [GameState.MATCH_RUNNING],
    GameState.INJURY: [GameState.MATCH_RUNNING, GameState.SUBSTITUTION],
    GameState.TRAINING: [GameState.MENU],
    GameState.CAREER_MODE: [GameState.MENU, GameState.MATCH_PREVIEW],
    GameState.ULTIMATE_TEAM: [GameState.MENU, GameState.MATCH_PREVIEW],
    GameState.ONLINE_MATCHMAKING: [GameState.ONLINE_MATCH, GameState.MENU],
    GameState.ONLINE_MATCH: [GameState.MATCH_RUNNING, GameState.MATCH_ENDED],
    GameState.SETTINGS: [GameState.MENU],
    GameState.STORE: [GameState.MENU],
    GameState.REPLAY: [GameState.MENU, GameState.MATCH_ENDED],
  };
  
  bool transitionTo(GameState newState) {
    // O'tish ruxsat etilganligini tekshirish
    final allowed = _allowedTransitions[_currentState] ?? [];
    if (!allowed.contains(newState) && _currentState != newState) {
      print('⚠️ State transition not allowed: $_currentState -> $newState');
      return false;
    }
    
    _previousState = _currentState;
    _currentState = newState;
    
    _transitionHistory.add(StateTransition(
      from: _previousState,
      to: _currentState,
      timestamp: DateTime.now(),
    ));
    
    // Faqat oxirgi 1000 ta o'tishni saqlash
    if (_transitionHistory.length > 1000) {
      _transitionHistory.removeAt(0);
    }
    
    print('✅ State changed: $_previousState -> $_currentState');
    return true;
  }
  
  void update(double deltaTime) {
    // Holatga qarab yangilash
    switch (_currentState) {
      case GameState.MATCH_RUNNING:
        // O'yin mantig'i
        break;
      case GameState.GOAL_REPLAY:
        // Gol takrori
        break;
      default:
        break;
    }
  }
  
  GameState get currentState => _currentState;
  GameState get previousState => _previousState;
  List<StateTransition> get transitionHistory => _transitionHistory;
  
  bool get isMatchRunning => _currentState == GameState.MATCH_RUNNING;
  bool get isInMenu => _currentState == GameState.MENU;
  bool get isPaused => _currentState == GameState.MATCH_PAUSED;
  bool get isMatchEnded => _currentState == GameState.MATCH_ENDED;
}

class StateTransition {
  final GameState from;
  final GameState to;
  final DateTime timestamp;
  
  StateTransition({
    required this.from,
    required this.to,
    required this.timestamp,
  });
}
