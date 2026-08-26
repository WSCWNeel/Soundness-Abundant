// obj_barrel_dump_zone - Step Event

if (instance_exists(obj_fox_player)) {
    // Check if player is touching the dump zone or very close to it
    var _touching = place_meeting(x, y, obj_fox_player);
    var _near = (point_distance(x, y, obj_fox_player.x, obj_fox_player.y) < 48);
    
    if (_touching || _near) {
        // Destroy ALL currently held barrels carried by the player
        with (obj_barrel) {
            if (is_held) {
                // Destroy the barrel without adding any score
                instance_destroy();
            }
        }
    }
}