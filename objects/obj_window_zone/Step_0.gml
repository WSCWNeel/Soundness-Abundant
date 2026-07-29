// obj_minigame_manager -> Step Event

if (!instance_exists(obj_fox_player)) exit;

var _player = obj_fox_player;

// --------------------------------------------------
// STATE: TUTORIAL (Wait for Start / Skip)
// --------------------------------------------------
if (state == "tutorial") {
    _player.x_speed = 0;
    _player.y_speed = 0;

    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        state = "playing";
    }
}

// --------------------------------------------------
// STATE: PLAYING (Active Minigame Loop)
// --------------------------------------------------
if (state == "playing") {

    if (_player.state == "active") {

        // 1. Check if player is at the Window Rest Zone
        var _at_window = place_meeting(_player.x, _player.y, obj_window_zone);

        if (_at_window) {
            // Resting eyes reduces fatigue
            fatigue = max(0, fatigue - rest_rate);
        } else {
            // Strain builds up continuously while working
            fatigue += fatigue_rate;
        }

        // 2. 60-Second Countdown
        timer--;

        // WIN CONDITION: Survived 60 Seconds!
        if (timer <= 0) {
            _player.state = "win";
            // Save final score to global variable for the Win/Leaderboard screen
            global.final_score = player_score; 
            alarm[0] = 90; // Wait 1.5s before transitioning
        }

        // FAIL CONDITION: 100% Eye Strain
        if (fatigue >= max_fatigue) {
            fatigue = max_fatigue;
            _player.state = "dead";
            alarm[1] = 120; // Wait 2s before Game Over transition
        }

        // 3. Falling Trash Spawner
        spawn_timer++;
        if (spawn_timer >= spawn_interval) {
            spawn_timer = 0;
            var _spawn_x = irandom_range(32, room_width - 32);
            instance_create_layer(_spawn_x, -16, "Instances", obj_trash);
        }
    }
}