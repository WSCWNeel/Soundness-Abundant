// obj_dropoff_zone - Step Event

if (instance_exists(obj_fox_player)) {
    // Check both physical collision AND distance (within 48 pixels of zone center)
    var _touching = place_meeting(x, y, obj_fox_player);
    var _near = (point_distance(x, y, obj_fox_player.x, obj_fox_player.y) < 48);
    
    if (_touching || _near) {
        
        // Find matching barrel held by player
        with (obj_barrel) {
            if (is_held && color_type == other.target_color) {
                
                // 1. Award Score
                if (instance_exists(obj_minigame_manager_game_2)) {
                    obj_minigame_manager_game_2.player_score += 50;
                }
                
                // 2. Increment Zone Counter
                other.successful_drops++;
                
                // 3. Destroy Delivered Barrel
                instance_destroy();
                
                // 4. Relocate Zone if Target Reached (2-3 drops)
                if (other.successful_drops >= other.max_drops_before_relocate) {
                    other.successful_drops = 0;
                    other.max_drops_before_relocate = irandom_range(2, 3);
                    other.target_color = irandom(2);
                    
                    // Pick new wall index
                    var _new_index = (other.current_wall_index + irandom_range(1, 2)) % 3;
                    other.current_wall_index = _new_index;
                    
                    // Reposition zone
                    var _pad = 64;
                    if (other.current_wall_index == 0) {
                        other.x = _pad;
                        other.y = room_height / 2;
                    } else if (other.current_wall_index == 1) {
                        other.x = room_width - _pad;
                        other.y = room_height / 2;
                    } else {
                        other.x = room_width / 2;
                        other.y = room_height - _pad;
                    }
                }
                
                // Process 1 barrel delivery per step
                break;
            }
        }
    }
}