// obj_door -> Collision Event with obj_fox_player

var _can_enter = true;

// 1. If the door is locked, check if the player has collected the required key
if (is_locked == true) {
    if (variable_struct_exists(global.keys, key_required) && global.keys[$ key_required] == true) {
        _can_enter = true; 
        is_locked = false; // Unlocks the door
        
        // CONSUME THE KEY: Remove it from global inventory so it disappears from the HUD!
        struct_remove(global.keys, key_required);
        
    } else {
        _can_enter = false; // Player doesn't have the key yet
    }
}

// 2. Teleport if entry is allowed and target_room is set
if (_can_enter == true && target_room != -1) {
    global.target_x = target_x;
    global.target_y = target_y;
    room_goto(target_room);
}