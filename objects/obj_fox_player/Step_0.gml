// obj_fox_player -> Step Event

// --------------------------------------------------
// STATE: ACTIVE (Normal Gameplay)
// --------------------------------------------------
if (state == "active") {
    // Ensure normal animation speed in case it was previously frozen
    image_speed = 1;

    // 1. Gather Movement Inputs
    var right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    var down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
    var up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));

    x_speed = (right - left) * move_speed;
    y_speed = (down - up) * move_speed;

    // 2. Horizontal Collision (obj_wall)
    if (place_meeting(x + x_speed, y, obj_wall)) {
        while (!place_meeting(x + sign(x_speed), y, obj_wall)) {
            x += sign(x_speed);
        }
        x_speed = 0;
    }
    x += x_speed;

    // 3. Vertical Collision (obj_wall)
    if (place_meeting(x, y + y_speed, obj_wall)) {
        while (!place_meeting(x, y + sign(y_speed), obj_wall)) {
            y += sign(y_speed);
        }
        y_speed = 0;
    }
    y += y_speed;

    // 4. Sprite Direction (Flip horizontally based on movement)
    if (x_speed != 0) {
        image_xscale = sign(x_speed);
    }

    // 5. Animation Switching
    if (x_speed == 0 && y_speed == 0) {
        sprite_index = spr_fox_idle;
    } else {
        sprite_index = spr_fox_run;
    }
}

// --------------------------------------------------
// STATE: DEAD (Failed Minigame)
// --------------------------------------------------
if (state == "dead") {
    sprite_index = spr_fox_die;

    // Freeze animation on the final frame so it doesn't loop
    if (image_index >= image_number - 1) {
        image_speed = 0;
        image_index = image_number - 1;
    }
}

// --------------------------------------------------
// STATE: WIN (Completed Minigame)
// --------------------------------------------------
if (state == "win") {
    sprite_index = spr_fox_jump;
}