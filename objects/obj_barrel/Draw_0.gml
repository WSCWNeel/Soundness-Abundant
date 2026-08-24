// obj_barrel - Draw Event

// Check if the barrel is currently in its spawning fall animation
if (variable_instance_exists(id, "is_spawning") && is_spawning) {
    // Draw barrel dropping down to target position
    draw_sprite_ext(sprite_index, image_index, x, y + spawn_offset_y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
    
    // Draw shadow floor indicator
    draw_set_color(c_black);
    draw_set_alpha(0.3);
    draw_ellipse(x - 8, y - 4, x + 8, y + 4, false);
    draw_set_alpha(1.0);
    draw_set_color(c_white);
} else {
    // Standard barrel rendering
    draw_self();
}