// obj_barrel - Step Event
if (is_held) {
    if (instance_exists(obj_fox_player)) {
        x = obj_fox_player.x;
        y = obj_fox_player.y - 16;
    } else {
        is_held = false;
    }
} else {
    // Pickup logic when player touches barrel
    if (instance_exists(obj_fox_player)) {
        if (place_meeting(x, y, obj_fox_player)) {
            // Only pick up if player isn't already holding a barrel
            var _already_holding = false;
            with (obj_barrel) {
                if (is_held) _already_holding = true;
            }
            if (!_already_holding) {
                is_held = true;
            }
        }
    }
}