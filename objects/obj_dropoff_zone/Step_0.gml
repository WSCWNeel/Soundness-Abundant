// obj_dropoff_zone - Step Event
if (instance_exists(obj_barrel)) {
    var _barrel = instance_place(x, y, obj_barrel);
    if (_barrel != noone && _barrel.is_held) {
        if (_barrel.color_type == target_color) {
            // Correct dropoff
            if (instance_exists(obj_minigame_manager_game_2)) {
                obj_minigame_manager_game_2.player_score += 50;
            }
            
            instance_destroy(_barrel);
            successful_drops++;
            
            // Relocate zone if max drops reached
            if (successful_drops >= max_drops_before_relocate) {
                successful_drops = 0;
                max_drops_before_relocate = irandom_range(1, 2);
                target_color = irandom(2);
                
                // Pick a new wall position
                var _new_index = (current_wall_index + irandom_range(1, 2)) % 3;
                current_wall_index = _new_index;
                x = wall_positions[current_wall_index][0];
                y = wall_positions[current_wall_index][1];
            }
        }
    }
}