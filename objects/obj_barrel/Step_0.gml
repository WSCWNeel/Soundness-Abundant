// obj_barrel - Step Event

// --- SPAWN DROP ANIMATION ---
if (is_spawning) {
    spawn_offset_y = min(0, spawn_offset_y + fall_speed);
    
    // Once barrel reaches the floor, finish spawn animation
    if (spawn_offset_y >= 0) {
        is_spawning = false;
    }
    exit; // Block pickup while falling
}

// --- NORMAL HELD / PICKUP LOGIC ---
if (is_held) {
    if (instance_exists(obj_fox_player)) {
        var _stack_index = 0;
        var _self_id = id;
        with (obj_barrel) {
            if (is_held && id < _self_id) {
                _stack_index++;
            }
        }
        x = obj_fox_player.x;
        y = obj_fox_player.y - 16 - (_stack_index * 12);
    } else {
        is_held = false;
    }
} else {
    // Pickup logic (capped at 9)
    if (instance_exists(obj_fox_player)) {
        if (place_meeting(x, y, obj_fox_player)) {
            var _held_count = 0;
            with (obj_barrel) {
                if (is_held) _held_count++;
            }
            if (_held_count < 9) {
                is_held = true;
            }
        }
    }
}