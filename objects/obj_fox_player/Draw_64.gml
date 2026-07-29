// obj_hud -> Draw GUI Event

// 1. Debug check: Confirm the HUD is alive and rendering
show_debug_message("HUD is running!");

var _start_x = 20;
var _start_y = 20;
var _spacing = 60; // Increased spacing so scaled-up keys don't overlap!
var _count = 0;

// Set your custom scale here! (1.0 = normal, 2.0 = double size, 0.5 = half size)
var _scale_x = 4.0; 
var _scale_y = 4.0; 

// 2. Loop through collected keys
var _key_names = struct_get_names(global.keys);

for (var i = 0; i < array_length(_key_names); i++) {
    var _key_id = _key_names[i];
    
    // If we have collected this key
    if (global.keys[$ _key_id] == true) {
        show_debug_message("Drawing key: " + string(_key_id));
        
        // Extended sprite draw function:
        // draw_sprite_ext(sprite, subimg, x, y, xscale, yscale, rot, color, alpha)
        draw_sprite_ext(
            spr_key,                           // Sprite asset
            0,                                 // Image index / frame
            _start_x + (_count * _spacing),    // X position
            _start_y,                          // Y position
            _scale_x,                          // Horizontal scale factor
            _scale_y,                          // Vertical scale factor
            0,                                 // Rotation (0 degrees)
            c_white,                           // Color tint (c_white = normal)
            1.0                                // Alpha/Opacity (1.0 = fully opaque)
        );
        
        _count++;
    }
}