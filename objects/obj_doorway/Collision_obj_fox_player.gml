// Collision Event with the player (triggers whenever player collides with this object)

// Makes Player go to the specified room
room_goto(room_game_1_building);

//Teleports the player to a certain location when spawning in the new room.
if instance_exists(obj_fox_player)
{
	obj_fox_player.x = tp_x;
	obj_fox_player.y = tp_y;
}