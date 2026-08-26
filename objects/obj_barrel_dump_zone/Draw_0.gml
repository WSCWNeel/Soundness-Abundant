// obj_barrel_dump_zone - Draw Event

// Draw standard zone sprite/bounding box
draw_self();

// Draw centered visual prompt text
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_red);
draw_text(x + (image_xscale * 16), y + (image_yscale * 16), "DUMP ZONE\n(0 PTS)");

// Reset text formatting
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);