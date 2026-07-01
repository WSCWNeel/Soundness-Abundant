// 1. Mark this specific key as permanently collected in the global array
global.collected_keys[key_id] = true;

// 2. Add to the player's current inventory inventory
global.player_keys += 1;

// 3. Destroy the physical item on the ground
instance_destroy(self);