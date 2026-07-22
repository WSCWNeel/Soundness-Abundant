// obj_fox_player -> Step Event

// ==========================================
// STATE: ACTIVE (Normal Gameplay)
// ==========================================
if (state == "active") {
    
    // 1. Movement Inputs
    var _right = keyboard_check(vk_right) || keyboard_check(ord("D"));
    var _left  = keyboard_check(vk_left)  || keyboard_check(ord("A"));
    var _down  = keyboard_check(vk_down)  || keyboard_check(ord("S"));
    var _up    = keyboard_check(vk_up)    || keyboard_check(ord("W"));

    x_speed = (_right - _left) * move_speed;
    y_speed = (_down - _up) * move_speed;

    // 2. Collisions
    if (place_meeting(x + x_speed, y, obj_wall)) {
        while (!place_meeting(x + sign(x_speed), y, obj_wall)) {
            x += sign(x_speed);
        }
        x_speed = 0;
    }
    x += x_speed;

    if (place_meeting(x, y + y_speed, obj_wall)) {
        while (!place_meeting(x, y + sign(y_speed), obj_wall)) {
            y += sign(y_speed);
        }
        y_speed = 0;
    }
    y += y_speed;

    // 3. Normal Animations (Walk & Idle)
    // Flip the sprite left or right depending on movement direction
    if (x_speed != 0) {
        image_xscale = sign(x_speed); 
    }

    // If standing still, play Idle. Otherwise, play Walk.
    if (x_speed == 0 && y_speed == 0) {
        sprite_index = spr_fox_idle; 
    } else {
        sprite_index = spr_fox_run;
    }
}

// ==========================================
// STATE: DEAD (Player failed the minigame)
// ==========================================
if (state == "dead") {
    sprite_index = spr_fox_die;
    // Notice there is no movement code here! The player is frozen.
}

// ==========================================
// STATE: WIN (Player finished successfully)
// ==========================================
if (state == "win") {
    sprite_index = spr_fox_jump;
    // Movement is frozen here as well while the victory plays.
}