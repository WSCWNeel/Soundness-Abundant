// obj_minigame_manager_game_3 - Draw GUI Event

var _gw = display_get_gui_width();
var _gh = display_get_gui_height();

// --- TUTORIAL OVERLAY ---
if (state == "tutorial") {
    draw_set_color(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(0, 0, _gw, _gh, false);
    
    draw_set_alpha(1.0);
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_text(_gw / 2, _gh / 3, "GAME 3: 90-90-90 POSTURE RULE");
    
    draw_set_color(c_white);
    draw_text(_gw / 2, _gh / 2, "Maintain your posture bars!\nLeft Wall: Elbows (90°)\nBottom Wall: Hips (90°)\nRight Wall: Knees (90°)\n\nStay in a zone 2.5s to start refilling.\nHold the Bonus Target for 5s for +500 PTS!");
    draw_text(_gw / 2, _gh * 0.75, "PRESS SPACE OR ENTER TO START");
    draw_set_halign(fa_left);
    exit;
}

// --- ACTIVE GAMEPLAY HUD ---
if (state == "play") {
    // 1. Draw Posture Bars (Top-Left)
    var _bx = 20;
    var _by = 20;
    var _bw = 140;
    var _bh = 14;

    // Elbows Bar (Lime)
    draw_set_color(c_gray); draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    draw_set_color(c_lime); draw_rectangle(_bx, _by, _bx + (_bw * (elbow_posture / 100)), _by + _bh, false);
    draw_set_color(c_white); draw_text(_bx + _bw + 10, _by - 2, "Elbows");

    // Hips Bar (Aqua)
    _by += 24;
    draw_set_color(c_gray); draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    draw_set_color(c_aqua); draw_rectangle(_bx, _by, _bx + (_bw * (hip_posture / 100)), _by + _bh, false);
    draw_set_color(c_white); draw_text(_bx + _bw + 10, _by - 2, "Hips");

    // Knees Bar (Orange)
    _by += 24;
    draw_set_color(c_gray); draw_rectangle(_bx, _by, _bx + _bw, _by + _bh, false);
    draw_set_color(c_orange); draw_rectangle(_bx, _by, _bx + (_bw * (knee_posture / 100)), _by + _bh, false);
    draw_set_color(c_white); draw_text(_bx + _bw + 10, _by - 2, "Knees");

    // 2. 2.5s Zone Entry Warmup Bar (Pulsing Charge Indicator)
    if (zone_stay_timer > 0 && zone_stay_timer < zone_delay_required) {
        var _charge_ratio = zone_stay_timer / zone_delay_required;
        var _cx = 20;
        var _cy = _by + 28;
        
        draw_set_color(c_dkgray);
        draw_rectangle(_cx, _cy, _cx + _bw, _cy + 8, false);
        draw_set_color(c_yellow);
        draw_rectangle(_cx, _cy, _cx + (_bw * _charge_ratio), _cy + 8, false);
        draw_set_color(c_yellow);
        draw_text(_cx + _bw + 10, _cy - 4, "Adjusting Posture...");
    }

    // 3. Session Timer & Score (Top-Right)
    draw_set_halign(fa_right);
    draw_text(_gw - 20, 20, "TIME: " + string(ceil(total_game_timer / 60)) + "s");
    draw_text(_gw - 20, 40, "SCORE: " + string(player_score));
    draw_set_halign(fa_left);

    // 4. Dynamic Bonus Focus Target Prompt (Top-Center)
    draw_set_halign(fa_center);
    draw_set_color(c_yellow);
    draw_text(_gw / 2, 15, "BONUS TARGET: " + bonus_target_names[bonus_target]);
    
    // Target Hold Progress Bar
    var _pw = 180;
    var _ph = 8;
    var _px = (_gw / 2) - (_pw / 2);
    var _py = 38;
    draw_set_color(c_dkgray);
    draw_rectangle(_px, _py, _px + _pw, _py + _ph, false);
    draw_set_color(c_yellow);
    draw_rectangle(_px, _py, _px + (_pw * (bonus_hold_timer / bonus_required_time)), _py + _ph, false);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
}

// --- END GAME OVERLAYS ---
if (state == "win" || state == "dead") {
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_rectangle(0, 0, _gw, _gh, false);
    draw_set_alpha(1.0);
    draw_set_halign(fa_center);
    
    if (state == "win") {
        draw_set_color(c_lime);
        draw_text(_gw / 2, _gh / 3, "POSTURE MASTERED!");
    } else {
        draw_set_color(c_red);
        draw_text(_gw / 2, _gh / 3, "POOR POSTURE COLLAPSE!");
    }
    
    draw_set_color(c_white);
    draw_text(_gw / 2, _gh / 2, "FINAL SCORE: " + string(player_score));
    draw_text(_gw / 2, _gh * 0.7, "Press 'R' to Restart | Press 'ESC' to Exit");
    draw_set_halign(fa_left);
}