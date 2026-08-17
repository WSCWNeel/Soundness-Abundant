// obj_barrel - Create Event
color_type = irandom(2); // 0 = Orange, 1 = Teal, 2 = Purple
is_held = false;

// Set visual sprite sub-image or color blend based on color_type
switch (color_type) {
    case 0: image_blend = c_orange; break;
    case 1: image_blend = c_aqua; break;
    case 2: image_blend = c_purple; break;
}