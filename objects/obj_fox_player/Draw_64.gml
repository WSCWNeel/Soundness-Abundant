// Force the GUI layer to match your game's window size
display_set_gui_size(window_get_width(), window_get_height());

if (global.player_keys > 0) {
    // 1. Get the dynamic right edge of your screen
    var _gui_width = display_get_gui_width();
    
    // 2. Set right-alignment so text flows leftward from its X position
    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    
    var _scale = 4; 
    
    // 3. Draw the text first, slightly offset to the left of the sprite
    var _sprite_width = sprite_get_width(spr_key) * _scale;
    draw_text(_gui_width - 32 - _sprite_width - 10, 32, "x" + string(global.player_keys));
    
    // 4. Draw the sprite tucked nicely into the right corner (32 pixels out)
    draw_sprite_ext(spr_key, 0, _gui_width - 32 - _sprite_width, 32, _scale, _scale, 0, c_white, 1);
}