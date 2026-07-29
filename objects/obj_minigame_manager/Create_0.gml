// obj_minigame_manager -> Create Event

// Game State ("tutorial" -> "playing")
state = "tutorial";

// Eye Fatigue Settings
fatigue = 0;              
max_fatigue = 100;        
fatigue_rate = 0.05;      // Passive strain increase per frame
rest_rate = 0.5;          // Strain reduction when looking out window

// Score & 1-Minute Timer
player_score = 0;
survival_time = 60 * 60;  // 60 seconds at 60 FPS
timer = survival_time;

// Item Spawner
spawn_timer = 0;
spawn_interval = 90;