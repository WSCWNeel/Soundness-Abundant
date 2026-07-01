// Check if the player has a key.
if (global.player_keys > 0) {
// Use 1 key.
    global.player_keys -= 1;
    
// Spawn Location and Room Choosing Code.
    var _next_room = other.target_room;
    global.target_spawn_id = other.target_spawn_id; 

// Room tp code.
    room_goto(_next_room);
} else {
// Placeholder for a "The door is locked!" text pop-up or sound here later.
}