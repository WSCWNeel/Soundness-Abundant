// obj_minigame_manager -> Draw GUI Event

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// --------------------------------------------------
// DRAW TUTORIAL OVERLAY
// --------------------------------------------------
if (state == "tutorial") {
    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(0, 0, _gui_w, _gui_h, false);
    draw_set_alpha(1.0);

    var _box_w = 460;
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
    draw_text(_gui_w / 2, _box_y + 60, "1. Pick up trash on the ground for points.");
    draw_text(_gui_w / 2, _box_y + 90, "2. Walk to the top Windows to rest eyes.");
    draw_text(_gui_w / 2, _box_y + 120, "3. Survive 60 seconds without maxing Eye Strain!");

    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, _box_y + 180, "[ Press SPACE or ENTER to Start ]");

    draw_set_color(c_white);
    draw_set_halign(fa_left);
}

// --------------------------------------------------
// DRAW GAMEPLAY HUD
// --------------------------------------------------
if (state == "playing") {

    // --- FATIGUE BAR ---
    var _bar_x = 20;
    var _bar_y = 60;
    var _bar_w = 220;
    var _bar_h = 24;
    var _fill_w = (_bar_w * (fatigue / max_fatigue));

    draw_set_color(c_dkgray);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, false);

    var _bar_color = c_green;
    if (fatigue > 50) _bar_color = c_yellow;
    if (fatigue > 80) _bar_color = c_red;

    draw_set_color(_bar_color);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _fill_w, _bar_y + _bar_h, false);

    draw_set_color(c_white);
    draw_rectangle(_bar_x, _bar_y, _bar_x + _bar_w, _bar_y + _bar_h, true);

    if (variable_global_exists("fnt_bold") && font_exists(fnt_bold)) {
        draw_set_font(fnt_bold);
    }
    draw_text(_bar_x, _bar_y - 25, "Eye Strain: " + string(ceil(fatigue)) + "%");

    // --- SCORE & TIMER ---
    draw_text(20, 95, "Score: " + string(player_score));

    var _seconds_left = max(0, ceil(timer / 60));
    draw_set_halign(fa_right);
    draw_text(_gui_w - 20, 20, "Time: " + string(_seconds_left) + "s");
    draw_set_halign(fa_left);

    // Window Rest Prompt
    if (instance_exists(obj_fox_player) && place_meeting(obj_fox_player.x, obj_fox_player.y, obj_window_zone)) {
        draw_set_halign(fa_center);
        draw_set_color(c_lime);
        draw_text(_gui_w / 2, 40, "RESTING EYES AT WINDOW...");
        draw_set_color(c_white);
        draw_set_halign(fa_left);
    }
}