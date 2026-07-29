// obj_game_over_manager -> Draw GUI Event

var _gui_w = display_get_gui_width();
var _gui_h = display_get_gui_height();

// 1. Title Text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnt_bold);

// Main Game Over Header
draw_set_color(c_red);
draw_text(_gui_w / 2, _gui_h * 0.3, "EYE FATIGUE MAXED OUT!");

draw_set_color(c_white);
draw_text(_gui_w / 2, _gui_h * 0.38, "Remember to follow the 20-20-20 rule!");

// 2. Menu Options
var _start_y = _gui_h * 0.55;
var _spacing = 50;

// Option 0: Retry Minigame
if (menu_option == 0) {
    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, _start_y, "> Retry Minigame <");
} else {
    draw_set_color(c_gray);
    draw_text(_gui_w / 2, _start_y, "  Retry Minigame  ");
}

// Option 1: Return to Hub
if (menu_option == 1) {
    draw_set_color(c_yellow);
    draw_text(_gui_w / 2, _start_y + _spacing, "> Return to Hub <");
} else {
    draw_set_color(c_gray);
    draw_text(_gui_w / 2, _start_y + _spacing, "  Return to Hub  ");
}

// 3. Footer Prompt
draw_set_color(c_white);
draw_text(_gui_w / 2, _gui_h * 0.85, "Use W/S or UP/DOWN to select | Press SPACE/ENTER to confirm");

// Reset alignment settings for other draw scripts
draw_set_halign(fa_left);
draw_set_valign(fa_top);