// obj_minigame_manager_game_2 - Draw GUI Event
var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// --- TUTORIAL OVERLAY ---
if (state == "tutorial") {
    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);

    var _box_w = 530;
    var _box_h = 260;
    var _box_x = (_gui_w - _box_w) / 2;
    var _box_y = (_gui_h - _box_h) / 2;

    draw_set_color(c_navy);
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);
    draw_set_color(c_white);
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    draw_text(_gui_w / 2, _box_y + 15, "--- 50:10 RULE WORKPLACE HYGIENE ---");
    draw_text(_gui_w / 2, _box_y + 50, "1. Pick up barrels and drop them at their drop zones.");
    draw_text(_gui_w / 2, _box_y + 80, "2. WORK PHASE (50s): Drop barrels and earn points.");
    draw_text(_gui_w / 2, _box_y + 110, "3. REST PHASE (10s): Rest, you get 5s before you die!");
    draw_text(_gui_w / 2, _box_y + 140, "4. Remember, 9's the limit (You can't pick up anymore).");
	draw_text(_gui_w / 2, _box_y + 170, "5. Survive the full 2-minute work shift.");

    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, _box_y + 200, "[ Press SPACE or ENTER to Start ]");

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    exit;
}

// --- GAMEPLAY HUD ---
if (state == "work" || state == "rest") {
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    
    // Top HUD Info
    var _sec_left = max(0, ceil(total_game_timer / 60));
    draw_text(20, 20, "Time: " + string(_sec_left) + "s");
    draw_text(20, 45, "Score: " + string(player_score));

    // Phase Banner
    draw_set_halign(fa_center);
    if (state == "work") {
        var _p_sec = ceil(phase_timer / 60);
        draw_set_color(c_lime);
        draw_text(_gui_w / 2, 20, "WORK PHASE: " + string(_p_sec) + "s");
    } else if (state == "rest") {
        var _p_sec = ceil(phase_timer / 60);
        draw_set_color(c_orange);
        draw_text(_gui_w / 2, 20, "REST PHASE: " + string(_p_sec) + "s");
        
        if (rest_grace_timer > 0) {
            var _g_sec = ceil(rest_grace_timer / 60);
            draw_set_color(c_yellow);
            draw_text(_gui_w / 2, 50, "STOP MOVING IN: " + string(_g_sec) + "s");
        } else {
            draw_set_color(c_red);
            draw_text(_gui_w / 2, 50, "HOLD STILL! DO NOT MOVE!");
        }
    }
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}

// --- WIN OVERLAY ---
if (state == "win") {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, (_gui_h / 2) - 50, "SHIFT COMPLETED!");
    draw_set_color(c_white);
    draw_text(_gui_w / 2, (_gui_h / 2) - 10, "Final Score: " + string(player_score));

    draw_set_color(c_lime);
    draw_text(_gui_w / 2, (_gui_h / 2) + 40, "[ Press 'R' to Play Again ]");
    draw_set_color(c_orange);
    draw_text(_gui_w / 2, (_gui_h / 2) + 70, "[ Press 'ESC' to Exit to Home ]");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// --- GAME OVER OVERLAY ---
if (state == "dead") {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);

    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_red);
    draw_text(_gui_w / 2, (_gui_h / 2) - 50, "BURNOUT! FAILED TO REST!");
    draw_set_color(c_white);
    draw_text(_gui_w / 2, (_gui_h / 2) - 10, "Final Score: " + string(player_score));

    draw_set_color(c_lime);
    draw_text(_gui_w / 2, (_gui_h / 2) + 40, "[ Press 'R' to Retry ]");
    draw_set_color(c_orange);
    draw_text(_gui_w / 2, (_gui_h / 2) + 70, "[ Press 'ESC' to Exit to Home ]");

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
}

// --- REST PHASE (10 Seconds) ---
if (state == "rest") {
    phase_timer--;
    
    if (rest_grace_timer > 0) {
        rest_grace_timer--;
        danger_movement_timer = 0; // Reset danger level while safe
    } else {
        // After 5s grace window, check for player movement
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
        
        if (_moving) {
            // Player is moving during penalty window: increase danger state
            danger_movement_timer = min(max_danger_time, danger_movement_timer + 1);
            
            // Trigger death when danger maxes out (after ~5s of total movement)
            if (danger_movement_timer >= max_danger_time) {
                state = "dead";
                if (instance_exists(obj_fox_player)) obj_fox_player.state = "dead";
                exit;
            }
        } else {
            // Gradually recover danger level if player stops moving
            danger_movement_timer = max(0, danger_movement_timer - 2);
        }
    }
    
    // Apply speed debuff to player based on danger intensity ratio (0.0 to 1.0)
    var _danger_ratio = danger_movement_timer / max_danger_time;
    if (instance_exists(obj_fox_player)) {
        // Debuff speed down to 25% of base speed as danger reaches 100%
        obj_fox_player.move_speed_modifier = lerp(1.0, 0.25, _danger_ratio);
    }
    
    // Transition back to Work Phase
    if (phase_timer <= 0) {
        state = "work";
        phase_timer = 50 * 60;
        danger_movement_timer = 0;
        if (instance_exists(obj_fox_player)) obj_fox_player.move_speed_modifier = 1.0;
    }
} else {
    // Reset speed modifier during work/other phases
    danger_movement_timer = 0;
    if (instance_exists(obj_fox_player)) obj_fox_player.move_speed_modifier = 1.0;
}

// obj_minigame_manager_game_2 - Draw GUI Event

// Draw red vignette tint whenever danger active
if (danger_movement_timer > 0) {
    var _danger_ratio = danger_movement_timer / max_danger_time;
    
    // Calculate screen width and height safely
    var _gui_w = display_get_gui_width();
    var _gui_h = display_get_gui_height();
    
    // Draw red semi-transparent overlay rectangle across camera screen
    draw_set_color(c_red);
    draw_set_alpha(_danger_ratio * 0.5); // Max 50% red tint strength
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    
    // Reset draw alpha and color so UI elements render normally
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}