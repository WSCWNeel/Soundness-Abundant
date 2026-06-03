// Step Event, everything in this panel will loop during every frame of the game.

// Get Input Directions (whether 1/up/right, -1/down/left, or 0/nothing/idle).
// var(temporary variable) used and disposed of at the end of a frame to keep device memory cleaner.

var _right = keyboard_check(vk_right);
var _left  = keyboard_check(vk_left);
var _down  = keyboard_check(vk_down);
var _up    = keyboard_check(vk_up);

// Calculate Input Vectors (eg. when right key pressed: _right = 1, _left = 0, total = 1 = cardinal right).

var _input_x = _right - _left;
var _input_y = _down - _up; // Keep in mind that due to the way computers are made via binary, _down = +y.

// Check if the player is actually pressing a direction, if not then this if and else block is skipped (idle).

if (_input_x != 0 || _input_y != 0) {
    
// Calculate the angle of movement (0 to 360 degrees, done based on the binary values from _input_x/y).
// (eg.: when (1, 0) = Right = 0° but (1, -1) = Up + Right = 45°.
// GameMaker uses: 0° as Right, 90° as Up, 180° as Left and 270° as Down (0° can also be 360° but not here).

    var _move_dir = point_direction(0, 0, _input_x, _input_y);

// lengthdir_x/y checks _move_dir and move_speed and makes sure that move_speed cap is met by v_x and v_y.
// (eg.: if _move_dir = 45° then lengthdir_x/y makes sure that x/y_distance = 2.82 pixels and -2.82 pixels.)

    v_x = lengthdir_x(move_speed, _move_dir);
    v_y = lengthdir_y(move_speed, _move_dir);

// Apply walking animation.

    sprite_index = spr_fox_run; //sprite_index specifies which sprite to use.
    if (v_x != 0) image_xscale = sign(v_x); //if v_x = -1 = left then image flipped to left from right.

} else { // Detects if no inputs (aka idle) then makes player movement = 0 and uses idle animation sprite.

    v_x = 0;
    v_y = 0;
    sprite_index = spr_fox_idle;
}

// Apply final movement to the player.

x += v_x; // shorter version of x/y = x/y + v_x/y (or teleport x/y coord = current x/y coord + v_x/y).
y += v_y; // (eg. when current x/y coord = 100 and v_x/y = 5 then teleport x/y coord = 105)*60 per second.