y += fall_speed;

// Bottom Target Area Limit (1280x720 room height)
// 720 - 16px offset = 704px max floor limit
var _floor_y = 704;

// Destroy trash if it reaches the floor zone or hits a wall
if (y >= _floor_y || place_meeting(x, y + fall_speed, obj_wall)) {
    instance_destroy();
}