// Add score to manager
if (instance_exists(obj_minigame_manager_game_1)) {
    obj_minigame_manager_game_1.player_score += score_value;
}

instance_destroy();