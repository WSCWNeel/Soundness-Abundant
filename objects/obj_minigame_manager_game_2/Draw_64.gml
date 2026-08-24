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