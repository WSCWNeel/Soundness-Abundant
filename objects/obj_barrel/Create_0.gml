// obj_barrel - Create Event
is_held = false;
color_type = irandom(2); // 0 = Orange, 1 = Teal, 2 = Purple

// Swap sprite index directly based on color_type
switch (color_type) {
    case 0: 
        if (sprite_exists(spr_orange_barrel)) sprite_index = spr_orange_barrel; 
        break;
    case 1: 
        if (sprite_exists(spr_teal_barrel)) sprite_index = spr_teal_barrel; 
        break;
    case 2: 
        if (sprite_exists(spr_purple_barrel)) sprite_index = spr_purple_barrel; 
        break;
}