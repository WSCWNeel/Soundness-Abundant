// obj_minigame_manager_game_3 - Step Event

// --- TUTORIAL STATE ---
if (state == "tutorial") {
    if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
        state = "play";
    }
    exit;
}

// --- RESTART / EXIT INPUTS (Active on Win or Game Over) ---
if (state == "win" || state == "dead") {
    if (instance_exists(obj_fox_player)) {
        obj_fox_player.x_speed = 0;
        obj_fox_player.y_speed = 0;
    }

    // Press 'R' to Restart
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
    exit;
}

// --- MAIN PLAY LOOP ---
if (state == "play") {
    // 1. Session Timer Count
    total_game_timer--;
    if (total_game_timer <= 0) {
        state = "win";
        if (instance_exists(obj_fox_player)) obj_fox_player.state = "win";
        exit;
    }

    // 2. 5-Second Interval Depletion
    deplete_timer--;
    if (deplete_timer <= 0) {
        deplete_timer = 5 * 60; // Reset 5-second timer
        
        // Deduct posture chunk every 5 seconds
        elbow_posture = max(0, elbow_posture - deplete_amount);
        hip_posture   = max(0, hip_posture - deplete_amount);
        knee_posture  = max(0, knee_posture - deplete_amount);
    }

    // 3. Game Over Check
    if (elbow_posture <= 0 || hip_posture <= 0 || knee_posture <= 0) {
        state = "dead";
        if (instance_exists(obj_fox_player)) obj_fox_player.state = "dead";
        exit;
    }

    // 4. Zone Position Detection & 2.5s Delay Handling
    if (instance_exists(obj_fox_player)) {
        var _px = obj_fox_player.x;
        var _py = obj_fox_player.y;
        var _margin = 64;
        
        var _detected_zone = -1; // -1 = None, 0 = Left (Elbow), 1 = Bottom (Hip), 2 = Right (Knee)

        // Identify active room zone
        if (_px <= _margin) {
            _detected_zone = 0; // Left Wall: Elbows
        } else if (_px >= room_width - _margin) {
            _detected_zone = 2; // Right Wall: Knees
        } else if (_py >= room_height - _margin) {
            _detected_zone = 1; // Bottom Wall: Hips
        }

        // Zone transition logic
        if (_detected_zone != -1) {
            if (_detected_zone == current_active_zone) {
                // Staying in current zone: accumulate entry delay timer
                zone_stay_timer++;
            } else {
                // Moved to a new zone: reset timer to require new 2.5s stay
                current_active_zone = _detected_zone;
                zone_stay_timer = 0;
            }
        } else {
            // Player left all zones: reset delay tracker
            current_active_zone = -1;
            zone_stay_timer = 0;
        }

        // Only refill posture AFTER staying continuously for 2.5 seconds (150 steps)
        if (zone_stay_timer >= zone_delay_required) {
            switch (current_active_zone) {
                case 0: // Left Wall: Elbows
                    elbow_posture = min(100, elbow_posture + replenish_rate);
                    player_score += 1;
                    break;
                    
                case 1: // Bottom Wall: Hips
                    hip_posture = min(100, hip_posture + replenish_rate);
                    player_score += 1;
                    break;
                    
                case 2: // Right Wall: Knees
                    knee_posture = min(100, knee_posture + replenish_rate);
                    player_score += 1;
                    break;
            }
        }

        // 5. Bonus Focus Target Tracking
        if (_detected_zone == bonus_target) {
            bonus_hold_timer++;
            if (bonus_hold_timer >= bonus_required_time) {
                player_score += 500;
                bonus_hold_timer = 0;
                
                // Pick next random target different from current
                var _next_target = (bonus_target + irandom_range(1, 2)) % 3;
                bonus_target = _next_target;
            }
        } else {
            bonus_hold_timer = max(0, bonus_hold_timer - 2);
        }
    }
}