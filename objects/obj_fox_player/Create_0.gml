// Create Event, everything in this panel will occur only once when the game is created.

// Map WASD to Arrow Keys (so there's less code overall compared to mapping wasd to arrow keys every time).

keyboard_set_map(ord("W"), vk_up);
keyboard_set_map(ord("S"), vk_down);
keyboard_set_map(ord("A"), vk_left);
keyboard_set_map(ord("D"), vk_right);

// The Movement Speed Code.

move_speed = 4; // Maximum distance that can be covered in a second by the player moving (4 pixels/second).
v_x = 0; // The baseline x axis velocity (since it covers x axis speed and direction).
v_y= 0; // The baseline y axis velocity (since it covers y axis speed and direction).