// obj_dropoff_zone - Create Event
target_color = irandom(2); // 0 = Orange, 1 = Teal, 2 = Purple
successful_drops = 0;
max_drops_before_relocate = irandom_range(2, 3);

// Wall index positions (0 = Left, 1 = Right, 2 = Bottom)
current_wall_index = 0;

// Position initially based on room size
var _pad = 64;
x = _pad;
y = room_height / 2;