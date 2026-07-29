// obj_minigame_manager -> Alarm 0 Event

// Set safe coordinates for player spawn in home_screen
global.target_x = 320; // Set to your desired X spawn in home_screen
global.target_y = 480; // Set to your desired Y spawn in home_screen

if (room_exists(home_screen)) {
    room_goto(home_screen);
}