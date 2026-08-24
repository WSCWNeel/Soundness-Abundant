// obj_minigame_manager_game_2 - Step Event

// --- TUTORIAL STATE ---
if (state == "tutorial") {
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        state = "work";
        phase_timer = 50 * 60;
    }
    exit;
}

// --- MASTER TIMER & PROGRESSIVE DIFFICULTY ---
if (state == "work" || state == "rest") {
    total_game_timer--;
    if (total_game_timer <= 0) {
        state = "win";
        if (instance_exists(obj_fox_player)) obj_fox_player.state = "win";
        exit;
    }

    // Accelerate spawn rate as total game time progresses
    var _progress = 1 - (total_game_timer / (120 * 60));
    current_spawn_interval = max(min_spawn_interval, base_spawn_interval - (_progress * 80));
}

// --- WORK PHASE (50 Seconds) ---
if (state == "work") {
    phase_timer--;
    
    // Barrel Spawning (Scales cleanly across active room width and height)
    spawn_timer++;
    if (spawn_timer >= current_spawn_interval) {
        spawn_timer = 0;
        var _pad = 64;
        var _sx = random_range(_pad, room_width - _pad);
        var _sy = random_range(_pad, room_height - _pad);
        instance_create_layer(_sx, _sy, "Instances", obj_barrel);
    }
    
    // Transition to Rest Phase
    if (phase_timer <= 0) {
        state = "rest";
        phase_timer = 10 * 60;
        rest_grace_timer = 5 * 60;
    }
}

// --- REST PHASE (10 Seconds) ---
if (state == "rest") {
    phase_timer--;
    
    if (rest_grace_timer > 0) {
        rest_grace_timer--;
    } else {
        // After 5s grace window, check if player attempts any movement
        var _moving = false;
        if (keyboard_check(ord("W")) || keyboard_check(ord("A")) || 
            keyboard_check(ord("S")) || keyboard_check(ord("D")) ||
            keyboard_check(vk_up) || keyboard_check(vk_left) ||
            keyboard_check(vk_down) || keyboard_check(vk_right)) {
            _moving = true;
        }
        
        if (instance_exists(obj_fox_player)) {
            if (abs(obj_fox_player.x_speed) > 0.1 || abs(obj_fox_player.y_speed) > 0.1) {
                _moving = true;
            }
        }
        
        // Trigger burnout failure if player moves after grace window
        if (_moving) {
            state = "dead";
            if (instance_exists(obj_fox_player)) obj_fox_player.state = "dead";
            exit;
        }
    }
    
    // Transition back to Work Phase
    if (phase_timer <= 0) {
        state = "work";
        phase_timer = 50 * 60;
    }
}

// --------------------------------------------------
// RESTART / EXIT INPUTS (Active on Win or Game Over)
// --------------------------------------------------
if (state == "win" || state == "dead") {

    // Freeze player movement on game end
    if (instance_exists(obj_fox_player)) {
        obj_fox_player.x_speed = 0;
        obj_fox_player.y_speed = 0;
    }

    // Press 'R' to Restart the Minigame
    if (keyboard_check_pressed(ord("R"))) {
        if (instance_exists(obj_fox_player)) {
            with (obj_fox_player) {
                state = "active";
                x_speed = 0;
                y_speed = 0;
                image_speed = 1;
            }
        }
        room_restart();
    }

    // Press 'ESC' to Exit to Home Screen
    if (keyboard_check_pressed(vk_escape)) {
        global.target_x = 316;
        global.target_y = 420;

        if (instance_exists(obj_fox_player)) {
            with (obj_fox_player) {
                state = "active";
                x_speed = 0;
                y_speed = 0;
                image_speed = 1;
            }
        }

        if (room_exists(home_screen)) {
            room_goto(home_screen);
        }
    }
}