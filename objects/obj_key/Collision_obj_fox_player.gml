// 1. Mark this specific key ID as true
global.collected_keys[key_id] = true;

// 2. Add to player inventory
global.player_keys += 1;

// 3. Destroy the key
instance_destroy();