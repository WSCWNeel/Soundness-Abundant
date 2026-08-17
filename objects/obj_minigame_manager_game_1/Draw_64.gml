var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// --------------------------------------------------
// TUTORIAL OVERLAY
// --------------------------------------------------
if (state == "tutorial") {
    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);

    var _box_w = 480;
    var _box_h = 240;
    var _box_x = (_gui_w - _box_w) / 2;
    var _box_y = (_gui_h - _box_h) / 2;

    draw_set_color(c_navy);
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, false);
    draw_set_color(c_white);
    draw_rectangle(_box_x, _box_y, _box_x + _box_w, _box_y + _box_h, true);

    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    if (variable_global_exists("fnt_bold") && font_exists(fnt_bold)) {
        draw_set_font(fnt_bold);
    }

    draw_text(_gui_w / 2, _box_y + 20, "--- HOW TO PLAY ---");
    draw_text(_gui_w / 2, _box_y + 60, "1. Collect trash from the floor for points.");
    draw_text(_gui_w / 2, _box_y + 90, "2. Walk up to the Windows to lower Eye Strain.");
    draw_text(_gui_w / 2, _box_y + 120, "3. Survive 60s without reaching 100% Eye Strain!");

    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, _box_y + 180, "[ Press SPACE or ENTER to Start ]");

    draw_set_color(c_white);
    draw_set_halign(fa_left);
}

// --------------------------------------------------
// GAMEPLAY HUD
// --------------------------------------------------
if (state == "playing") {

    // FATIGUE BAR
    var _bar_x = 20;
    var _bar_y = 60;
    var _bar_w = 220;
    var _bar_h = 24;
    var _fill_w = (_bar_w * (fatigue / max_fatigue));

    draw_set_color(make_color_rgb(80, 80, 80)); // Bar background
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);

    // Dynamic bar fill color (Green -> Yellow -> Red)
    var _bar_color = make_color_rgb(0, 185, 52); // Green
    if (fatigue > 50) _bar_color = make_color_rgb(255, 217, 0); // Yellow
    if (fatigue > 80) _bar_color = make_color_rgb(185, 0, 0);   // Red

    draw_set_color(_bar_color);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_w, _bar_y + _bar_h, false);

    draw_set_color(make_color_rgb(71, 50, 75)); // Border Rectangle
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

    if (variable_global_exists("fnt_bold") && font_exists(fnt_bold)) {
        draw_set_font(fnt_bold);
    }
    
    // EYE STRAIN LABEL COLOR
    draw_set_color(make_color_rgb(71, 50, 75)); // Text
    draw_text(_bar_x, _bar_y - 25, "Eye Strain: " + string(ceil(fatigue)) + "%");

    // SCORE TEXT COLOR
    draw_set_color(make_color_rgb(71, 50, 75)); // Text
    draw_text(20, 95, "Score: " + string(player_score));

    // TIMER TEXT COLOR (Aligned to match Eye Strain height)
    var _seconds_left = max(0, ceil(timer / 60));
    draw_set_halign(fa_right);
    draw_set_color(make_color_rgb(71, 50, 75)); // Text
    draw_text(_gui_w - 20, _bar_y - 25, "Time: " + string(_seconds_left) + "s");
    draw_set_halign(fa_left);

    // --- WINDOW REST PROMPT ---
    var _at_window = false;
    if (instance_exists(obj_fox_player)) {
        with (obj_fox_player) {
            _at_window = place_meeting(x, y, obj_window_zone);
        }
    }

    if (_at_window && obj_fox_player.state == "active") {
        draw_set_halign(fa_center);
        draw_set_color(make_color_rgb(0, 255, 0)); // Lime text
        draw_text(_gui_w / 2, 40, "RESTING EYES AT WINDOW...");
        draw_set_color(make_color_rgb(255, 255, 255));
        draw_set_halign(fa_left);
    }
}

// --------------------------------------------------
// WIN OVERLAY
// --------------------------------------------------
if (instance_exists(obj_fox_player) && obj_fox_player.state == "win") {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, (_gui_h / 2) - 50, "YOU SURVIVED!");

    draw_set_color(c_white);
    draw_text(_gui_w / 2, (_gui_h / 2) - 10, "Final Score: " + string(player_score));

    draw_set_color(c_lime);
    draw_text(_gui_w / 2, (_gui_h / 2) + 40, "[ Press 'R' to Play Again ]");

    draw_set_color(c_orange);
    draw_text(_gui_w / 2, (_gui_h / 2) + 70, "[ Press 'ESC' to Exit to Home ]");

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}

// --------------------------------------------------
// GAME OVER OVERLAY
// --------------------------------------------------
if (instance_exists(obj_fox_player) && obj_fox_player.state == "dead") {
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);

    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_set_color(c_red);
    draw_text(_gui_w / 2, (_gui_h / 2) - 50, "GAME OVER - EYE STRAIN OVERLOAD!");

    draw_set_color(c_white);
    draw_text(_gui_w / 2, (_gui_h / 2) - 10, "Final Score: " + string(player_score));

    draw_set_color(c_lime);
    draw_text(_gui_w / 2, (_gui_h / 2) + 40, "[ Press 'R' to Retry ]");

    draw_set_color(c_orange);
    draw_text(_gui_w / 2, (_gui_h / 2) + 70, "[ Press 'ESC' to Exit to Home ]");

    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}