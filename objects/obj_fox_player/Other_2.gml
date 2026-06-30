global.target_spawn_id = 0;

// Loop through every spawn point present in the newly loaded room
with (obj_spawn_point) {
    // If this spawn point's ID matches the one requested by the door...
    if (spawn_id == global.target_spawn_id) {
        other.x = x; // Move the player to this spawn point's X
        other.y = y; // Move the player to this spawn point's Y
        break;       // Stop searching through other spawn points
    }
}