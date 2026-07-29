// obj_minigame_manager -> Alarm 0 Event

if (room_exists(game_1_win_screen)) {
    room_goto(game_1_win_screen);
} else {
    // Fallback to hub if win room isn't created yet
    global.target_x = 320; 
    global.target_y = 480;
    room_goto(home_screen);
}