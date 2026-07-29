// obj_trash -> Step Event

if (!is_grounded) {
    // Check if moving down will collide with a wall or another grounded trash
    if (place_meeting(x, y + fall_speed, obj_wall) || place_meeting(x, y + fall_speed, obj_trash)) {
        
        // Move pixel-by-pixel until touching the surface
        while (!place_meeting(x, y + 1, obj_wall) && !place_meeting(x, y + 1, obj_trash)) {
            y += 1;
        }
        
        is_grounded = true;
        fall_speed = 0;
    } else {
        y += fall_speed;
    }

    // Safety fallback: stop if it hits the bottom room boundary
    if (y >= ground_y) {
        y = ground_y;
        is_grounded = true;
    }
}