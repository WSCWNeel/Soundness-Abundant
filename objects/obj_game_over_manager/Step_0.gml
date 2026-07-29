// obj_game_over_manager -> Step Event

// 1. Gather Keyboard Inputs
var _up_pressed     = keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("W"));
var _down_pressed   = keyboard_check_pressed(vk_down) || keyboard_check_pressed(ord("S"));
var _select_pressed = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);

// 2. Navigate Menu Options
if (_up_pressed) {
    menu_option--;
    if (menu_option < 0) menu_option = total_options - 1;
}

if (_down_pressed) {
    menu_option++;
    if (menu_option >= total_options) menu_option = 0;
}

// 3. Confirm Selection
if (_select_pressed) {
    
    // Define your custom safe respawn coordinates for the home screen/hub here!
    // (Change these numbers to the X and Y coordinates on your map below the sky boundary)
    var _safe_respawn_x = 32; 
    var _safe_respawn_y = 416; 

    // Reset player state if fox exists
    if (instance_exists(obj_fox_player)) {
        obj_fox_player.state = "active";
        obj_fox_player.x_speed = 0;
        obj_fox_player.y_speed = 0;
    }

    // OPTION 0: Retry Minigame
    if (menu_option == 0) {
        if (room_exists(game_1)) {
            room_goto(game_1);
        }
    }
    
    // OPTION 1: Return to Home Screen / Hub (With Safe Teleport Coordinates)
    if (menu_option == 1) {
        // Set target coordinates so Room Start teleports the fox out of the sky
        global.target_x = _safe_respawn_x;
        global.target_y = _safe_respawn_y;

        if (room_exists(home_screen)) { // Or storage_warehouse_1_interior
            room_goto(home_screen);
        }
    }
}