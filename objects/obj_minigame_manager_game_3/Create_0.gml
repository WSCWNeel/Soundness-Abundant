// Add to obj_minigame_manager_game_3 Create Event
zone_stay_timer = 0;
zone_delay_required = 2.5 * 60; // 2.5 seconds (150 steps at 60 FPS)
current_active_zone = -1;       // Tracks which zone the player is standing in
deplete_timer = 5 * 60; // 5 seconds at 60 FPS
deplete_amount = 8;    // Percentage dropped every 5 seconds

state = "tutorial"; // "tutorial", "play", "win", "dead"

// Master Session Timer (2 Minutes / 120 Seconds)
total_game_timer = 120 * 60;
player_score = 0;

// Posture Bars (0 to 100)
elbow_posture = 100;
hip_posture   = 100;
knee_posture  = 100;

// Depletion Rate (points lost per frame)
depletion_rate = 0.12;
replenish_rate = 0.8;

// Bonus Target Mechanics
bonus_target = 0; // 0 = Elbow (Left), 1 = Hip (Bottom), 2 = Knee (Right)
bonus_hold_timer = 0;
bonus_required_time = 5 * 60; // 5 seconds at 60 FPS
bonus_target_names = ["ELBOWS (LEFT)", "HIPS (BOTTOM)", "KNEES (RIGHT)"];

// Pick first random bonus target
bonus_target = irandom(2);