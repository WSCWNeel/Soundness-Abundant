if (!instance_exists(obj_fox_player)) exit;

var _player = obj_fox_player;

// --------------------------------------------------
// STATE: TUTORIAL
// --------------------------------------------------
if (state == "tutorial") {
    _player.x_speed = 0;
    _player.y_speed = 0;

    // Press SPACE or ENTER to start
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        state = "playing";
        _player.state = "active";
    }
}

// --------------------------------------------------
// STATE: PLAYING
// --------------------------------------------------
if (state == "playing") {

    if (_player.state == "active") {

        // 1. WINDOW REST ZONE CHECK
        var _at_window = false;
        with (_player) {
            _at_window = place_meeting(x, y, obj_window_zone);
        }

        if (_at_window) {
            fatigue = max(0, fatigue - rest_rate);
        } else {
            fatigue += fatigue_rate;
        }

        // 2. SURVIVAL TIMER
        timer--;

        // WIN CONDITION
        if (timer <= 0) {
            _player.state = "win";
            global.final_score = player_score; 
        }
		
		show_debug_message("Fatigue: " + string(fatigue) + " | Max Fatigue: " + string(max_fatigue))

        // FAIL CONDITION
        if (fatigue >= max_fatigue) {
            fatigue = max_fatigue;
            _player.state = "dead";
            global.final_score = player_score;
        }

        // 3. TRASH SPAWNER WITH WALL CLEARANCE
        spawn_timer++;
        if (spawn_timer >= spawn_interval) {
            spawn_timer = 0;

            var _margin = 32; 
            var _min_x = _margin;
            var _max_x = room_width - _margin;
            var _spawn_y = 48;

            var _found_spot = false;
            var _spawn_x = 0;
            var _attempts = 0;

            while (!_found_spot && _attempts < 15) {
                _spawn_x = irandom_range(_min_x, _max_x);
                
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
    
// --------------------------------------------------
// RESTART / EXIT INPUTS (Active on Win or Game Over)
// --------------------------------------------------
if (_player.state == "win" || _player.state == "dead") {
    
    // Freeze player movement on game end
    _player.x_speed = 0;
    _player.y_speed = 0;

    // Press 'R' to Restart the Minigame
    if (keyboard_check_pressed(ord("R"))) {
        with (_player) {
            state = "active";
            x_speed = 0;
            y_speed = 0;
            image_speed = 1;
        }
        room_restart();
    }

    // Press 'ESC' to Exit to Home Screen
    if (keyboard_check_pressed(vk_escape)) {
        global.target_x = 316; 
        global.target_y = 420; 
        
        with (_player) {
            state = "active";
            x_speed = 0;
            y_speed = 0;
            image_speed = 1;
        }

        if (room_exists(home_screen)) {
            room_goto(home_screen);
        }
	 }
	}
}