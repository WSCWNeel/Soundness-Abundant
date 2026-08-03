// Add score to manager
if (instance_exists(obj_minigame_manager)) {
    obj_minigame_manager.player_score += score_value;
}

instance_destroy();