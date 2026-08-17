// obj_minigame_manager_game_2 - Create Event
state = "tutorial"; // "tutorial", "work", "rest", "win", "dead"

// Timers (60 FPS)
total_game_timer = 120 * 60; // 2 Minutes total
phase_timer = 50 * 60;       // Starts with 50s work phase
rest_grace_timer = 5 * 60;   // 5 second grace period in rest phase

// Progressive Spawning Settings
spawn_timer = 0;
base_spawn_interval = 120;   // 2 seconds baseline
min_spawn_interval = 40;    // Cap minimum spawn interval
current_spawn_interval = base_spawn_interval;

player_score = 0;

// Helper function to reset player position and state
if (instance_exists(obj_fox_player)) {
    obj_fox_player.state = "active";
}