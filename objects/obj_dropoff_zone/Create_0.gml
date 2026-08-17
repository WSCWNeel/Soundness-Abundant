// obj_dropoff_zone - Create Event
target_color = irandom(2); // 0 = Orange, 1 = Teal, 2 = Purple
successful_drops = 0;
max_drops_before_relocate = irandom_range(1, 2);

// Position coordinates for screen perimeter walls
wall_positions = [
    [64, 240],   // Left Wall
    [576, 240],  // Right Wall
    [320, 416]   // Bottom Wall
];

current_wall_index = 0;