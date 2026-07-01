// Collision Event (whatever's in here will trigger when it collides with the player)

// Variable Based System to specificy room and spawn location (set up in variable definitions).
var _next_room = other.target_room;
global.target_spawn_id = other.target_spawn_id; 

// Room Switching Code.
room_goto(_next_room);