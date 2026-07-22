// obj_fox_player -> Create Event

// Destroy any duplicate foxes that spawn when returning to older rooms
if (instance_number(obj_fox_player) > 1) {
    instance_destroy();
    exit; // Stops the rest of the code from running
}

// Your other variables stay down here
move_speed = 4;
x_speed = 0;
y_speed = 0;

// This controls what the player is currently allowed to do
state = "active"; // Can be "active", "dead", or "win"