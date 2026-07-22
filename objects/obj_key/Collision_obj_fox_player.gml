// obj_key -> Collision with obj_fox_player

// Save this key's unique ID into our global key dictionary
global.keys[$ key_id] = true;

// Optional: You can add sound effect code here later!

// Destroy the key so it disappears from the floor
instance_destroy();