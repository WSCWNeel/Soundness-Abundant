// Game States: "tutorial", "playing"
state = "tutorial";

// Core Variables
timer = 3600; // 60 seconds at 60 FPS
player_score = 0;

// Fatigue / Eye Strain (0 to 100)
fatigue = 0;
max_fatigue = 100.0;
fatigue_rate = 0.08; // Rate fatigue increases per frame
rest_rate = 0.35;    // Rate fatigue decreases when resting at window

// Trash Spawner Parameters
spawn_timer = 0;
spawn_interval = 45; // Spawns trash every 0.75 seconds