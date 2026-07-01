// 1. Print a message to the Output window to see if the key is reading its ID
show_debug_message("Key spawning with ID: " + string(key_id) + " | Collected status: " + string(global.collected_keys[key_id]));

// 2. Check the global list immediately as the object is born
if (global.collected_keys[key_id] == true) {
    show_debug_message("Key " + string(key_id) + " was already collected! Destroying self.");
    instance_destroy();
}