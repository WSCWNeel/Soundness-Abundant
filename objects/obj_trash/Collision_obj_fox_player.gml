// obj_trash -> Collision with obj_fox_player

// Player can only collect trash when active
if (other.state == "active") {
    if (instance_exists(obj_minigame_manager)) {
        obj_minigame_manager.player_score += 10; // Gain 10 points per trash
    }
    instance_destroy();
}