// obj_minigame_manager -> Step Event

if (!instance_exists(obj_fox_player)) exit;

var _player = obj_fox_player;

// --------------------------------------------------
// STATE: TUTORIAL (Wait for Start / Skip)
// --------------------------------------------------
if (state == "tutorial") {
    // Keep player frozen while tutorial overlay is active
    _player.x_speed = 0;
    _player.y_speed = 0;

    // Press SPACE or ENTER to start the game
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        state = "playing";
    }
}

// --------------------------------------------------
// STATE: PLAYING (Active Minigame Loop)
// --------------------------------------------------
if (state == "playing") {

    if (_player.state == "active") {

        // 1. REST AREA CHECK (Option 1 fix using player's collision mask)
        var _at_window = false;
        with (_player) {
            _at_window = place_meeting(x, y, obj_window_zone);
        }

        if (_at_window) {
            // Reduce eye strain while resting at the window
            fatigue = max(0, fatigue - rest_rate);
        } else {
            // Strain increases gradually while working
            fatigue += fatigue_rate;
        }

        // 2. 60-Second Survival Countdown
        timer--;

        // WIN CONDITION: Survived 60 Seconds
        if (timer <= 0) {
            _player.state = "win";
            global.final_score = player_score; 
            alarm[0] = 120; // 2 seconds delay to display Win screen before changing rooms
        }

        // FAIL CONDITION: Eye Strain Reaches 100%
        if (fatigue >= max_fatigue) {
            fatigue = max_fatigue;
            _player.state = "dead";
            alarm[1] = 120; // 2 seconds delay for Game Over
        }

        // 3. FALLING TRASH SPAWNER (Bug #1 Fix: Wall clearance check)
        spawn_timer++;
        if (spawn_timer >= spawn_interval) {
            spawn_timer = 0;

            var _margin = 32; 
            var _min_x = _margin;
            var _max_x = room_width - _margin;
            var _spawn_y = 48; // Top spawn height

            var _found_spot = false;
            var _spawn_x = 0;
            var _attempts = 0;

            while (!_found_spot && _attempts < 15) {
                _spawn_x = irandom_range(_min_x, _max_x);
                
                // Ensure spawn X coordinate clear of walls on left, center, and right bounds
                if (!position_meeting(_spawn_x, _spawn_y, obj_wall) && 
                    !position_meeting(_spawn_x - 16, _spawn_y, obj_wall) && 
                    !position_meeting(_spawn_x + 16, _spawn_y, obj_wall)) {
                    _found_spot = true;
                }
                _attempts++;
            }

            if (_found_spot) {
                instance_create_layer(_spawn_x, _spawn_y, "Instances", obj_trash);
            }
        }
    }
}