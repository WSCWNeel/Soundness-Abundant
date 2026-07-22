// obj_door -> Collision with obj_player
var _can_enter = true;

// If the door is locked, check if the player has the right key
if (is_locked == true) {
    if (variable_struct_exists(global.keys, key_required) && global.keys[$ key_required] == true) {
        _can_enter = true; 
        is_locked = false; // Permanently unlocks this door
    } else {
        _can_enter = false; // Player doesn't have the key yet
    }
}

// obj_door -> Collision with obj_fox_player

show_debug_message("--- DOOR TRIGGERED ---");
show_debug_message("Target Room: " + string(target_room));
show_debug_message("Target X: " + string(target_x));
show_debug_message("Target Y: " + string(target_y));

// (Your existing door logic below)
if (_can_enter == true && target_room != -1) {
    global.target_x = target_x;
    global.target_y = target_y;
    room_goto(target_room);
}