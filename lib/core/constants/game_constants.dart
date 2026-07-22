class GameConstants {
  // FPS sozlamalari
  static const double DELTA_TIME = 1.0 / 120;
  
  // Fizika konstantalari
  static const double GRAVITY = 9.81;
  static const double BALL_MASS = 0.45;
  static const double BALL_FRICTION = 0.985;
  static const double MAX_KICK_POWER = 120.0;
  static const double MIN_KICK_POWER = 10.0;
  
  // Maydon o'lchamlari (metr)
  static const double PITCH_LENGTH = 105.0;
  static const double PITCH_WIDTH = 68.0;
  static const double GOAL_WIDTH = 7.32;
  static const double GOAL_HEIGHT = 2.44;
  static const double PENALTY_AREA_LENGTH = 16.5;
  static const double PENALTY_AREA_WIDTH = 40.3;
  static const double CENTER_CIRCLE_RADIUS = 9.15;
  static const double CORNER_ARC_RADIUS = 1.0;
  
  // O'yin vaqti
  static const int MATCH_DURATION = 90; // daqiqa
  static const int EXTRA_TIME_FIRST_HALF = 15;
  static const int EXTRA_TIME_SECOND_HALF = 15;
  static const int PENALTY_SHOOTOUT_MAX = 5;
  static const int HALF_TIME_DURATION = 15; // daqiqa
  
  // AI sozlamalari
  static const double AI_DIFFICULTY_BEGINNER = 0.1;
  static const double AI_DIFFICULTY_EASY = 0.3;
  static const double AI_DIFFICULTY_NORMAL = 0.5;
  static const double AI_DIFFICULTY_PROFESSIONAL = 0.65;
  static const double AI_DIFFICULTY_WORLD_CLASS = 0.8;
  static const double AI_DIFFICULTY_LEGENDARY = 0.9;
  static const double AI_DIFFICULTY_ULTIMATE = 0.95;
  static const double AI_DIFFICULTY_IMPOSSIBLE = 0.98;
  static const double AI_DIFFICULTY_GOD = 1.0;
  static const double AI_DIFFICULTY_PRO_MAX = 1.05;
  
  // O'yinchi rivojlanishi
  static const double DEVELOPMENT_SPEED = 0.01;
  static const double MAX_POTENTIAL = 125.0;
  static const double MIN_POTENTIAL = 40.0;
  
  // Jarohat ehtimoli
  static const double INJURY_PROBABILITY = 0.03; // 3%
  static const double SERIOUS_INJURY_PROBABILITY = 0.01; // 1%
}
