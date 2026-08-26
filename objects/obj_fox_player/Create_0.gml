// obj_fox_player -> Create Event
state = "active";
image_speed = 1; // Ensures running and idle animations play normally

// SAFETY GUARD: Create the key dictionary if it doesn't exist yet
if (!variable_global_exists("keys")) {
    global.keys = {};
}

// Destroy any duplicate foxes that spawn when returning to older rooms
if (instance_number(obj_fox_player) > 1) {
    instance_destroy();
    exit; // Stops the rest of the code from running
}

// Movement variables
move_speed = 4;
x_speed = 0;
y_speed = 0;

// State control ("active", "dead", or "win")
state = "active";

// Sync the UI canvas to the game window
display_set_gui_maximize();

move_speed_modifier = 1.0;