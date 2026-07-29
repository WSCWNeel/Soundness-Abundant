// obj_key -> Create Event

// If the key dictionary exists, and this specific key is marked as true (collected)...
if (variable_global_exists("keys")) {
    if (variable_struct_exists(global.keys, key_id) && global.keys[$ key_id] == true) {
        // Destroy this key on frame 1 so the player never sees it respawn
        instance_destroy(); 
    }
}