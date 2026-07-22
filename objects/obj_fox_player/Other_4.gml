// obj_fox_player -> Room Start Event

// 1. SAFETY GUARD: If global variables don't exist yet on boot, create them on the fly!
if (!variable_global_exists("target_x")) {
    global.target_x = -1;
}
if (!variable_global_exists("target_y")) {
    global.target_y = -1;
}

show_debug_message("--- NEW ROOM LOADED ---");
show_debug_message("Global Target X is currently: " + string(global.target_x));
show_debug_message("Global Target Y is currently: " + string(global.target_y));

// 2. TELEPORT LOGIC
if (global.target_x != -1 && global.target_y != -1) {
    x = global.target_x;
    y = global.target_y;
    
    show_debug_message("SUCCESS: Fox moved to " + string(x) + ", " + string(y));
    
    // Reset targets for the next door transition
    global.target_x = -1;
    global.target_y = -1;
} else {
    show_debug_message("DEFAULT SPAWN: Fox spawned at editor position.");
}