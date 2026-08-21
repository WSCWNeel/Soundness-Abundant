// obj_barrel - Step Event
if (is_held) {
    if (instance_exists(obj_fox_player)) {
        // Count how many barrels were picked up BEFORE this one to calculate stack height
        var _stack_index = 0;
        var _self_id = id;
        with (obj_barrel) {
            if (is_held && id < _self_id) {
                _stack_index++;
            }
        }
        
        // Stack barrels vertically above player
        x = obj_fox_player.x;
        y = obj_fox_player.y - 16 - (_stack_index * 12);
    } else {
        is_held = false;
    }
} else {
    // Pickup logic when player touches barrel (allows multiple barrels)
    if (instance_exists(obj_fox_player)) {
        if (place_meeting(x, y, obj_fox_player)) {
            is_held = true;
        }
    }
}