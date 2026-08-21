// obj_dropoff_zone - Draw Event
draw_self();

// Determine color blend, text label, and icon sprite safely
var _zone_color = c_white;
var _color_name = "";
var _target_sprite = -1;

switch (target_color) {
    case 0: 
        _zone_color = c_orange; 
        _color_name = "ORANGE BARREL"; 
        // Replace string with your exact orange barrel sprite name
        _target_sprite = asset_get_index("spr_barrel_orange"); 
        break;
    case 1: 
        _zone_color = c_aqua;   
        _color_name = "TEAL BARREL";   
        // Replace string with your exact teal barrel sprite name
        _target_sprite = asset_get_index("spr_barrel_teal"); 
        break;
    case 2: 
        _zone_color = c_purple; 
        _color_name = "PURPLE BARREL"; 
        // Replace string with your exact purple barrel sprite name
        _target_sprite = asset_get_index("spr_barrel_purple"); 
        break;
}

// 1. Draw highlighted floor pad box
draw_set_color(_zone_color);
draw_set_alpha(0.3);
draw_rectangle(x - 32, y - 32, x + 32, y + 32, false);
draw_set_alpha(1.0);
draw_rectangle(x - 32, y - 32, x + 32, y + 32, true);

// 2. Draw sample barrel sprite inside the drop zone if the asset exists
if (_target_sprite != -1) {
    draw_sprite_ext(_target_sprite, 0, x, y, 1, 1, 0, c_white, 0.8);
}

// 3. Draw text header above the dropoff zone
draw_set_halign(fa_center);
draw_set_valign(fa_bottom);
draw_set_color(_zone_color);
draw_text(x, y - 36, "DROP HERE:\n" + _color_name);

// Progress counter (e.g. "1/3 Drops")
draw_set_color(c_white);
draw_text(x, y + 48, string(successful_drops) + "/" + string(max_drops_before_relocate));

draw_set_halign(fa_left);
draw_set_valign(fa_top);