// obj_minigame_manager_game_3 - Draw Event

if (state == "play") {
    var _m = 48; // Zone boundary depth
    
    // Left Zone (Elbows)
    draw_set_color(c_lime); draw_set_alpha(0.15);
    draw_rectangle(0, 0, _m, room_height, false);
    
    // Right Zone (Knees)
    draw_set_color(c_orange); draw_set_alpha(0.15);
    draw_rectangle(room_width - _m, 0, room_width, room_height, false);
    
    // Bottom Zone (Hips) - Changed c_cyan to c_aqua
    draw_set_color(c_aqua); draw_set_alpha(0.15);
    draw_rectangle(0, room_height - _m, room_width, room_height, false);
    
    // Reset draw properties
    draw_set_alpha(1.0);
    draw_set_color(c_white);
}