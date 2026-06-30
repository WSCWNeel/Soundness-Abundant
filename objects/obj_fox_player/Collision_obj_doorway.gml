// 1. Save the room asset and the specific spawn ID we want to find
var _next_room = other.target_room;
global.target_spawn_id = other.target_spawn_id; 

// 2. Switch rooms instantly
room_goto(_next_room);