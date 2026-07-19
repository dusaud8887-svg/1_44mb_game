var selectedColor = [16777215, 0];
if (hideAllUI)
{
    exit;
}
if (!paused)
{
    draw_sprite(spr_vignette, 0, 0, 0);
    if (room == rm_CastleMyth)
    {
        draw_sprite_ext(spr_vignette2, 0, 0, 0, 1, 1, 0, c_white, 0.5);
    }
}
draw_set_halign(fa_center);
draw_set_font(Galmuri9);
draw_set_color(c_white);
draw_text_outline(320, 30, get_time(), 1, 0, 14, 4, 100, 16777215, 1);
draw_set_font(buffFont_tiny);
var gmode = "";
if (global.gameMode == 0)
{
    gmode = "STAGE";
}
if (global.gameMode == 1)
{
    gmode = "ENDLESS";
}
if (global.gameMode == 2)
{
    gmode = "TIME";
}
draw_text(320, 20, gmode);
draw_set_font(Galmuri9);
draw_sprite_ext(hud_expbar_bg, 0, 0, -2, 1, 1, 0, c_white, 0.5);
if (global.PLAYERLEVEL > 1)
{
    draw_sprite_part(hud_expbar_anim, -1, 0, 0, 640 * ((global.experience - round(power(lvlrate1 * global.PLAYERLEVEL, lvlexponent))) / toNextLevel), 26, 0, -5);
}
else
{
    draw_sprite_part(hud_expbar_anim, -1, 0, 0, 640 * (global.experience / toNextLevel), 26, 0, -5);
}
draw_sprite_ext(hud_expbar_frame, 0, 0, -2, 1, 1, 0, c_white, 1);
draw_set_font(englishPixel);
draw_set_halign(fa_left);
draw_text_outline(590, 5, "LV: " + string(global.PLAYERLEVEL), 1.5, 0, 14, 2, 100, 16777215, 1);
draw_sprite(spr_holoCoin, 0, 500, 23);
draw_text_outline(515, 19, string(floor(global.currentRunMoneyGained)), 1.5, 0, 14, 2, 100, 16777215, 1);
if (global.gameMode != 2)
{
    draw_sprite(ui_defeatedEnemies, 0, 500, 40);
    draw_text_outline(515, 36, string(global.enemyDefeated), 1.5, 0, 14, 2, 100, 16777215, 1);
}
else
{
    draw_text_outline(500, 36, "Remaining: " + string(max(0, timeModeStart - global.enemyDefeated)), 1.5, 0, 14, 2, 100, 16777215, 1);
}
if (global.portDisplay == 0)
{
    draw_sprite(hud_portcase, 0, 0, 0);
    if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0)
    {
        draw_sprite(hud_caseSP, 0, 0, 0);
    }
    draw_sprite_part(charPortrait, 0, 0, 5, 49, 24, (hudcontainer[0] - 2) + ((hurtTime / 20) * (-4 + irandom(8))), (hudcontainer[1] - 5) + ((hurtTime / 20) * (-4 + irandom(8))));
}
else
{
    draw_sprite(hud_portcase_full, 0, 0, 0);
    if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0)
    {
        draw_sprite(hud_caseSP, 0, 0, 14);
    }
    draw_sprite(charPortrait, 0, (hudcontainer[0] - 2) + ((hurtTime / 20) * (-4 + irandom(8))), (hudcontainer[1] - 5) + ((hurtTime / 20) * (-4 + irandom(8))));
}
if (hurtTime > 0)
{
    hurtTime--;
}
if (global.showHUDHP)
{
    draw_sprite(hud_new_HUDHP, 0, 0, 0);
    if (!instance_exists(playerCharacter))
    {
        draw_sprite_part_ext(hud_HUD_HP_green, 1, 0, 0, 127, 6, 69, 15, 1, 1, c_white, 1);
        draw_sprite_part_ext(hud_HUD_HP_green, 0, 0, 0, (playerSnapshot.currentHP / playerSnapshot.HP) * 127, 6, 69, 15, 1, 1, c_white, 1);
        if (variable_struct_exists(playerSnapshot.scripts, "Plushie"))
        {
            var takenDamageBar = max(0, (playerSnapshot.scripts.Plushie.config.damageDebt - playerSnapshot.shieldHP) / playerSnapshot.HP) * 127;
            draw_sprite_part_ext(hud_HUD_HP_purple, 0, 0, 0, min(((playerSnapshot.currentHP + playerSnapshot.shieldHP) / playerSnapshot.HP) * 127, takenDamageBar), 6, 69 + max(0, ((playerSnapshot.currentHP / playerSnapshot.HP) * 127) - takenDamageBar), 15, 1, 1, c_white, 1);
        }
        if (playerSnapshot.shieldHP > 0)
        {
            draw_healthbar(69, 13, 197, 16, (playerSnapshot.shieldHP / playerSnapshot.scripts.BodyPillow.config.shieldHP) * 100, c_red, make_color_rgb(78, 173, 255), make_color_rgb(78, 173, 255), 0, 0, 0);
        }
    }
    else
    {
        draw_sprite_part_ext(hud_HUD_HP_green, 1, 0, 0, 127, 6, 69, 15, 1, 1, c_white, 1);
        draw_sprite_part_ext(hud_HUD_HP_green, 0, 0, 0, (playerCharacter.currentHP / playerCharacter.HP) * 127, 6, 69, 15, 1, 1, c_white, 1);
        if (variable_struct_exists(playerCharacter.scripts, "Plushie"))
        {
            var takenDamageBar = max(0, (playerCharacter.scripts.Plushie.config.damageDebt - playerCharacter.shieldHP) / playerCharacter.HP) * 127;
            draw_sprite_part_ext(hud_HUD_HP_purple, 0, 0, 0, min(((playerCharacter.currentHP + playerCharacter.shieldHP) / playerCharacter.HP) * 127, takenDamageBar), 6, 69 + max(0, ((playerCharacter.currentHP / playerCharacter.HP) * 127) - takenDamageBar), 15, 1, 1, c_white, 1);
        }
        if (playerCharacter.shieldHP > 0)
        {
            draw_healthbar(69, 13, 197, 16, (playerCharacter.shieldHP / playerCharacter.scripts.BodyPillow.config.shieldHP) * 100, c_red, make_color_rgb(78, 173, 255), make_color_rgb(78, 173, 255), 0, 0, 0);
        }
    }
}
if (global.showHPVal)
{
    draw_sprite(hud_new_HUDHP, 0, 0, 0);
    draw_set_halign(fa_left);
    draw_set_font(buffFont_tiny);
    if (!instance_exists(playerCharacter))
    {
        if (playerSnapshot.HP == 44.5)
        {
            draw_text_outline(73 + (global.showHUDHP * 127), 15, string_format(playerSnapshot.currentHP, 1, 1) + " / " + string_format(playerSnapshot.HP, 1, 1), 1, 0, 14, 0, 100, 16777215, 1);
        }
        else
        {
            draw_text_outline(73 + (global.showHUDHP * 127), 15, string(floor(playerSnapshot.currentHP)) + " / " + string(floor(playerSnapshot.HP)), 1, 0, 14, 0, 100, 16777215, 1);
        }
    }
    else if (playerSnapshot.HP == 44.5)
    {
        draw_text_outline(73 + (global.showHUDHP * 127), 15, string_format(playerCharacter.currentHP, 1, 1) + " / " + string_format(playerCharacter.HP, 1, 1), 1, 0, 14, 0, 100, 16777215, 1);
    }
    else
    {
        draw_text_outline(73 + (global.showHUDHP * 127), 15, string(floor(playerCharacter.currentHP)) + " / " + string(floor(playerCharacter.HP)), 1, 0, 14, 0, 100, 16777215, 1);
    }
}
if (variable_struct_names_count(customDrawScript) > 0)
{
    keys = variable_struct_get_names(customDrawScript);
    for (var i = 0; i < array_length(keys); i++)
    {
        var Script = variable_struct_get(customDrawScript, keys[i]);
        Script(id);
    }
}
if (global.showStamps)
{
    displacement = (!global.showHPVal && !global.showHUDHP) * 10;
    for (var i = 0; i < array_length(global.currentStickers); i++)
    {
        if (global.currentStickers[i] != -1)
        {
            draw_sprite_ext(global.currentStickers[i].optionIcon, 0, 212, (35 + (i * 17)) - displacement, 0.5, 0.5, 0, c_white, 0.75);
        }
    }
}
var displacement = 7;
var xdisplacement = -3;
if (((paused && !gotBox) || (paused && gotBox && boxOpenned)) && !gameOvered && !gameWon && !reviving)
{
    if (leftcontainer[0] != 35)
    {
        leftcontainer[0] += 30;
    }
    if (leftcontainer[0] > 35)
    {
        leftcontainer[0] = 35;
    }
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    draw_set_halign(fa_right);
    draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 10, charName);
    if (global.charSelected.large_port > 0)
    {
        draw_sprite_ext(global.charSelected.large_port, 0, leftcontainer[0] + 30, 290, 2, 2, 0, c_white, 0.4);
    }
    draw_set_halign(fa_left);
    draw_sprite(hud_HPicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 33);
    draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 35, "HP");
    draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 47);
    draw_sprite(hud_atkicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 53);
    draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 55, "ATK");
    draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 67);
    draw_sprite(hud_spdicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 73);
    draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 75, "SPD");
    draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 87);
    draw_sprite(hud_criticon, 0, leftcontainer[0] + 3, leftcontainer[1] + 93);
    draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 95, "CRT");
    draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 107);
    draw_sprite(hud_pickupicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 113);
    draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 115, "Pickup");
    draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 127);
    draw_sprite(hud_cooldownicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 133);
    draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 135, "Haste");
    draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 147);
    if (global.lives > 1)
    {
        draw_sprite(hud_livesicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 153);
        draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 155, "Lives");
        draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 167);
        draw_set_halign(fa_right);
        draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 155, "+" + string(global.lives - 1));
    }
    if (playerSnapshot.CritMod > 0.5)
    {
        draw_set_halign(fa_left);
        draw_sprite(hud_critdamicon, 0, leftcontainer[0] + 3, leftcontainer[1] + 153 + ((global.lives > 1) * 20));
        draw_text_scribble(leftcontainer[0] + 25, leftcontainer[1] + 155 + ((global.lives > 1) * 20), "CRT Damage");
        draw_sprite(ui_menu_stats_divider, 0, leftcontainer[0] + 25, leftcontainer[1] + 167 + ((global.lives > 1) * 20));
        draw_set_halign(fa_right);
        draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 155 + ((global.lives > 1) * 20), "+" + string(round((playerSnapshot.CritMod - 0.5) * 100)) + "%");
    }
    draw_set_halign(fa_right);
    if (global.maxHP == 44.5)
    {
        draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 35, string_format(global.currentHP, 1, 1) + " / " + string_format(global.maxHP, 1, 1));
    }
    else
    {
        draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 35, string(floor(global.currentHP)) + " / " + string(floor(global.maxHP)));
    }
    draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 55, getSign(round((playerSnapshot.ATK - charData.ATK) * 100)) + string(round((playerSnapshot.ATK - charData.ATK) * 100)) + "%");
    draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 75, getSign(round((playerSnapshot.SPD - charData.SPD) * 100)) + string(round((playerSnapshot.SPD - charData.SPD) * 100)) + "%");
    draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 95, getSign(playerSnapshot.crit) + string(playerSnapshot.crit) + "%");
    draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 115, getSign(playerSnapshot.pickupRange) + string(playerSnapshot.pickupRange) + "%");
    draw_text_scribble(leftcontainer[0] + 145, leftcontainer[1] + 135, getSign(playerSnapshot.haste) + string(playerSnapshot.haste) + "%");
    draw_set_font(Galmuri9);
    if (!leveled && !gotBox && !perksMenu && !collabsMenu && !gotSticker && !gotAnvil && !gotGoldenAnvil)
    {
        if (pauseCurrentMenu == 0 && !quitConfirm)
        {
            commandPromps(true, true, true);
            draw_sprite(hud_pausemenu, 0, pauseContainer[0], pauseContainer[1]);
            draw_set_halign(fa_center);
            draw_set_color(c_white);
            draw_set_font(Galmuri14);
            draw_text_outline(320, pauseContainer[1] + 13, "PAUSED", 1, 0, 32, 4, 100, 0, 1);
            draw_text_outline(320, pauseContainer[1] + 10, "PAUSED", 1, 0, 32, 4, 100, 16777215, 1);
            for (var i = 0; i < 6; i++)
            {
                if (pauseOption == i)
                {
                    draw_sprite(hud_confirmButton, 0, pauseContainer[0], pauseContainer[1] + 62 + (i * 30));
                }
                else
                {
                    draw_sprite(hud_unselectButton, 0, pauseContainer[0], pauseContainer[1] + 62 + (i * 30));
                }
                if (obj_InputManager.mouseMoving && MouseOverButton("short", pauseContainer[0], pauseContainer[1] + 62 + (i * 30), 2))
                {
                    if (pauseOption != i && obj_InputManager.MouseMoved())
                    {
                        pauseOption = i;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
            }
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            if (pauseOption == 0)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text_scribble(pauseContainer[0], pauseContainer[1] + 56, global.TextContainer.gameAbilities.selectedLanguage);
            if (pauseOption == 1)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            if (ds_map_find_value(global.PlayerSave, "stamps") > 0)
            {
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 86, global.TextContainer.gameStamps.selectedLanguage);
            }
            else
            {
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 86, "????");
            }
            if (pauseOption == 2)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            if (array_length(global.seenCollabs) > 0)
            {
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 116, global.TextContainer.gameCollabs.selectedLanguage);
            }
            else
            {
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 116, "????");
            }
            if (pauseOption == 3)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text_scribble(pauseContainer[0], pauseContainer[1] + 146, global.TextContainer.gameResume.selectedLanguage);
            if (pauseOption == 4)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text_scribble(pauseContainer[0], pauseContainer[1] + 176, global.TextContainer.gameSettings.selectedLanguage);
            if (pauseOption == 5)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text_scribble(pauseContainer[0], pauseContainer[1] + 206, global.TextContainer.gameQuit.selectedLanguage);
            if (disconnectWarning)
            {
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 255, "[c_red]Controller disconnected.[/color]");
            }
        }
        if (quitConfirm)
        {
            commandPromps(true, true, true);
            draw_sprite(hud_quitConfirm, 0, pauseContainer[0], pauseContainer[1] + 40);
            draw_set_halign(fa_center);
            draw_set_color(c_white);
            draw_set_font(Galmuri14);
            draw_set_alpha(1);
            draw_text_outline(pauseContainer[0], pauseContainer[1] + 48, "QUIT?", 1, 0, 32, 4, 100, 0, 1);
            draw_text_outline(pauseContainer[0], pauseContainer[1] + 45, "QUIT?", 1, 0, 32, 4, 100, 16777215, 1);
            for (var i = 0; i < 2; i++)
            {
                if (quitOption == i)
                {
                    draw_sprite(hud_confirmButton, 0, pauseContainer[0], pauseContainer[1] + 30 + 62 + (i * 30));
                }
                else
                {
                    draw_sprite(hud_unselectButton, 0, pauseContainer[0], pauseContainer[1] + 30 + 62 + (i * 30));
                }
                if (MouseOverButton("short", pauseContainer[0], pauseContainer[1] + 30 + 62 + (i * 30), 2))
                {
                    if (quitOption != i && obj_InputManager.MouseMoved())
                    {
                        quitOption = i;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
            }
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            if (quitOption == 0)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text_scribble(pauseContainer[0], pauseContainer[1] + 30 + 56, global.TextContainer.yesno.selectedLanguage[0]);
            if (quitOption == 1)
            {
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text_scribble(pauseContainer[0], pauseContainer[1] + 30 + 86, global.TextContainer.yesno.selectedLanguage[1]);
        }
    }
}
displacement -= ((!global.showHPVal && !global.showHUDHP) * 10);
draw_sprite(hud_new_HUD, 0, 0, displacement - 7);
draw_sprite(charWeapon, 0, hudcontainer[0] + 62 + xdisplacement, hudcontainer[1] + 9 + displacement);
draw_sprite(ui_level_header_pink, 0, hudcontainer[0] + 52 + xdisplacement, hudcontainer[1] + 17 + displacement);
draw_sprite(ui_digit_pink, ds_map_find_value(playerSnapshot.attacks, global.charSelected.attackID).config.level, hudcontainer[0] + 65 + xdisplacement, hudcontainer[1] + 19 + displacement);
var noMain = ds_map_create();
ds_map_copy(noMain, playerSnapshot.attacks);
ds_map_delete(noMain, global.charSelected.attackID);
var size = ds_map_size(noMain);
var key = ds_map_find_first(noMain);
for (var i = 0; i < size; i++)
{
    if (key != undefined)
    {
        var lookup = ds_map_find_value(noMain, key);
        if (lookup.config.optionType != "Weapon" && lookup.config.optionType != "Collab" && lookup.config.optionType != "SuperCollab")
        {
            ds_map_delete(noMain, key);
        }
    }
    key = ds_map_find_next(noMain, key);
}
size = ds_map_size(noMain);
key = ds_map_find_first(noMain);
for (var i = 0; i < 5; i++)
{
    if (i >= size)
    {
        draw_sprite_ext(ui_empty_slot_weapon, 0, hudcontainer[0] + 87 + (i * 25) + xdisplacement, hudcontainer[1] + 10 + displacement, 1, 1, 0, c_white, 0.4);
    }
}
for (var i = 0; i < size; i++)
{
    if (key != undefined)
    {
        draw_sprite(ds_map_find_value(noMain, key).config.optionIcon, 0, hudcontainer[0] + 87 + (i * 25) + xdisplacement, hudcontainer[1] + 9 + displacement);
        draw_sprite(ui_level_header_white, 0, hudcontainer[0] + 77 + (i * 25) + xdisplacement, hudcontainer[1] + 17 + displacement);
        draw_sprite(ui_digit_white, ds_map_find_value(noMain, key).config.level, hudcontainer[0] + 90 + (i * 25) + xdisplacement, hudcontainer[1] + 19 + displacement);
    }
    key = ds_map_find_next(noMain, key);
}
ds_map_destroy(noMain);
noMain = -1;
var size2 = array_length(variable_struct_get_names(items));
var itemKeys = variable_struct_get_names(items);
for (var i = 0; i < 6; i++)
{
    if (i >= size2)
    {
        draw_sprite_ext(ui_empty_slot_item, 0, hudcontainer[0] + 62 + (i * 25) + xdisplacement, hudcontainer[1] + 37 + displacement, 1, 1, 0, c_white, 0.4);
    }
}
for (var i = 0; i < size2; i++)
{
    var anItem = itemKeys[i];
    if (ds_map_find_value(ITEMS, anItem) != undefined)
    {
        draw_sprite(ds_map_find_value(ITEMS, anItem).optionIcon, 0, hudcontainer[0] + 62 + (i * 25) + xdisplacement, hudcontainer[1] + 37 + displacement);
        draw_sprite(ui_level_header_yellow, 0, hudcontainer[0] + 52 + (i * 25) + xdisplacement, hudcontainer[1] + 45 + displacement);
        if (ds_map_find_value(ITEMS, anItem).becomeSuper)
        {
            draw_sprite(ui_digit_yellow, 1, hudcontainer[0] + 65 + (i * 25) + xdisplacement, hudcontainer[1] + 47 + displacement);
        }
        else
        {
            draw_sprite(ui_digit_yellow, ds_map_find_value(ITEMS, anItem).level + 1, hudcontainer[0] + 65 + (i * 25) + xdisplacement, hudcontainer[1] + 47 + displacement);
        }
    }
}
if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0)
{
    var meterCheck = 0;
    if (instance_exists(playerCharacter))
    {
        meterCheck = playerCharacter;
    }
    else
    {
        meterCheck = playerSnapshot;
    }
    var specdisplacement = 4 + (global.portDisplay * 14);
    draw_sprite_part(ui_SP_Bar_bg, 0, 0, 0, 25, 8, hudcontainer[0] + 18, hudcontainer[1] + 20 + specdisplacement);
    if (meterCheck.specialMeter < floor(meterCheck.specCD * (meterCheck.specMod - ((global.gameMode < 2) * 0.03 * ds_map_find_value(global.PlayerSave, "specCDR")))))
    {
        draw_sprite_part(ui_SP_Bar_fill, 0, 0, 0, min(25, (meterCheck.specialMeter / floor(meterCheck.specCD * (meterCheck.specMod - ((global.gameMode < 2) * 0.03 * ds_map_find_value(global.PlayerSave, "specCDR"))))) * 25), 8, hudcontainer[0] + 18, hudcontainer[1] + 20 + specdisplacement);
        draw_sprite_ext(charSpecial, 0, hudcontainer[0] + 10, hudcontainer[1] + 28 + specdisplacement, 1, 1, 0, c_white, 0.5 + (meterCheck.canSpecial * 0.5));
    }
    else
    {
        specialColorTime += 0.025;
        specialIconPulseTime += 0.03;
        if (specialColorTime > 1.0471975511965976)
        {
            specialColorTime = 0;
        }
        var RGBcolor = make_color_hsv(sin(specialColorTime) * 255, 255, 255);
        draw_sprite_part_ext(ui_SP_Bar_fill_rainbow, 0, 0, 0, (meterCheck.specialMeter / floor(meterCheck.specCD * (meterCheck.specMod - ((global.gameMode < 2) * 0.03 * ds_map_find_value(global.PlayerSave, "specCDR"))))) * 25, 8, hudcontainer[0] + 18, hudcontainer[1] + 20 + specdisplacement, 1, 1, RGBcolor, 1);
        draw_set_font(excluded_smaller);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_sprite_ext(charSpecial, 0, hudcontainer[0] + 10, hudcontainer[1] + 28 + specdisplacement, 1, 1, 0, c_white, 0.5 + (meterCheck.canSpecial * 0.5));
        if (specialIconPulseTime < 0.8)
        {
            gpu_set_blendmode(bm_add);
            draw_sprite_ext(charSpecial, 0, hudcontainer[0] + 10, hudcontainer[1] + 28 + specdisplacement, 1 + (specialIconPulseTime * 2), 1 + (specialIconPulseTime * 2), 0, c_white, 0.8 - specialIconPulseTime);
            gpu_set_blendmode(bm_normal);
        }
        if (specialIconPulseTime > 3)
        {
            specialIconPulseTime = 0;
        }
    }
}
if (paused && leveled && !gameOvered && !gameWon && !gotSticker && !gotBox && !gotAnvil && !gotGoldenAnvil && !reviving && !perksMenu)
{
    instance_create_depth(round(random(640)), 370, depth + 1, obj_risingParticle);
    if (rightcontainer[0] != 220)
    {
        rightcontainer[0] -= 80;
    }
    if (rightcontainer[0] < 220)
    {
        rightcontainer[0] = 220;
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_outline(120, 100, "LEVEL UP!", 2, 0, 16, 4, 200, 16777215, 1);
    commandPromps(true, true, false);
    for (var i = 0; i < 4; i++)
    {
        var canEliminate = eliminateMode;
        if (options[i].optionType == "StatUp" || options[i].optionType == "Consumable")
        {
            canEliminate = false;
        }
        if (i == levelOptionSelect && !collabListSelected)
        {
            draw_sprite(ui_menu_upgrade_window_selected, canEliminate, rightcontainer[0], rightcontainer[1] + (i * 69));
        }
        else
        {
            draw_sprite(ui_menu_upgrade_window, canEliminate, rightcontainer[0], rightcontainer[1] + (i * 69));
        }
        DrawOption(rightcontainer[0], rightcontainer[1] + (i * 69), options[i], false, false, i);
        if (MouseOverButton("fullOption", rightcontainer[0], rightcontainer[1] + (i * 69)) && !collabListShowing)
        {
            if (i != levelOptionSelect && obj_InputManager.MouseMoved())
            {
                levelOptionSelect = i;
                textPage = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (levelOptionSelect == i)
            {
                ClickButton();
            }
        }
    }
    if (levelOptionSelect < 4 && !collabListSelected)
    {
        draw_sprite(spr_holoCursor, image_index / 4, rightcontainer[0] - 15, rightcontainer[1] + (levelOptionSelect * 69) + 36);
    }
    draw_set_halign(fa_center);
    draw_set_font(Galmuri9);
    if (ds_map_find_value(global.PlayerSave, "reroll") > 0)
    {
        draw_sprite(hud_LevelButton, levelOptionSelect == 4, rightcontainer[0] + 130, rightcontainer[1] + 279);
        draw_text_color(rightcontainer[0] + 130, rightcontainer[1] + 285, string(global.TextContainer.levelButtons.selectedLanguage[0]) + " (" + string(global.rerollTimes) + ")", selectedColor[levelOptionSelect == 4], selectedColor[levelOptionSelect == 4], selectedColor[levelOptionSelect == 4], selectedColor[levelOptionSelect == 4], 1);
        if (MouseOverButton("levelButton", rightcontainer[0] + 130, rightcontainer[1] + 279) && !collabListShowing)
        {
            if (4 != levelOptionSelect && obj_InputManager.MouseMoved())
            {
                levelOptionSelect = 4;
                textPage = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (4 == levelOptionSelect)
            {
                ClickButton();
            }
        }
    }
    if (ds_map_find_value(global.PlayerSave, "eliminate") > 0)
    {
        draw_sprite(hud_LevelButton, levelOptionSelect == 5, rightcontainer[0] + 250, rightcontainer[1] + 279);
        draw_text_color(rightcontainer[0] + 250, rightcontainer[1] + 285, string(global.TextContainer.levelButtons.selectedLanguage[1]) + " (" + string(global.eliminateTimes) + ")", selectedColor[levelOptionSelect == 5], selectedColor[levelOptionSelect == 5], selectedColor[levelOptionSelect == 5], selectedColor[levelOptionSelect == 5], 1 - (eliminatedThisLevel * 0.5));
        if (MouseOverButton("levelButton", rightcontainer[0] + 250, rightcontainer[1] + 279) && !collabListShowing)
        {
            if (5 != levelOptionSelect && obj_InputManager.MouseMoved())
            {
                levelOptionSelect = 5;
                textPage = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (5 == levelOptionSelect)
            {
                ClickButton();
            }
        }
    }
    if (array_length(global.seenCollabs) > 0)
    {
        if (collabListShowing)
        {
            if (collabListWindow[0] > 380)
            {
                collabListWindow[0] -= 50;
            }
            if (collabListWindow[0] < 380)
            {
                collabListWindow[0] = 380;
            }
        }
        else
        {
            if (collabListWindow[0] < 630)
            {
                collabListWindow[0] += 50;
            }
            if (collabListWindow[0] > 630)
            {
                collabListWindow[0] = 630;
            }
        }
        draw_sprite_ext(hud_collabList, 0, collabListWindow[0], collabListWindow[1], 1, 1, 0, c_white, min(1, 0.3 + (collabListSelected * 0.25) + collabListSelected));
        for (var i = 0; i < min(5, array_length(global.seenCollabs)); i++)
        {
            draw_set_font(Galmuri14);
            draw_set_halign(fa_center);
            draw_text_outline(collabListWindow[0] + 120, collabListWindow[1] + 15, "COLLAB", 1, 0, 14, 15, 200, 16777215, 1);
            draw_text_scribble(collabListWindow[0] + 41 + 45, collabListWindow[1] + 60 + (i * 40), " = ");
            draw_text_scribble(collabListWindow[0] + 41 + 125, collabListWindow[1] + 60 + (i * 40), " + ");
            draw_set_alpha(0.5);
            draw_set_color(c_black);
            draw_rectangle((collabListWindow[0] + 41) - 14, (collabListWindow[1] + 71 + (i * 40)) - 14, collabListWindow[0] + 41 + 13, collabListWindow[1] + 71 + (i * 40) + 13, false);
            draw_rectangle((collabListWindow[0] + 41 + 88) - 14, (collabListWindow[1] + 71 + (i * 40)) - 14, collabListWindow[0] + 41 + 88 + 13, collabListWindow[1] + 71 + (i * 40) + 13, false);
            draw_rectangle((collabListWindow[0] + 41 + 159) - 14, (collabListWindow[1] + 71 + (i * 40)) - 14, collabListWindow[0] + 41 + 159 + 13, collabListWindow[1] + 71 + (i * 40) + 13, false);
            draw_set_alpha(1);
            draw_set_color(c_white);
            draw_sprite(hud_optionIconCase, 0, collabListWindow[0] + 41, collabListWindow[1] + 71 + (i * 40));
            draw_sprite(hud_optionIconCase, 0, collabListWindow[0] + 41 + 88, collabListWindow[1] + 71 + (i * 40));
            draw_sprite(hud_optionIconCase, 0, collabListWindow[0] + 41 + 159, collabListWindow[1] + 71 + (i * 40));
            size = ds_map_size(playerSnapshot.attacks);
            key = ds_map_find_first(playerSnapshot.attacks);
            var attacksArray = [];
            size = ds_map_size(playerSnapshot.attacks);
            key = ds_map_find_first(playerSnapshot.attacks);
            for (var j = 0; j < size; j++)
            {
                if (key != undefined)
                {
                    array_push(attacksArray, ds_map_find_value(playerSnapshot.attacks, key).config.attackID);
                }
                key = ds_map_find_next(playerSnapshot.attacks, key);
            }
            draw_sprite(global.seenCollabs[i + collabListStartingPosition].optionIcon, 0, collabListWindow[0] + 41, collabListWindow[1] + 71 + (i * 40));
            if (array_exists(attacksArray, ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + collabListStartingPosition].combos[0]).config.attackID))
            {
                draw_set_alpha(0.5);
                draw_set_color(make_color_rgb(255, 246, 178));
                draw_rectangle((collabListWindow[0] + 41 + 88) - 14, (collabListWindow[1] + 71 + (i * 40)) - 14, collabListWindow[0] + 41 + 88 + 13, collabListWindow[1] + 71 + (i * 40) + 13, false);
                draw_set_alpha(1);
                draw_sprite_ext(spr_pulse, image_index / 3, collabListWindow[0] + 41 + 88, collabListWindow[1] + 71 + (i * 40), 2, 2, 0, c_white, 1);
            }
            draw_sprite(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + collabListStartingPosition].combos[0]).config.optionIcon, 0, collabListWindow[0] + 41 + 88, collabListWindow[1] + 71 + (i * 40));
            if (!is_undefined(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + collabListStartingPosition].combos[1])))
            {
                if (array_exists(attacksArray, ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + collabListStartingPosition].combos[1]).config.attackID))
                {
                    draw_set_alpha(0.5);
                    draw_set_color(make_color_rgb(255, 246, 178));
                    draw_rectangle((collabListWindow[0] + 41 + 159) - 14, (collabListWindow[1] + 71 + (i * 40)) - 14, collabListWindow[0] + 41 + 159 + 13, collabListWindow[1] + 71 + (i * 40) + 13, false);
                    draw_set_alpha(1);
                    draw_sprite_ext(spr_pulse, image_index / 3, collabListWindow[0] + 41 + 159, collabListWindow[1] + 71 + (i * 40), 2, 2, 0, c_white, 1);
                }
            }
            else
            {
                var itemsArray = variable_struct_get_names(items);
                if (array_exists(itemsArray, ds_map_find_value(global.itemsLibrary, global.seenCollabs[i + collabListStartingPosition].combos[1]).optionID))
                {
                    draw_set_alpha(0.5);
                    draw_set_color(make_color_rgb(255, 246, 178));
                    draw_rectangle((collabListWindow[0] + 41 + 159) - 14, (collabListWindow[1] + 71 + (i * 40)) - 14, collabListWindow[0] + 41 + 159 + 13, collabListWindow[1] + 71 + (i * 40) + 13, false);
                    draw_set_alpha(1);
                    draw_sprite_ext(spr_pulse, image_index / 3, collabListWindow[0] + 41 + 159, collabListWindow[1] + 71 + (i * 40), 2, 2, 0, c_white, 1);
                }
            }
            if (!is_undefined(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + collabListStartingPosition].combos[1])))
            {
                draw_sprite(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + collabListStartingPosition].combos[1]).config.optionIcon, 0, collabListWindow[0] + 41 + 159, collabListWindow[1] + 71 + (i * 40));
            }
            else
            {
                draw_sprite(ds_map_find_value(global.itemsLibrary, global.seenCollabs[i + collabListStartingPosition].combos[1]).optionIcon, 0, collabListWindow[0] + 41 + 159, collabListWindow[1] + 71 + (i * 40));
            }
            if (MouseOverButton("collabList", 630, 60))
            {
                if (collabListSelected)
                {
                    ClickButton();
                }
                else if (obj_InputManager.MouseMoved())
                {
                    collabListSelected = true;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            else if (obj_InputManager.MouseMoved())
            {
                if (!collabListShowing && collabListSelected)
                {
                    collabListSelected = false;
                }
            }
            collabListStartingPosition = ScrollBar(global.seenCollabs, collabListWindow[0] + 228, collabListWindow[1] + 60, collabListWindow[1] + 60 + 180, 1, 5, collabListStartingPosition, collabListShowing);
        }
        draw_set_font(Galmuri9);
        draw_set_halign(fa_left);
    }
}
if (paused && gotBox && !gotSticker && !gameOvered && !gameWon && !leveled && !gotAnvil && !reviving && !perksMenu)
{
    if (boxAnimState > 0 && boxAnimState < 3)
    {
        if (boxAnimState < 2 && !boxOpenned)
        {
            superLit++;
            if (superLit > 22 && !boxOpenned)
            {
                superLit = 0;
            }
            draw_set_alpha(0.1 - ((superLit / 22) * 0.1));
            draw_rectangle_color(0, 0, 800, 600, c_white, c_white, c_white, c_white, 0);
            draw_set_alpha(1);
        }
        else
        {
        }
        instance_create_depth(round(random(640)), 370, depth + 1, obj_risingParticle);
        instance_create_depth(round(random(640)), 370, depth + 1, obj_holoCoinBG);
        if (boxItemAmount == 3)
        {
            var sparks = instance_create_depth(round(random(640)), 370, depth + 1, obj_sparkle);
            sparks.vspeed *= 2;
        }
        if (superBox && (boxBounceTime % 2) == 0)
        {
            instance_create_depth(round(random(640)), 370, depth + 1, obj_holoCoinBG);
            instance_create_depth(round(random(640)), 370, depth + 1, obj_holoCoinBG);
            var lights = instance_create_depth(295 + random(50), 365, depth + 20, obj_idollights);
            lights.rotDir = 1 - (random(1) * 2);
            lights.rotSpeed = 2 + random(2);
            lights.guiMode = true;
            if (superLit == 0)
            {
                instance_create_depth(30 + irandom(610), 360, depth - 20, obj_fireworks);
            }
        }
    }
    if (boxAnimState > 0 && !boxOpenned)
    {
        if (boxItemAmount == 3)
        {
            gpu_set_blendmode(bm_add);
            draw_sprite_ext(hud_boxSpotLight, 0, 0, 0, 1, 1, 45 + (15 * sin(boxBounceTime / 20)), c_white, 0.5);
            draw_sprite_ext(hud_boxSpotLight, 0, 640, 0, 1, 1, -45 - (15 * sin(boxBounceTime / 20)), c_white, 0.5);
            gpu_set_blendmode(bm_normal);
        }
        if (superBox)
        {
            gpu_set_blendmode(bm_add);
            draw_sprite_ext(hud_boxSpotLight, 0, 0, 0, 1, 1, 45 + (15 * sin(boxBounceTime / 20)), make_color_rgb(255, 238, 161), 0.5);
            draw_sprite_ext(hud_boxSpotLight, 0, 640, 0, 1, 1, -45 - (15 * sin(boxBounceTime / 20)), make_color_rgb(255, 238, 161), 0.5);
            gpu_set_blendmode(bm_normal);
        }
    }
    if (itemBoxContainer[1] != 40)
    {
        itemBoxContainer[1] += 80;
    }
    if (itemBoxContainer[1] > 40)
    {
        itemBoxContainer[1] = 40;
    }
    if (!superBox)
    {
        draw_sprite(hud_getBoxWindow, 0, itemBoxContainer[0], itemBoxContainer[1]);
    }
    if (superBox)
    {
        if (boxAnimState > 0 && !boxOpenned)
        {
            draw_sprite(hud_getBoxWindow, 0, (itemBoxContainer[0] - 5) + irandom(10), (itemBoxContainer[1] - 5) + irandom(10));
        }
        else
        {
            draw_sprite(hud_getBoxWindow, 0, itemBoxContainer[0], itemBoxContainer[1]);
        }
    }
    if (boxAnimState == 0)
    {
        draw_sprite(hud_confirmButton, 0, itemBoxContainer[0] + 100, itemBoxContainer[1] + 262);
        draw_set_color(c_black);
        draw_set_halign(fa_center);
        draw_set_font(Galmuri9);
        draw_text_scribble(itemBoxContainer[0] + 100, itemBoxContainer[1] + 256, "OPEN!");
        commandPromps(true, true, false);
        if (MouseOverButton("short", itemBoxContainer[0] + 100, itemBoxContainer[1] + 262))
        {
            ClickButton();
        }
    }
    if (!boxOpenned && boxAnimState > 0)
    {
        boxCoinTime++;
        if ((boxCoinTime % boxCoinRate) == 0)
        {
            boxCoinGain += (1 * (1 + playerSnapshot.moneyGain) * global.stageCoinBonus);
        }
    }
    if (boxAnimState > 0)
    {
        draw_set_font(Galmuri9);
        draw_set_color(c_yellow);
        draw_set_halign(fa_center);
        var shakeX = (-boxCoinRate + (2 * irandom(boxCoinRate))) / 2;
        var shakeY = (-boxCoinRate + (2 * irandom(boxCoinRate))) / 2;
        if (boxOpenned)
        {
            shakeX = 0;
            shakeY = 0;
        }
        draw_text_outline(325 + shakeX, 55 + shakeY, floor(boxCoinGain), 1.5, 0, 14, 2, 100, 65535, 1);
        draw_sprite(spr_holoCoin, 0, (325 - (string_width(boxCoinGain) / 2) - 15) + shakeX, 60 + shakeY);
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    if (boxItemAmount == 1 && !superBox)
    {
        if (boxBounceTime > 263)
        {
            boxAnimState = 2;
            image_index = 0;
            boxBounceTime = 0;
            boxOpenTime = 0;
        }
    }
    else if (boxItemAmount == 3)
    {
        if (boxBounceTime > 361)
        {
            boxAnimState = 2;
            image_index = 0;
            boxBounceTime = 0;
            boxOpenTime = 0;
        }
    }
    else if (boxItemAmount == 1 && superBox)
    {
        if (boxBounceTime > 351)
        {
            boxAnimState = 2;
            image_index = 0;
            boxBounceTime = 0;
            boxOpenTime = 0;
        }
    }
    if (boxOpenTime >= (sprite_get_speed(2324) * 5.5))
    {
        boxOpenTime = 0;
        boxAnimState = 3;
    }
    if (boxOpenTime == 38)
    {
        boxOpenned = true;
        superLit = 80;
        var half = (20 + irandom(10)) / 100;
        var extra = boxCoinGain * half * (1 + playerSnapshot.moneyGain) * boxItemAmount * global.stageCoinBonus * (1 + (4 * superBox));
        boxCoinGain += extra;
        for (var i = 0; i < 75; i++)
        {
            instance_create_depth(((itemBoxContainer[0] + 100) - 40) + random(80), itemBoxContainer[1] + 172, depth - 30, obj_holoCoin);
        }
        if (boxItemAmount == 1)
        {
            for (var i = 0; i < 5; i++)
            {
                var beam = instance_create_depth(itemBoxContainer[0] + 100, itemBoxContainer[1] + 80, depth - 1, obj_itemLightBeam);
                beam.image_angle = i * 72;
            }
        }
        if (boxItemAmount == 3)
        {
            for (var i = 0; i < 5; i++)
            {
                var beam = instance_create_depth(itemBoxContainer[0] + 100, itemBoxContainer[1] + 120, depth - 1, obj_itemLightBeam);
                beam.image_angle = i * 72;
            }
            for (var i = 0; i < 5; i++)
            {
                var beam = instance_create_depth(itemBoxContainer[0] + 50, itemBoxContainer[1] + 60, depth - 1, obj_itemLightBeam);
                beam.image_angle = i * 72;
            }
            for (var i = 0; i < 5; i++)
            {
                var beam = instance_create_depth(itemBoxContainer[0] + 150, itemBoxContainer[1] + 60, depth - 1, obj_itemLightBeam);
                beam.image_angle = i * 72;
            }
        }
    }
    if (boxOpenned && boxAnimState < 3)
    {
        for (var i = 0; i < 5; i++)
        {
            instance_create_depth(((itemBoxContainer[0] + 100) - 40) + random(80), itemBoxContainer[1] + 172, depth - 30, obj_sparkle);
        }
    }
    switch (boxAnimState)
    {
        case 0:
            draw_text_outline(itemBoxContainer[0] + 100, itemBoxContainer[1] + 17, "택배 왔어요!", 2, 0, 16, 4, 200, 16777215, 1);
            draw_sprite(hud_getBoxClosed, 0, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
            break;
        case 1:
            boxBounceTime++;
            soundPlay([130], "coin", 6, 10);
            if (boxItemAmount == 1)
            {
                if (!superBox)
                {
                    draw_sprite(hud_getBoxBouncing, image_index / 5.5, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
                }
                else
                {
                    if (boxBounceTime < 91)
                    {
                        draw_sprite(hud_getBoxClosed, 0, ((itemBoxContainer[0] + 100) - 10) + random(20), ((itemBoxContainer[1] + 222) - 10) + random(20));
                        var vfx = instance_create_depth(((itemBoxContainer[0] + 100) - 50) + random(100), itemBoxContainer[1] + 222, depth - 20, obj_vfxGUI);
                        vfx.sprite_index = spr_gachaorb;
                        vfx.vspeed = -10;
                        vfx.alarm[1] = 1;
                        vfx.add = true;
                        vfx.image_speed = 0;
                        vfx.image_xscale = 0.3 + random(0.3);
                        vfx.image_yscale = vfx.image_xscale;
                        vfx.image_alpha = 0.6;
                        if (boxBounceTime == 1)
                        {
                            instance_create_depth(91, 360, depth - 20, obj_fireworks);
                            instance_create_depth(182, 360, depth - 20, obj_fireworks);
                            instance_create_depth(273, 360, depth - 20, obj_fireworks);
                            instance_create_depth(364, 360, depth - 20, obj_fireworks);
                            instance_create_depth(455, 360, depth - 20, obj_fireworks);
                            instance_create_depth(546, 360, depth - 20, obj_fireworks);
                        }
                    }
                    if (boxBounceTime < 30)
                    {
                        draw_sprite(spr_gacha_pulse, image_index / 2, itemBoxContainer[0] + 100, itemBoxContainer[1] + 202);
                    }
                    else if (boxBounceTime > 90)
                    {
                        draw_sprite(hud_getBoxBouncing, image_index / 5.4, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
                    }
                }
            }
            else if (boxItemAmount == 3)
            {
                if (boxBounceTime < 91)
                {
                    draw_sprite(hud_getBoxFallIn, image_index / 3, itemBoxContainer[0] + 140, itemBoxContainer[1] + 183);
                    draw_sprite(hud_getBoxFallIn, 8 + (image_index / 3), itemBoxContainer[0] + 60, itemBoxContainer[1] + 195);
                    draw_sprite(hud_getBoxClosed, 0, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
                }
                else if (boxBounceTime > 90)
                {
                    if (boxBounceTime < 100)
                    {
                        draw_sprite(hud_getBoxClosed, 0, itemBoxContainer[0] + 140, itemBoxContainer[1] + 183);
                    }
                    else
                    {
                        draw_sprite(hud_getBoxBouncing, -2 + (image_index / 5.4), itemBoxContainer[0] + 140, itemBoxContainer[1] + 183);
                    }
                    if (boxBounceTime < 110)
                    {
                        draw_sprite(hud_getBoxClosed, 0, itemBoxContainer[0] + 60, itemBoxContainer[1] + 195);
                    }
                    else
                    {
                        draw_sprite(hud_getBoxBouncing, -1 + (image_index / 5.4), itemBoxContainer[0] + 60, itemBoxContainer[1] + 195);
                    }
                    draw_sprite(hud_getBoxBouncing, image_index / 5.4, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
                }
            }
            break;
        case 2:
            if (boxItemAmount == 3)
            {
                draw_sprite(hud_getBoxOpen, image_index / 5.5, itemBoxContainer[0] + 140, itemBoxContainer[1] + 183);
                draw_sprite(hud_getBoxOpen, image_index / 5.5, itemBoxContainer[0] + 60, itemBoxContainer[1] + 195);
            }
            draw_sprite(hud_getBoxOpen, image_index / 5.5, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
            boxOpenTime++;
            break;
        case 3:
            if (boxItemAmount == 3)
            {
                draw_sprite(hud_getBoxOpenned, 0, itemBoxContainer[0] + 140, itemBoxContainer[1] + 183);
                draw_sprite(hud_getBoxOpenned, 0, itemBoxContainer[0] + 60, itemBoxContainer[1] + 195);
            }
            draw_sprite(hud_getBoxOpenned, 0, itemBoxContainer[0] + 100, itemBoxContainer[1] + 222);
            break;
    }
    if (boxOpenned)
    {
        commandPromps(true, true, false);
        var spark = instance_create_depth(((itemBoxContainer[0] + 100) - 40) + random(80), itemBoxContainer[1] + 172, depth - 30, obj_sparkle);
        spark.hspeed = 0;
        spark.vspeed = -1;
        spark.gravity = 0;
        spark.image_xscale = 0.2;
        spark.image_yscale = 0.2;
        spark.alarm[0] = 45 + floor(random(10));
        if (superBox)
        {
            spark = instance_create_depth(itemBoxContainer[0] + 100, itemBoxContainer[1] + 80, depth - 30, obj_sparkle);
            spark.direction = irandom(359);
            spark.speed = 2;
            spark.gravity = 0;
            spark.image_xscale = 0.4;
            spark.image_yscale = 0.4;
            spark.alarm[0] = 45 + floor(random(10));
        }
        if (boxItemAmount == 1)
        {
            draw_sprite(randomWeapon[0].optionIcon, 0, itemBoxContainer[0] + 100, itemBoxContainer[1] + 80);
        }
        if (boxItemAmount == 3)
        {
            draw_sprite(randomWeapon[0].optionIcon, 0, itemBoxContainer[0] + 100, itemBoxContainer[1] + 120);
            draw_sprite(randomWeapon[1].optionIcon, 0, itemBoxContainer[0] + 50, itemBoxContainer[1] + 60);
            draw_sprite(randomWeapon[2].optionIcon, 0, itemBoxContainer[0] + 150, itemBoxContainer[1] + 60);
        }
        var ttContainer = [127, 285];
        draw_sprite(ui_menu_upgrade_window_selected, 0, ttContainer[0], ttContainer[1]);
        DrawOption(ttContainer[0], ttContainer[1], randomWeapon[currentBoxItem]);
        draw_sprite(spr_holoCursor, image_index / 4, itemBoxContainer[0] + 240, itemBoxContainer[1] + 100 + (itemBoxTakeOption * 35));
        draw_set_halign(fa_center);
        draw_set_font(Galmuri9);
        if (itemBoxTakeOption == 0)
        {
            draw_set_color(c_black);
            draw_sprite(hud_confirmButton, 0, itemBoxContainer[0] + 300, itemBoxContainer[1] + 100);
        }
        else
        {
            draw_set_color(c_white);
            draw_sprite(hud_unselectButton, 0, itemBoxContainer[0] + 300, itemBoxContainer[1] + 100);
        }
        draw_text_scribble(itemBoxContainer[0] + 300, itemBoxContainer[1] + 94, global.TextContainer.itemTake.selectedLanguage);
        if (itemBoxTakeOption == 1)
        {
            draw_set_color(c_black);
            draw_sprite(hud_confirmButton, 0, itemBoxContainer[0] + 300, itemBoxContainer[1] + 135);
        }
        else
        {
            draw_set_color(c_white);
            draw_sprite(hud_unselectButton, 0, itemBoxContainer[0] + 300, itemBoxContainer[1] + 135);
        }
        draw_text_scribble(itemBoxContainer[0] + 300, itemBoxContainer[1] + 129, global.TextContainer.itemDrop.selectedLanguage);
        for (var i = 0; i < 2; i++)
        {
            if (MouseOverButton("short", itemBoxContainer[0] + 300, itemBoxContainer[1] + 100 + (i * 35)))
            {
                if (obj_InputManager.MouseMoved() && itemBoxTakeOption != i)
                {
                    itemBoxTakeOption = i;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                ClickButton();
            }
        }
    }
    if (boxOpenned && superLit > 0)
    {
        superLit -= 1;
        draw_set_alpha(0.7 * (superLit / 80));
        draw_rectangle_color(0, 0, 800, 600, c_white, c_white, c_white, c_white, 0);
        draw_set_alpha(1);
    }
    if (!boxOpenned)
    {
        ClickButton();
    }
}
if (paused && gotAnvil)
{
    if (!enhancing && !enhanceDone)
    {
        commandPromps(true, true, true);
    }
    if (enhanceDone)
    {
        commandPromps(true, true, false);
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_outline(anvilContainer[0] + 192, (anvilContainer[1] + 17) - 50, "UPGRADE!", 2, 0, 16, 4, 200, 16777215, 1);
    if (anvilContainer[0] != 230)
    {
        anvilContainer[0] -= 80;
    }
    if (anvilContainer[0] < 230)
    {
        anvilContainer[0] = 230;
    }
    noMain = ds_map_create();
    ds_map_copy(noMain, playerSnapshot.attacks);
    ds_map_delete(noMain, global.charSelected.attackID);
    size = ds_map_size(noMain);
    key = ds_map_find_first(noMain);
    if (!upgradeActionSelected)
    {
        loadOutList[0] = {};
        variable_struct_copy(ds_map_find_value(playerSnapshot.attacks, global.charSelected.attackID).config, loadOutList[0]);
        var currentLevel = loadOutList[0].level;
        var maxLevel = loadOutList[0].maxLevel;
        var enhancements = round(variable_struct_get(ds_map_find_value(playerSnapshot.attacks, global.charSelected.attackID).config, "enhancements"));
        if (currentLevel > 0 && currentLevel < maxLevel)
        {
            validLevelOptions[0] = true;
        }
        else
        {
            validLevelOptions[0] = true;
            loadOutList[0].optionName = string(loadOutList[0].levels[currentLevel - 2].config.optionName);
            var enhanceDesc = 
            {
                eng: "Enhance further to increase base damage by [c_green]" + string(2 + (global.enhancementBuff * 10)) + "[/color].",
                jp: "무기를 강화하여 기본 공격력을 [c_green]" + obj_TextController.JPNumbers(string(2 + (global.enhancementBuff * 10))) + "[/color] 상승",
                Id: "Enhance lebih lagi untuk menambah damage dasar sebanyak [c_green]" + string(2 + (global.enhancementBuff * 10)) + "[/color]."
            };
            loadOutList[0].optionDescription = variable_struct_get(enhanceDesc, global.CurrentLanguage);
            loadOutList[0].enhancements = enhancements;
            loadOutList[0].level = currentLevel;
            loadOutList[0].maxLevel = maxLevel;
        }
    }
    for (var i = 0; i < size; i++)
    {
        if (key != undefined)
        {
            var lookup = ds_map_find_value(noMain, key);
            if (lookup.config.optionType != "Weapon" && lookup.config.optionType != "Collab" && lookup.config.optionType != "SuperCollab")
            {
                ds_map_delete(noMain, key);
            }
        }
        key = ds_map_find_next(noMain, key);
    }
    size = ds_map_size(noMain);
    key = ds_map_find_first(noMain);
    var names = ds_map_keys_to_array(noMain);
    for (var i = 1; i < (size + 1); i++)
    {
        if (!upgradeActionSelected)
        {
            if (key != undefined)
            {
                var lookup = ds_map_find_value(noMain, key);
                if (lookup.config.optionType == "Weapon" || lookup.config.optionType == "Collab" || lookup.config.optionType == "SuperCollab")
                {
                    var currentLevel = ds_map_find_value(noMain, key).config.level;
                    var maxLevel = ds_map_find_value(noMain, key).config.maxLevel;
                    var weaponStructCopy = {};
                    variable_struct_copy(lookup.config, weaponStructCopy);
                    var enhancements = round(variable_struct_get(ds_map_find_value(playerSnapshot.attacks, key).config, "enhancements"));
                    if (currentLevel > 0 && currentLevel < maxLevel)
                    {
                        validLevelOptions[i] = true;
                    }
                    else
                    {
                        validLevelOptions[i] = true;
                        if (weaponStructCopy.maxLevel != 1)
                        {
                            weaponStructCopy.optionName = string(weaponStructCopy.levels[currentLevel - 2].config.optionName);
                        }
                        else
                        {
                            weaponStructCopy.optionName = string(weaponStructCopy.optionName);
                        }
                        var enhanceDesc = 
                        {
                            eng: "Enhance further to increase base damage by [c_green]" + string(2 + (global.enhancementBuff * 10)) + "[/color].",
                            jp: "무기를 강화하여 기본 공격력을 [c_green]" + obj_TextController.JPNumbers(string(2 + (global.enhancementBuff * 10))) + "[/color] 상승",
                            Id: "Enhance lebih lagi untuk menambah damage dasar sebanyak [c_green]" + string(2 + (global.enhancementBuff * 10)) + "[/color]."
                        };
                        weaponStructCopy.optionDescription = variable_struct_get(enhanceDesc, global.CurrentLanguage);
                        weaponStructCopy.enhancements = enhancements;
                        weaponStructCopy.level = currentLevel;
                        weaponStructCopy.maxLevel = maxLevel;
                    }
                    loadOutList[i] = weaponStructCopy;
                }
            }
        }
        key = ds_map_find_next(noMain, key);
    }
    ds_map_destroy(noMain);
    noMain = -1;
    for (var i = 0; i < 6; i++)
    {
        if (loadOutList[i] != -1)
        {
            draw_sprite_ext(loadOutList[i].optionIcon, 0, anvilContainer[0] + 81 + (i * 45), anvilContainer[1] + 30, 1, 1, 0, c_white, 0.5 + (0.5 * validLevelOptions[i]));
        }
        draw_sprite(hud_optionIconCase, 0, anvilContainer[0] + 81 + (i * 45), anvilContainer[1] + 30);
        draw_sprite(hud_optionIconCase, 0, anvilContainer[0] + 81 + (i * 45), anvilContainer[1] + 80);
        if (!anvilOptionSelected)
        {
            for (var j = 0; j < 2; j++)
            {
                if (MouseOverButton("itemCase", anvilContainer[0] + 81 + (i * 45), anvilContainer[1] + 30 + (50 * j)))
                {
                    if (obj_InputManager.MouseMoved() && anvilOption != (i + (j * 6)))
                    {
                        anvilOption = i + (j * 6);
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    ClickButton();
                }
            }
        }
    }
    size2 = array_length(variable_struct_get_names(items));
    itemKeys = variable_struct_get_names(items);
    for (var i = 0; i < size2; i++)
    {
        var anItem = itemKeys[i];
        if (ds_map_find_value(ITEMS, anItem) != undefined)
        {
            if (!upgradeActionSelected)
            {
                var lookup = ds_map_find_value(ITEMS, anItem);
                var currentLevel = lookup.level + 1;
                var maxLevel = lookup.maxLevel;
                var itemStructCopy = {};
                variable_struct_copy(lookup, itemStructCopy);
                if (currentLevel < maxLevel)
                {
                    validLevelOptions[i + 6] = true;
                }
                else
                {
                    validLevelOptions[i + 6] = false;
                }
                loadOutList[i + 6] = itemStructCopy;
                loadOutList[i + 6].enhancements = 0;
            }
            draw_sprite_ext(ds_map_find_value(ITEMS, anItem).optionIcon, 0, anvilContainer[0] + 81 + (i * 45), anvilContainer[1] + 80, 1, 1, 0, c_white, 0.5 + (0.5 * validLevelOptions[i + 6]));
        }
    }
    draw_sprite(hud_caseSelect, 0, anvilContainer[0] + 81 + ((anvilOption % 6) * 45), anvilContainer[1] + 30 + ((anvilOption div 6) * 50));
    if (!enhancing && upgradeOption == 0 && anvilOptionSelected)
    {
        draw_sprite(ui_menu_upgrade_window_selected, 0, anvilContainer[0], anvilContainer[1] + 110);
        if (loadOutList[anvilOption] != -1 && validLevelOptions[anvilOption])
        {
            if (anvilOption < 6 && loadOutList[anvilOption].level < loadOutList[anvilOption].maxLevel)
            {
                loadOutList[anvilOption].optionName = loadOutList[anvilOption].levels[loadOutList[anvilOption].level - 1].config.optionName;
                loadOutList[anvilOption].optionDescription = loadOutList[anvilOption].levels[loadOutList[anvilOption].level - 1].config.optionDescription;
            }
            else if (anvilOption < 6 && loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel)
            {
                var enhancements = round(variable_struct_get(ds_map_find_value(playerSnapshot.attacks, loadOutList[anvilOption].optionID).config, "enhancements"));
                loadOutList[anvilOption].enhancements = enhancements + 1;
            }
            else if (anvilOption > 5)
            {
                loadOutList[anvilOption].optionDescription = loadOutList[anvilOption].alloptionDescription[loadOutList[anvilOption].level + 1];
            }
            DrawOption(anvilContainer[0], anvilContainer[1] + 110, loadOutList[anvilOption], true, true);
        }
    }
    else if (!enhancing && upgradeOption == 1 && anvilOptionSelected)
    {
        draw_sprite(ui_menu_upgrade_window_selected, 0, anvilContainer[0], anvilContainer[1] + 110);
        if (loadOutList[anvilOption] != -1 && validLevelOptions[anvilOption])
        {
            DrawOption(anvilContainer[0], anvilContainer[1] + 110, loadOutList[anvilOption], false, false, 0, true);
        }
    }
    else if (!enhancing && !upgradeActionSelected && !anvilOptionSelected)
    {
        draw_sprite(ui_menu_upgrade_window_selected, 0, anvilContainer[0], anvilContainer[1] + 110);
        if (loadOutList[anvilOption] != -1 && validLevelOptions[anvilOption])
        {
            DrawOption(anvilContainer[0], anvilContainer[1] + 110, loadOutList[anvilOption]);
        }
    }
    if (anvilOptionSelected && !upgradeActionSelected)
    {
        for (var i = 0; i < min(2, 1 + ds_map_find_value(global.PlayerSave, "enchantments")); i++)
        {
            var canEnchant = (upgradeOption == 0 && i == 0) || (anvilOption > 0 && anvilOption < 6);
            draw_sprite_ext(hud_LevelButton, upgradeOption == i, anvilContainer[0] + 192, anvilContainer[1] + 185 + (i * 30), 1, 1, 0, c_white, (canEnchant * 0.5) + 0.5);
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            draw_set_color(selectedColor[upgradeOption == i]);
            draw_set_alpha((canEnchant * 0.5) + 0.5);
            draw_text_scribble(anvilContainer[0] + 195, anvilContainer[1] + 190 + (i * 30), global.TextContainer.anvilUpgrade.selectedLanguage[i]);
            draw_set_alpha(1);
            if (MouseOverButton("levelButton", anvilContainer[0] + 192, anvilContainer[1] + 185 + (i * 30)))
            {
                if (obj_InputManager.MouseMoved() && upgradeOption != i && anvilOption != 0)
                {
                    upgradeOption = i;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                if (!(anvilOption == 0 && i == 1))
                {
                    ClickButton();
                }
            }
        }
    }
    var successChance = 99;
    if (loadOutList[anvilOption] != -1 && upgradeOption == 0)
    {
        if (loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel)
        {
            successChance = max(10, 99 - ((loadOutList[anvilOption].enhancements - 1) * 10)) + (ds_map_find_value(global.PlayerSave, "enhanceUp") * 3);
        }
    }
    if (anvilOptionSelected && !enhancing && upgradeActionSelected && upgradeOption == 0)
    {
        draw_sprite_ext(hud_OptionButton, 1, anvilContainer[0] + 192, anvilContainer[1] + 210, 1, 1, 0, c_white, 0.5 + (!enhancing * 0.5));
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_color(c_black);
        draw_text_scribble(anvilContainer[0] + 250, anvilContainer[1] + 218, "UPGRADE");
        draw_set_color(c_white);
        draw_text_scribble(anvilContainer[0] + 195, anvilContainer[1] + 193, global.TextContainer.anvilSuccessRate.selectedLanguage + string(successChance + 1) + "%");
        draw_set_halign(fa_left);
        draw_set_color(c_black);
        if (global.currentRunMoneyGained < floor(global.enhanceCostMultiplier * loadOutList[anvilOption].enhancements * 50 * (loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel)))
        {
            draw_set_color(c_red);
        }
        draw_text_scribble(anvilContainer[0] + 110, anvilContainer[1] + 218, "Cost:          " + string(floor(global.enhanceCostMultiplier * loadOutList[anvilOption].enhancements * 50 * (loadOutList[anvilOption].level == loadOutList[anvilOption].maxLevel))));
        draw_sprite(spr_holoCoin, 0, anvilContainer[0] + 110 + 55, anvilContainer[1] + 223);
        if (MouseOverButton("long", anvilContainer[0] + 192, anvilContainer[1] + 210))
        {
            ClickButton();
        }
    }
    if (anvilOptionSelected && !enhancing && upgradeActionSelected && upgradeOption == 1)
    {
        draw_sprite_ext(hud_OptionButton, 1, anvilContainer[0] + 192, anvilContainer[1] + 210, 1, 1, 0, c_white, 1);
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_color(c_black);
        draw_text_scribble(anvilContainer[0] + 250, anvilContainer[1] + 218, "ENCHANT");
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_set_color(c_black);
        if (global.currentRunMoneyGained < floor(global.enhanceCostMultiplier * 250))
        {
            draw_set_color(c_red);
        }
        draw_text_scribble(anvilContainer[0] + 110, anvilContainer[1] + 218, "Cost:          " + string(floor(global.enhanceCostMultiplier * 250)));
        draw_sprite(spr_holoCoin, 0, anvilContainer[0] + 110 + 55, anvilContainer[1] + 223);
        if (MouseOverButton("long", anvilContainer[0] + 192, anvilContainer[1] + 210) && anvilOption != 0)
        {
            ClickButton();
        }
    }
    if (enhancing)
    {
        draw_sprite(hud_getBoxWindow, 0, 215, 40);
        draw_sprite(loadOutList[anvilOption].optionIcon, 0, 320 + ((-5 + random(10)) * (enhancingTime < 80)), 160 + ((-5 + random(10)) * (enhancingTime < 80)));
        var weaponResult = {};
        if (enhancingTime < 80)
        {
            enhancingTime++;
            draw_sprite(spr_charging, image_index / 2, 320, 160);
        }
        if (enhancingTime == 80)
        {
            enhancingTime = 81;
            enhanceDone = true;
            var roll = irandom(99);
            if (roll <= successChance)
            {
                enhanceResult = true;
                audio_play_sound(snd_anvil, 30, 0);
                if (loadOutList[anvilOption].enhancements == 10)
                {
                    DoAchievement("payToWin");
                }
            }
            else
            {
                enhanceResult = false;
                audio_play_sound(snd_failed, 30, 0);
                if (trueRNGcounter == 4)
                {
                    DoAchievement("trueRNG");
                }
                else
                {
                    trueRNGcounter++;
                }
                if (loadOutList[anvilOption].enhancements == 2)
                {
                    DoAchievement("justRNG");
                }
            }
            if (enhanceResult)
            {
                for (var i = 0; i < 5; i++)
                {
                    var beam = instance_create_depth(320, 160, depth - 1, obj_itemLightBeam);
                    beam.image_angle = i * 72;
                }
                for (var i = 0; i < 150; i++)
                {
                    var spark = instance_create_depth(320, 160, depth - 30, obj_sparkle);
                    spark.hspeed = -8 + random(16);
                    spark.vspeed = -8 + random(16);
                    spark.gravity = 0.2;
                    spark.image_xscale = 1;
                    spark.image_yscale = 1;
                    spark.alarm[0] = 90 + floor(random(10));
                }
            }
        }
        if (enhancingTime > 80 && upgradeOption == 0)
        {
            var enhanceAdd = "";
            variable_struct_copy(loadOutList[anvilOption], weaponResult);
            if (enhanceResult)
            {
                enhanceAdd = string((weaponResult.enhancements - 1) * (2 + (global.enhancementBuff * 10))) + "  >>  ";
            }
            weaponResult.enhancements = loadOutList[anvilOption].enhancements - !enhanceResult;
            weaponResult.optionDescription = global.TextContainer.weaponStrength.selectedLanguage + enhanceAdd + string(weaponResult.enhancements * (2 + (global.enhancementBuff * 10))) + ".";
            draw_set_font(Galmuri14);
            draw_set_halign(fa_center);
            var resultText = "";
            if (enhanceResult)
            {
                resultText = global.TextContainer.enhanceSuccess.selectedLanguage;
            }
            else
            {
                resultText = global.TextContainer.enhanceFailed.selectedLanguage;
            }
            draw_text_outline(320, 57, resultText, 2, 0, 16, 4, 200, 16777215, 1);
            draw_sprite(hud_confirmButton, 0, 320, 240);
            draw_set_font(Galmuri9);
            draw_set_color(c_black);
            draw_text_scribble(320, 235, "OK");
            draw_sprite(ui_menu_upgrade_window_selected, 0, 127, 285);
            DrawOption(127, 285, weaponResult, false, true);
        }
        else if (enhancingTime > 80 && upgradeOption == 1)
        {
            variable_struct_copy(loadOutList[anvilOption], weaponResult);
            draw_set_font(Galmuri14);
            draw_set_halign(fa_center);
            var resultText = "";
            resultText = global.TextContainer.enhanceSuccess.selectedLanguage;
            draw_text_outline(320, 57, resultText, 2, 0, 16, 4, 200, 16777215, 1);
            draw_sprite(hud_confirmButton, 0, 320, 240);
            draw_set_font(Galmuri9);
            draw_set_color(c_black);
            draw_text_scribble(320, 235, "OK");
            draw_sprite(ui_menu_upgrade_window_selected, 0, 127, 285);
            weaponResult.optionDescription = global.TextContainer.enchantSuccess.selectedLanguage;
            DrawOption(127, 285, weaponResult, false, false);
        }
        if (enhanceDone)
        {
            if (MouseOverButton("short", 320, 240))
            {
                ClickButton();
            }
        }
    }
}
if (paused && !gotSticker && !gotBox && !leveled && perksMenu && !gameOvered && !gameWon && !reviving)
{
    commandPromps(false, false, true);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    keys = variable_struct_get_names(perks);
    draw_set_font(Galmuri14);
    draw_text_outline(380, 45, "SKILLS", 2, 0, 16, 4, 200, 16777215, 1);
    draw_set_font(Galmuri9);
    if (array_length(keys) == 0)
    {
        draw_text_scribble(240, 100, global.TextContainer.noSkills.selectedLanguage);
    }
    else
    {
        for (var i = 0; i < array_length(keys); i++)
        {
            var k = keys[i];
            var v = variable_struct_get(perks, k);
            draw_sprite(ui_menu_skill_window, 0, 220, 80 + (i * 70));
            if (skillSelect == i)
            {
                draw_sprite(spr_holoCursor, image_index / 4, 210, 116 + (i * 70));
                selectingSkill = v;
            }
            DrawOption(220, 80 + (i * 70), v, false, false, i);
            if (MouseOverButton("fullOption", 220, 80 + (i * 70)))
            {
                if (i != skillSelect && obj_InputManager.MouseMoved())
                {
                    skillSelect = i;
                    textPage = 0;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
    }
}
if (paused && !gotSticker && !gotBox && !leveled && collabsMenu && !gameOvered && !gameWon && !reviving && !perksMenu)
{
    commandPromps(false, false, true);
    draw_set_color(c_white);
    draw_set_halign(fa_left);
    draw_set_font(Galmuri14);
    draw_text_outline(380, 45, "COLLABS", 2, 0, 16, 4, 200, 16777215, 1);
    draw_set_halign(fa_center);
    noMain = ds_map_create();
    ds_map_copy(noMain, playerSnapshot.attacks);
    ds_map_delete(noMain, global.charSelected.attackID);
    size = ds_map_size(noMain);
    key = ds_map_find_first(noMain);
    var attacksArray = [];
    size = ds_map_size(noMain);
    key = ds_map_find_first(noMain);
    for (var i = 0; i < size; i++)
    {
        if (key != undefined)
        {
            array_push(attacksArray, ds_map_find_value(noMain, key).config.attackID);
        }
        key = ds_map_find_next(noMain, key);
    }
    for (var i = 0; (i + (collabsStartingIndex * 4)) < array_length(global.seenCollabs); i++)
    {
        if ((i + (collabsStartingIndex * 4)) < ((collabsStartingIndex * 4) + 4) && (i + (collabsStartingIndex * 4)) >= (collabsStartingIndex * 4))
        {
            draw_sprite(global.seenCollabs[i + (collabsStartingIndex * 4)].optionIcon, 0, 300, 120 + (67 * (i % 4)));
            draw_sprite(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[0]).config.optionIcon, 0, 450, 120 + (67 * (i % 4)));
            if (!is_undefined(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1])))
            {
                draw_sprite(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1]).config.optionIcon, 0, 550, 120 + (67 * (i % 4)));
            }
            else
            {
                draw_sprite(ds_map_find_value(global.itemsLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1]).optionIcon, 0, 550, 120 + (67 * (i % 4)));
            }
            draw_set_font(Galmuri14);
            draw_text_scribble(375, 107 + (67 * (i % 4)), " = ");
            draw_text_scribble(500, 107 + (67 * (i % 4)), " + ");
            draw_set_font(Galmuri9);
            var collab = ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].attackID);
            draw_text_scribble(300, (120 + (67 * (i % 4))) - 35, collab.config.optionName);
            var attackName1 = ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[0]).config.optionName;
            var matchColor = 16777215;
            var matchColor2 = 16777215;
            if (array_exists(attacksArray, ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[0]).config.attackID))
            {
                matchColor = 65535;
            }
            if (!is_undefined(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1])))
            {
                if (array_exists(attacksArray, ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1]).config.attackID))
                {
                    matchColor2 = 65535;
                }
            }
            else
            {
                var itemsArray = variable_struct_get_names(items);
                if (array_exists(itemsArray, ds_map_find_value(global.itemsLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1]).optionID))
                {
                    matchColor2 = 65535;
                }
            }
            if (string_pos("LV", attackName1) > 0)
            {
                attackName1 = string_copy(attackName1, 0, string_pos("LV", attackName1) - 1);
            }
            var attackName2;
            if (!is_undefined(ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1])))
            {
                attackName2 = ds_map_find_value(global.attacksLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1]).config.optionName;
            }
            else
            {
                attackName2 = ds_map_find_value(global.itemsLibrary, global.seenCollabs[i + (collabsStartingIndex * 4)].combos[1]).optionName;
            }
            if (string_pos("LV", attackName2) > 0)
            {
                attackName2 = string_copy(attackName2, 0, string_pos("LV", attackName2) - 1);
            }
            draw_set_color(matchColor);
            draw_text_scribble(450, (120 + (67 * (i % 4))) - 35, attackName1);
            draw_set_color(matchColor2);
            draw_text_scribble(550, (120 + (67 * (i % 4))) - 35, attackName2);
            draw_sprite(hud_optionIconCase, 0, 300, 120 + (67 * (i % 4)));
            if (matchColor == 65535)
            {
                draw_sprite(hud_caseSelect, 0, 450, 120 + (67 * (i % 4)));
            }
            else
            {
                draw_sprite(hud_optionIconCase, 0, 450, 120 + (67 * (i % 4)));
            }
            if (matchColor2 == 65535)
            {
                draw_sprite(hud_caseSelect, 0, 550, 120 + (67 * (i % 4)));
            }
            else
            {
                draw_sprite(hud_optionIconCase, 0, 550, 120 + (67 * (i % 4)));
            }
        }
        draw_set_color(c_white);
    }
    draw_text_scribble(610, 320, string(collabsStartingIndex + 1) + " / " + string(max(1, ((array_length(global.seenCollabs) - 1) div 4) + 1)));
    ds_map_destroy(noMain);
    noMain = -1;
}
var keys = [];
var playerStruct;
if (instance_exists(playerCharacter))
{
    playerStruct = playerCharacter;
}
else
{
    playerStruct = playerSnapshot;
}
keys = variable_struct_get_names(playerStruct.buffs);
var noDisplays = 0;
for (var i = 0; i < array_length(keys); i++)
{
    var buffName = keys[i];
    var buff = variable_struct_get(playerStruct.buffs, buffName);
    draw_set_alpha(0.8);
    if (!variable_struct_exists(buff.config, "noDisplay"))
    {
        draw_sprite(ui_skilliconback, 0, 25 + ((i - noDisplays) * 28), 335);
        if (variable_struct_exists(buff.config, "buffIcon"))
        {
            draw_sprite(buff.config.buffIcon, 0, 25 + ((i - noDisplays) * 28), 335);
        }
        else if (ds_map_exists(PERKS, buffName))
        {
            draw_sprite(ds_map_find_value(PERKS, buffName).optionIcon, 0, 25 + ((i - noDisplays) * 28), 335);
        }
        else if (ds_map_exists(ITEMS, buffName))
        {
            draw_sprite(ds_map_find_value(ITEMS, buffName).optionIcon, 0, 25 + ((i - noDisplays) * 28), 335);
        }
        if (variable_struct_exists(buff.config, "stacks"))
        {
            draw_set_halign(fa_right);
            draw_set_color(c_white);
            draw_set_font(buffFont);
            draw_set_alpha(1);
            draw_text_scribble(36 + ((i - noDisplays) * 28), 342, buff.config.stacks);
        }
        if (variable_struct_exists(buff, "timer"))
        {
            if (buff.timer > 0)
            {
                var timeString = "";
                draw_set_halign(fa_center);
                if (buff.timer >= 3600)
                {
                    var mins = string(buff.timer div 3600);
                    timeString = mins + "m";
                }
                else
                {
                    timeString = string(floor(buff.timer / 60));
                }
                if (buff.timer < 240)
                {
                    draw_set_color(c_yellow);
                }
                else
                {
                    draw_set_color(c_white);
                }
                draw_set_font(buffFont_tiny2);
                draw_set_alpha(1);
                draw_text_scribble(25 + ((i - noDisplays) * 28), 350, timeString);
            }
        }
    }
    else
    {
        noDisplays++;
    }
}
selectedColor = [16777215, 0];
if (gameOvered)
{
    if (dankTime < 60)
    {
        dankTime++;
    }
    if (gameOverTime < 330)
    {
        gameOverTime++;
    }
    draw_set_color(c_black);
    draw_set_alpha((dankTime / 60) * 0.5);
    draw_rectangle(0, 0, 1000, 1000, false);
    draw_set_alpha(1);
    if (gameOverTextContainer[1] < 90)
    {
        gameOverTextContainer[1] += 0.8;
    }
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_outline(gameOverTextContainer[0], gameOverTextContainer[1], "GAME OVER", 1, 0, 32, 4, 400, 16777215, 1);
    if (gameOverTime < 330)
    {
        ClickButton();
    }
    else if (gameOverTime >= 330)
    {
        commandPromps(true, true, false);
        gameOverTextContainer[1] = 90;
        var canSubmitScore = CanSubmitScore();
        var gameOverOptions = UnknownEnum.Value_4;
        if (!canSubmitScore)
        {
            gameOverOptions--;
        }
        draw_set_font(Galmuri9);
        for (var i = 0; i < gameOverOptions; i++)
        {
            draw_sprite_ext(hud_initButtons, pauseOption == i, 320, 186 + (i * 34), 1, 1, 0, c_white, 0.5 + canControl);
            draw_set_halign(fa_center);
            if (i != UnknownEnum.Value_3)
            {
                draw_text_color(320, 195 + (i * 34), global.TextContainer.GOOptions.selectedLanguage[i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], 1);
            }
            else
            {
                var showOverwriteDaily = overwriteDaily && !submitScoreError;
                var submitScoreText = "";
                if (postingScore)
                {
                    submitScoreText = global.TextContainer.SubmitScoreText.selectedLanguage[5];
                    submitScoreText += EllipsisString();
                }
                else if (showOverwriteDaily)
                {
                    submitScoreText = global.TextContainer.SubmitScoreText.selectedLanguage[0];
                }
                else
                {
                    submitScoreText = global.TextContainer.GOOptions.selectedLanguage[i];
                }
                draw_text_color(320, 195 + (i * 34), submitScoreText, selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], 1);
                if (showOverwriteDaily && pauseOption == i)
                {
                    draw_set_color(c_white);
                    draw_text_scribble(320, 195 + ((i + 1) * 34), global.TextContainer.SubmitScoreText.selectedLanguage[1]);
                }
                var textOffset = (pauseOption == i) ? 15 : 0;
                switch (localScoreResult)
                {
                    case UnknownEnum.Value_0:
                        break;
                    case UnknownEnum.Value_1:
                        draw_set_halign(fa_left);
                        draw_text_color(400 + textOffset, 195 + (i * 34), global.TextContainer.SubmitScoreText.selectedLanguage[2], c_yellow, c_yellow, c_yellow, c_yellow, 1);
                        break;
                    case UnknownEnum.Value_2:
                        draw_set_halign(fa_left);
                        draw_text_color(400 + textOffset, 195 + (i * 34), global.TextContainer.SubmitScoreText.selectedLanguage[3], c_yellow, c_yellow, c_yellow, c_yellow, 1);
                        break;
                }
            }
            draw_set_halign(fa_center);
            if (MouseOverButton("long", 320, 186 + (i * 34)))
            {
                if (obj_InputManager.MouseMoved() && pauseOption != i)
                {
                    audio_play_sound(snd_menu_select, 30, 0);
                    pauseOption = i;
                }
                ClickButton();
            }
        }
        if (submitScoreError)
        {
            draw_set_halign(fa_center);
            draw_set_color(c_red);
            var submitErrorTextIndex = postScoreNetworkStatusOK ? 4 : 6;
            draw_text_scribble(320, 331, global.TextContainer.SubmitScoreText.selectedLanguage[submitErrorTextIndex]);
        }
        if (global.gameMode < 2)
        {
            draw_set_color(c_white);
            draw_text_scribble(320, 135, "점수: " + string(CalculateScore()));
            draw_set_color(c_yellow);
        }
        var haluBonus = "";
        if (haluBonusCoins > 0)
        {
            haluBonus = " + " + string(floor(haluBonusCoins)) + "(HALU BONUS)";
        }
        draw_text_scribble(320, 155, "획득한 Holo코인: " + string(floor(global.currentRunMoneyGained)) + haluBonus);
    }
}
if (gameWon)
{
    if (dankTime < 60)
    {
        dankTime++;
    }
    if (gameOverTime < 120)
    {
        gameOverTime++;
    }
    draw_set_color(c_black);
    draw_set_alpha((dankTime / 60) * 0.5);
    draw_rectangle(0, 0, 1000, 1000, false);
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_outline(320, 90, "STAGE COMPLETE!", 1, 0, 32, 4, 400, 16777215, 1);
    if (gameOverTime >= 120)
    {
        commandPromps(true, true, false);
        for (var i = 0; i < (3 + CanSubmitScore()); i++)
        {
            draw_sprite_ext(hud_initButtons, pauseOption == i, 320, 176 + (i * 34), 1, 1, 0, c_white, 0.5 + canControl);
        }
        draw_set_font(Galmuri9);
        for (var i = 0; i < (3 + CanSubmitScore()); i++)
        {
            draw_set_halign(fa_center);
            if (i != UnknownEnum.Value_3)
            {
                draw_text_color(320, 185 + (i * 34), global.TextContainer.GOOptions.selectedLanguage[i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], 1);
            }
            else if (CanSubmitScore())
            {
                var showOverwriteDaily = overwriteDaily && !submitScoreError;
                var submitScoreText = "";
                if (postingScore)
                {
                    submitScoreText = global.TextContainer.SubmitScoreText.selectedLanguage[5];
                    submitScoreText += EllipsisString();
                }
                else if (showOverwriteDaily)
                {
                    submitScoreText = global.TextContainer.SubmitScoreText.selectedLanguage[0];
                }
                else
                {
                    submitScoreText = global.TextContainer.GOOptions.selectedLanguage[i];
                }
                draw_text_color(320, 185 + (i * 34), submitScoreText, selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], selectedColor[pauseOption == i], 1);
                if (showOverwriteDaily && pauseOption == i)
                {
                    draw_set_color(c_white);
                    draw_text_scribble(320, 185 + ((i + 1) * 34), global.TextContainer.SubmitScoreText.selectedLanguage[1]);
                }
                var textOffset = (pauseOption == i) ? 15 : 0;
                switch (localScoreResult)
                {
                    case UnknownEnum.Value_0:
                        break;
                    case UnknownEnum.Value_1:
                        draw_set_halign(fa_left);
                        draw_text_color(400 + textOffset, 185 + (i * 34), global.TextContainer.SubmitScoreText.selectedLanguage[2], c_yellow, c_yellow, c_yellow, c_yellow, 1);
                        break;
                    case UnknownEnum.Value_2:
                        draw_set_halign(fa_left);
                        draw_text_color(400 + textOffset, 185 + (i * 34), global.TextContainer.SubmitScoreText.selectedLanguage[3], c_yellow, c_yellow, c_yellow, c_yellow, 1);
                        break;
                }
            }
            if (MouseOverButton("long", 320, 176 + (i * 34)))
            {
                if (obj_InputManager.MouseMoved() && pauseOption != i)
                {
                    audio_play_sound(snd_menu_select, 30, 0);
                    pauseOption = i;
                }
                ClickButton();
            }
        }
        if (global.gameMode < 2)
        {
            draw_set_color(c_white);
            draw_text_scribble(320, 135, "점수: " + string(CalculateScore()));
            draw_set_color(c_yellow);
            var haluBonus = "";
            if (haluBonusCoins > 0)
            {
                haluBonus = " + " + string(floor(haluBonusCoins)) + "(HALU BONUS)";
            }
            draw_text_scribble(320, 155, "획득한 Holo코인: " + string(floor(global.currentRunMoneyGained)) + haluBonus + " + " + string(winBonus) + "(승리 보너스)");
        }
        else
        {
            draw_set_halign(fa_center);
            draw_set_color(c_white);
            draw_set_font(Galmuri14);
            draw_text_scribble(320, 125, get_time());
            draw_set_color(c_yellow);
            draw_set_font(Galmuri9);
            draw_text_scribble(320, 160, "획득한 Holo코인: " + string(floor(global.currentRunMoneyGained)));
        }
    }
}
if (paused && gotGoldenAnvil)
{
    if (!collabing && !collabDone)
    {
        commandPromps(true, true, true);
    }
    if (collabDone)
    {
        commandPromps(true, true, false);
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_outline(anvilContainer[0] + 192, (anvilContainer[1] + 17) - 50, "COLLAB!", 2, 0, 16, 4, 200, 16777215, 1);
    if (anvilContainer[0] != 230)
    {
        anvilContainer[0] -= 80;
    }
    if (anvilContainer[0] < 230)
    {
        anvilContainer[0] = 230;
    }
    var validWeaponsArray = [];
    var collabs = variable_struct_get_names(availableWeaponCollabs);
    for (var i = 0; i < array_length(collabs); i++)
    {
        var check = variable_struct_get(availableWeaponCollabs, collabs[i]);
        array_push(validWeaponsArray, check[0]);
        array_push(validWeaponsArray, check[1]);
    }
    noMain = ds_map_create();
    ds_map_copy(noMain, playerSnapshot.attacks);
    ds_map_delete(noMain, global.charSelected.attackID);
    size = ds_map_size(noMain);
    key = ds_map_find_first(noMain);
    for (var i = 0; i < size; i++)
    {
        if (key != undefined)
        {
            var lookup = ds_map_find_value(noMain, key);
            if (lookup.config.optionType != "Weapon" && lookup.config.optionType != "Collab")
            {
                ds_map_delete(noMain, key);
            }
        }
        key = ds_map_find_next(noMain, key);
    }
    size = ds_map_size(noMain);
    key = ds_map_find_first(noMain);
    for (var i = 0; i < size; i++)
    {
        if (key != undefined)
        {
            var lookup = ds_map_find_value(noMain, key);
            if (lookup.config.optionType == "Weapon" || lookup.config.optionType == "Collab" || lookup.config.optionType == "SuperCollab")
            {
                var currentLevel = ds_map_find_value(noMain, key).config.level;
                var maxLevel = ds_map_find_value(noMain, key).config.maxLevel;
                var weaponStructCopy = {};
                variable_struct_copy(lookup.config, weaponStructCopy);
                if (currentLevel == maxLevel)
                {
                    validLevelOptions[i] = true;
                    if (goldenAnvilOptionSelected1 != -1)
                    {
                        if (goldenAnvilOptionSelected1.attackID == loadOutList[i].attackID)
                        {
                            validLevelOptions[i] = false;
                        }
                    }
                    if (goldenAnvilOptionSelected2 != -1)
                    {
                        if (goldenAnvilOptionSelected2.optionType == "Weapon")
                        {
                            if (goldenAnvilOptionSelected2.attackID == loadOutList[i].attackID)
                            {
                                validLevelOptions[i] = false;
                            }
                        }
                        else if (goldenAnvilOptionSelected2.optionType == "Item")
                        {
                            if (goldenAnvilOptionSelected2.optionType == "Weapon")
                            {
                                if (goldenAnvilOptionSelected2.id == loadOutList[i].id)
                                {
                                    validLevelOptions[i] = false;
                                }
                            }
                        }
                    }
                }
                loadOutList[i] = weaponStructCopy;
            }
        }
        key = ds_map_find_next(noMain, key);
    }
    ds_map_destroy(noMain);
    noMain = -1;
    for (var i = 0; i < 5; i++)
    {
        if (loadOutList[i] != -1)
        {
            draw_sprite_ext(loadOutList[i].optionIcon, 0, anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30, 1, 1, 0, c_white, 0.5 + (0.5 * validLevelOptions[i]));
        }
        draw_sprite(hud_optionIconCase, 0, anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30);
        if (MouseOverButton("itemCase", anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30) && (goldenAnvilOptionSelected1 == -1 || goldenAnvilOptionSelected2 == -1))
        {
            if (obj_InputManager.MouseMoved() && anvilOption != i)
            {
                anvilOption = i;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            ClickButton();
        }
    }
    if (anvilOption < 5)
    {
        draw_sprite(hud_caseSelect, 0, anvilContainer[0] + 101 + ((anvilOption % 5) * 45), anvilContainer[1] + 30 + ((anvilOption div 5) * 40));
    }
    for (var i = 0; i < 5; i++)
    {
        for (var j = 0; j < array_length(validWeaponsArray); j++)
        {
            if (loadOutList[i] != -1)
            {
                if (loadOutList[i].attackID == validWeaponsArray[j])
                {
                    draw_sprite_ext(spr_pulse, image_index / 3, anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30, 2, 2, 0, c_white, 1);
                }
            }
        }
    }
    if (superCollabShow)
    {
        for (var i = 0; i < 6; i++)
        {
            for (var j = 0; j < array_length(validWeaponsArray); j++)
            {
                if (loadOutList[i + 5] != -1)
                {
                    if (loadOutList[i + 5].id == validWeaponsArray[j])
                    {
                        draw_sprite_ext(spr_pulse, image_index / 3, anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30 + 40, 2, 2, 0, c_white, 1);
                    }
                }
            }
            if (MouseOverButton("itemCase", anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30 + 40) && (goldenAnvilOptionSelected1 == -1 || goldenAnvilOptionSelected2 == -1))
            {
                if (obj_InputManager.MouseMoved() && anvilOption != (i + 5))
                {
                    anvilOption = i + 5;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                ClickButton();
            }
        }
    }
    if (goldenAnvilOptionSelected1 != -1 && goldenAnvilOptionSelected1.optionType == "Collab")
    {
        size2 = array_length(variable_struct_get_names(items));
        itemKeys = variable_struct_get_names(items);
        for (var i = 0; i < size2; i++)
        {
            var anItem = itemKeys[i];
            if (ds_map_find_value(ITEMS, anItem) != undefined)
            {
                if (!goldenOptionSelected)
                {
                    var lookup = ds_map_find_value(ITEMS, anItem);
                    var currentLevel = lookup.level + 1;
                    var maxLevel = lookup.maxLevel;
                    var itemStructCopy = {};
                    variable_struct_copy(lookup, itemStructCopy);
                    if (currentLevel >= maxLevel)
                    {
                        validLevelOptions[i + 5] = true;
                    }
                    else
                    {
                        validLevelOptions[i + 5] = false;
                    }
                    loadOutList[i + 5] = itemStructCopy;
                    loadOutList[i + 5].enhancements = 0;
                }
                draw_sprite_ext(ds_map_find_value(ITEMS, anItem).optionIcon, 0, anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30 + 40, 1, 1, 0, c_white, 0.5 + (0.5 * validLevelOptions[i + 5]));
            }
        }
        for (var i = 0; i < 6; i++)
        {
            draw_sprite(hud_optionIconCase, 0, anvilContainer[0] + 101 + (i * 45), anvilContainer[1] + 30 + 40);
        }
        if (anvilOption >= 5)
        {
            draw_sprite(hud_caseSelect, 0, anvilContainer[0] + 101 + ((anvilOption - 5) * 45), anvilContainer[1] + 30 + 40);
        }
    }
    if (goldenAnvilOptionSelected1 != -1)
    {
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text_scribble((anvilContainer[0] + 192) - 50, (anvilContainer[1] + 130) - 30, string_replace(goldenAnvilOptionSelected1.optionName, " LV MAX", ""));
        draw_sprite_ext(goldenAnvilOptionSelected1.optionIcon, 0, (anvilContainer[0] + 192) - 50, anvilContainer[1] + 130, 1, 1, 0, c_white, 1);
    }
    if (goldenAnvilOptionSelected2 != -1)
    {
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        var getLevelString = string_copy(goldenAnvilOptionSelected2.optionName, 0, string_pos(" LV", goldenAnvilOptionSelected2.optionName));
        draw_text_scribble(anvilContainer[0] + 192 + 50, (anvilContainer[1] + 130) - 30, getLevelString);
        draw_sprite_ext(goldenAnvilOptionSelected2.optionIcon, 0, anvilContainer[0] + 192 + 50, anvilContainer[1] + 130, 1, 1, 0, c_white, 1);
    }
    draw_sprite(hud_optionIconCase, 0, (anvilContainer[0] + 192) - 50, anvilContainer[1] + 130);
    draw_sprite(hud_optionIconCase, 0, anvilContainer[0] + 192 + 50, anvilContainer[1] + 130);
    draw_set_font(Galmuri14);
    draw_text_scribble(anvilContainer[0] + 192, (anvilContainer[1] + 130) - 11, "+");
    if (goldenAnvilOptionSelected1 != -1 && goldenAnvilOptionSelected2 != -1 && !collabing)
    {
        var validCombo = false;
        var firstValid = false;
        var secondValid = false;
        collabs = variable_struct_get_names(availableWeaponCollabs);
        for (var i = 0; i < array_length(collabs); i++)
        {
            firstValid = false;
            secondValid = false;
            var check = variable_struct_get(availableWeaponCollabs, collabs[i]);
            if (superCollabShow)
            {
                if (check[0] == goldenAnvilOptionSelected1.attackID)
                {
                    firstValid = true;
                }
                if (goldenAnvilOptionSelected2.optionType == "Item")
                {
                    if (check[1] == goldenAnvilOptionSelected2.id)
                    {
                        secondValid = true;
                    }
                }
                else if (check[1] == goldenAnvilOptionSelected2.attackID)
                {
                    secondValid = true;
                }
            }
            else
            {
                if (check[0] == goldenAnvilOptionSelected1.attackID)
                {
                    firstValid = true;
                }
                else if (check[0] == goldenAnvilOptionSelected2.attackID)
                {
                    firstValid = true;
                }
                if (check[1] == goldenAnvilOptionSelected1.attackID)
                {
                    secondValid = true;
                }
                else if (check[1] == goldenAnvilOptionSelected2.attackID)
                {
                    secondValid = true;
                }
            }
            if (firstValid && secondValid)
            {
                validCombo = true;
                goldenOptionSelected = true;
                collabingWeapon = {};
                variable_struct_copy(variable_struct_get(weaponCollabs, collabs[i]).config, collabingWeapon);
                break;
            }
        }
        if (validCombo && goldenAnvilOptionSelected1.optionType == "Collab")
        {
            draw_set_font(Galmuri9);
            draw_sprite(spr_GoldenHammer, 0, anvilContainer[0] + 178, anvilContainer[1] + 165);
            if (global.goldenHammer < 1)
            {
                draw_set_color(c_red);
            }
            else
            {
                draw_set_color(c_white);
            }
            draw_text(anvilContainer[0] + 210, anvilContainer[1] + 157, "x 1");
            if (global.goldenHammer < 1)
            {
                validCombo = false;
            }
        }
        draw_sprite_ext(hud_OptionButton, 1, anvilContainer[0] + 192, anvilContainer[1] + 185, 1, 1, 0, c_white, 0.5 + (validCombo * 0.5));
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_color(c_black);
        draw_text_scribble(anvilContainer[0] + 192, anvilContainer[1] + 193, "COLLAB!");
        if (MouseOverButton("short", anvilContainer[0] + 192, anvilContainer[1] + 185) && !collabing)
        {
            ClickButton();
        }
    }
    if (collabing)
    {
        draw_set_alpha(1);
        draw_sprite_ext(hud_getBoxWindow, 0, 215, 40, 1, 1, 0, c_white, 1);
        if (collabingTime < 80)
        {
            draw_sprite(goldenAnvilOptionSelected1.optionIcon, 0, ((320 + ((-5 + random(10)) * (collabingTime < 80))) - 40) + (collabingTime / 2), 160 + ((-5 + random(10)) * (collabingTime < 80)));
            draw_sprite(goldenAnvilOptionSelected2.optionIcon, 0, (320 + ((-5 + random(10)) * (collabingTime < 80)) + 40) - (collabingTime / 2), 160 + ((-5 + random(10)) * (collabingTime < 80)));
        }
        if (collabingTime < 80)
        {
            collabingTime++;
            draw_sprite(spr_charging, image_index / 2, 320, 160);
        }
        if (collabingTime == 80)
        {
            collabingTime = 81;
            collabDone = true;
            collabResult = true;
            audio_play_sound(snd_anvil, 30, 0);
            if (collabResult)
            {
                for (var i = 0; i < 5; i++)
                {
                    var beam = instance_create_depth(320, 160, depth - 1, obj_itemLightBeam);
                    beam.image_angle = i * 72;
                }
                for (var i = 0; i < 150; i++)
                {
                    var spark = instance_create_depth(320, 160, depth - 30, obj_sparkle);
                    spark.hspeed = -8 + random(16);
                    spark.vspeed = -8 + random(16);
                    spark.gravity = 0.2;
                    spark.image_xscale = 1;
                    spark.image_yscale = 1;
                    spark.alarm[0] = 90 + floor(random(10));
                }
            }
        }
        if (collabingTime > 80)
        {
            draw_text_outline(320, 57, "COLLABORATION!", 2, 0, 16, 4, 200, 16777215, 1);
            draw_sprite(collabingWeapon.optionIcon, 0, 320, 160);
            draw_sprite(hud_confirmButton, 0, 320, 240);
            draw_set_font(Galmuri9);
            draw_set_color(c_black);
            draw_text_scribble(320, 235, "OK");
            draw_sprite(ui_menu_upgrade_window_selected, 0, 127, 285);
            if (array_length(collabingWeapon.gainedMods) == 0 && !superCollabShow)
            {
                if (array_length(goldenAnvilOptionSelected1.gainedMods) > 0)
                {
                    array_push(collabingWeapon.gainedMods, goldenAnvilOptionSelected1.gainedMods[0]);
                }
                if (array_length(goldenAnvilOptionSelected2.gainedMods) > 0)
                {
                    array_push(collabingWeapon.gainedMods, goldenAnvilOptionSelected2.gainedMods[0]);
                }
            }
            if (array_length(collabingWeapon.gainedMods) == 0 && superCollabShow)
            {
                if (array_length(goldenAnvilOptionSelected1.gainedMods) > 0)
                {
                    array_push(collabingWeapon.gainedMods, goldenAnvilOptionSelected1.gainedMods[0]);
                }
                if (array_length(goldenAnvilOptionSelected1.gainedMods) > 1)
                {
                    array_push(collabingWeapon.gainedMods, goldenAnvilOptionSelected1.gainedMods[1]);
                }
            }
            DrawOption(127, 285, collabingWeapon);
        }
        if (collabDone)
        {
            if (MouseOverButton("short", 320, 235))
            {
                ClickButton();
            }
        }
    }
}
if (paused && gotSticker)
{
    size = ds_map_size(playerSnapshot.attacks);
    key = ds_map_find_first(playerSnapshot.attacks);
    var mainWeapon = 0;
    for (var i = 0; i < size; i++)
    {
        if (key != undefined)
        {
            var lookup = ds_map_find_value(playerSnapshot.attacks, key);
            if (lookup.config.optionType == "Weapon")
            {
                if (lookup.config.isMain)
                {
                    mainWeapon = ds_map_find_value(playerSnapshot.attacks, key);
                    break;
                }
            }
        }
        key = ds_map_find_next(playerSnapshot.attacks, key);
    }
    if (stickerContainer[0] != 436)
    {
        stickerContainer[0] -= 80;
    }
    if (stickerContainer[0] < 436)
    {
        stickerContainer[0] = 436;
    }
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_outline(stickerContainer[0] + 5, (stickerContainer[1] + 14) - 65, "ATTACH!", 2, 0, 16, 4, 200, 16777215, 1);
    draw_sprite(spr_sticker_UI, 0, stickerContainer[0], stickerContainer[1]);
    draw_sprite(mainWeapon.config.optionIcon, 0, stickerContainer[0], stickerContainer[1]);
    draw_set_font(Galmuri9);
    draw_text_scribble(stickerContainer[0] - 165, stickerContainer[1] + 11, "Found!");
    if (global.collectedSticker != -1)
    {
        draw_sprite(global.collectedSticker.optionIcon, 0, stickerContainer[0] - 165, stickerContainer[1] + 47);
    }
    draw_sprite(ui_menu_upgrade_window_selected, 0, stickerContainer[0] - 191, stickerContainer[1] + 131);
    if (!stickerSelected)
    {
        if (global.collectedSticker != -1 && stickerOption == 0)
        {
            DrawOption(stickerContainer[0] - 191, stickerContainer[1] + 131, global.collectedSticker);
        }
        else if (stickerOption > 0 && stickerOption < 4 && global.currentStickers[stickerOption - 1] != -1)
        {
            DrawOption(stickerContainer[0] - 191, stickerContainer[1] + 131, global.currentStickers[stickerOption - 1]);
        }
        else if (stickerOption > 0 && stickerOption < 4)
        {
            var emptyDesc = 
            {
                optionName: "Empty Slot",
                optionIcon: 717,
                optionType: "Stamp",
                optionDescription: global.TextContainer.emptySticker.selectedLanguage
            };
            DrawOption(stickerContainer[0] - 191, stickerContainer[1] + 131, emptyDesc);
        }
    }
    else
    {
        var whichIcon = 0;
        var whichName = "";
        var whichDesc = "";
        if (global.collectedSticker != -1 && stickerOption == 0)
        {
            whichIcon = global.collectedSticker.optionIcon;
            whichName = global.collectedSticker.optionName;
        }
        else if (stickerOption > 0 && stickerOption < 4 && global.currentStickers[stickerOption - 1] != -1)
        {
            whichIcon = global.currentStickers[stickerOption - 1].optionIcon;
            whichName = global.currentStickers[stickerOption - 1].optionName;
        }
        else
        {
            whichIcon = global.collectedSticker.optionIcon;
            whichName = global.collectedSticker.optionName;
        }
        switch (stickerAction)
        {
            case 0:
                if (stickerOption > 0 && global.currentStickers[stickerOption - 1] != -1 && global.collectedSticker != -1)
                {
                    whichDesc = global.TextContainer.stickerActionDesc.selectedLanguage[2];
                }
                else
                {
                    whichDesc = global.TextContainer.stickerActionDesc.selectedLanguage[0];
                }
                break;
            case 1:
                whichDesc = global.TextContainer.stickerActionDesc.selectedLanguage[1];
                break;
            case 2:
                var theLevel = 0;
                if (stickerOption == 0)
                {
                    theLevel = global.collectedSticker.level + 1;
                }
                else
                {
                    theLevel = global.currentStickers[max(0, stickerOption - 1)].level + 1;
                }
                var actionSell = 
                {
                    eng: "Destroy this Stamp and gain " + string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain)) * theLevel) + " HoloCoins. This stamp will not drop again!",
                    jp: "スタンプを破壊しホロコイン" + string(obj_TextController.JPAS(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain)) * theLevel)) + "個手に入るがこのスタンプがドロップしなくなる。",
                    Id: "Hancurkan stamp ini dan mendapatkan " + string(floor(100 * global.stageCoinBonus * (1 + playerSnapshot.moneyGain)) * theLevel) + "HoloCoin, tetapi stamp ini tidak akan drop lagi."
                };
                whichDesc = variable_struct_get(actionSell, global.CurrentLanguage);
                break;
        }
        var actionDesc = 
        {
            optionName: whichName,
            optionIcon: whichIcon,
            optionType: "Stamp",
            optionDescription: whichDesc
        };
        if (stickerOption > 0 && stickerOption < 4 && stickerActionSelected && stickerAction == 0 && global.collectedSticker != -1 && global.currentStickers[stickerOption - 1] != -1)
        {
            actionDesc.strengthening = true;
            actionDesc.allDescription = global.currentStickers[stickerOption - 1].allDescription;
        }
        DrawOption(stickerContainer[0] - 191, stickerContainer[1] + 131, actionDesc);
    }
    draw_set_alpha(1);
    if (global.currentStickers[0] == -1 && global.collectedSticker != -1)
    {
        draw_sprite(hud_caseSelect_sticker_pulse, image_index / 3, stickerContainer[0] - 93, stickerContainer[1] + 101);
    }
    else if (global.currentStickers[0] != -1)
    {
        draw_sprite(global.currentStickers[0].optionIcon, 0, stickerContainer[0] - 93, stickerContainer[1] + 101);
    }
    if (global.currentStickers[1] == -1 && global.collectedSticker != -1)
    {
        draw_sprite(hud_caseSelect_sticker_pulse, image_index / 3, stickerContainer[0], stickerContainer[1] + 101);
    }
    else if (global.currentStickers[1] != -1)
    {
        draw_sprite(global.currentStickers[1].optionIcon, 0, stickerContainer[0], stickerContainer[1] + 101);
    }
    if (global.currentStickers[2] == -1 && global.collectedSticker != -1)
    {
        draw_sprite(hud_caseSelect_sticker_pulse, image_index / 3, stickerContainer[0] + 96, stickerContainer[1] + 101);
    }
    else if (global.currentStickers[2] != -1)
    {
        draw_sprite(global.currentStickers[2].optionIcon, 0, stickerContainer[0] + 96, stickerContainer[1] + 101);
    }
    switch (stickerOption)
    {
        case 0:
            draw_sprite(hud_caseSelect_sticker, 0, stickerContainer[0] - 166, stickerContainer[1] + 47);
            draw_sprite(spr_holoCursor, image_index / 4, stickerContainer[0] - 166 - 35, stickerContainer[1] + 47);
            break;
        case 1:
            draw_sprite(hud_caseSelect_sticker, 0, stickerContainer[0] - 93, stickerContainer[1] + 101);
            draw_sprite(spr_holoCursor, image_index / 4, stickerContainer[0] - 93 - 35, stickerContainer[1] + 101);
            break;
        case 2:
            draw_sprite(hud_caseSelect_sticker, 0, stickerContainer[0], stickerContainer[1] + 101);
            draw_sprite(spr_holoCursor, image_index / 4, stickerContainer[0] - 35, stickerContainer[1] + 101);
            break;
        case 3:
            draw_sprite(hud_caseSelect_sticker, 0, stickerContainer[0] + 96, stickerContainer[1] + 101);
            draw_sprite(spr_holoCursor, image_index / 4, (stickerContainer[0] + 96) - 35, stickerContainer[1] + 101);
            break;
    }
    if (!stickerSelected)
    {
        if (MouseOverButton("stampCase", stickerContainer[0] - 166, stickerContainer[1] + 47))
        {
            if (obj_InputManager.MouseMoved() && stickerOption != 0)
            {
                audio_play_sound(snd_menu_select, 30, 0);
                stickerOption = 0;
            }
            ClickButton();
        }
        if (MouseOverButton("stampCase", stickerContainer[0] - 93, stickerContainer[1] + 101))
        {
            if (obj_InputManager.MouseMoved() && stickerOption != 1)
            {
                audio_play_sound(snd_menu_select, 30, 0);
                stickerOption = 1;
            }
            ClickButton();
        }
        if (MouseOverButton("stampCase", stickerContainer[0], stickerContainer[1] + 101))
        {
            if (obj_InputManager.MouseMoved() && stickerOption != 2)
            {
                audio_play_sound(snd_menu_select, 30, 0);
                stickerOption = 2;
            }
            ClickButton();
        }
        if (MouseOverButton("stampCase", stickerContainer[0] + 96, stickerContainer[1] + 101))
        {
            if (obj_InputManager.MouseMoved() && stickerOption != 3)
            {
                audio_play_sound(snd_menu_select, 30, 0);
                stickerOption = 3;
            }
            ClickButton();
        }
        if (MouseOverButton("short", stickerContainer[0] + 155, stickerContainer[1] + 40))
        {
            if (obj_InputManager.MouseMoved() && stickerOption != 4)
            {
                audio_play_sound(snd_menu_select, 30, 0);
                stickerOption = 4;
            }
            ClickButton();
        }
    }
    if (stickerSelected && !stickerActionSelected)
    {
        for (var i = 0; i < 3; i++)
        {
            var availableActions = [false, false, false];
            stickerLineTime++;
            if (stickerLineTime == 60)
            {
                stickerLineTime = 0;
            }
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            if (stickerAction == i)
            {
                var available = 0;
                if (!(stickerOption > 0 && stickerOption < 4 && stickerAction == 0 && global.collectedSticker != -1 && global.currentStickers[stickerOption - 1] != -1 && global.currentStickers[stickerOption - 1].level == (global.currentStickers[stickerOption - 1].maxLevel - 1)))
                {
                    draw_set_alpha(1);
                    available = 1;
                }
                else
                {
                    draw_set_alpha(0.5);
                    available = 0.5;
                }
                draw_sprite_ext(hud_confirmButton, 0, (stickerContainer[0] - 88) + (i * 88), stickerContainer[1] + 218, 1, 1, 0, c_white, available);
                draw_set_color(c_black);
            }
            else
            {
                draw_set_color(c_white);
                var available = 0;
                switch (i)
                {
                    case 0:
                        if ((stickerOption == 0 && stickerOption < 4 && array_exists(global.currentStickers, -1)) || (stickerOption > 0 && stickerOption < 4 && global.currentStickers[stickerOption - 1] == -1) || (stickerOption > 0 && stickerOption < 4 && global.collectedSticker != -1 && global.currentStickers[stickerOption - 1].level < (global.currentStickers[stickerOption - 1].maxLevel - 1)))
                        {
                            available = 0.5;
                            availableActions[i] = true;
                        }
                        break;
                    case 1:
                        if (stickerOption > 0 && stickerOption < 4 && global.currentStickers[stickerOption - 1] != -1)
                        {
                            available = 0.5;
                            availableActions[i] = true;
                        }
                        break;
                    case 2:
                        if ((stickerOption > 0 && stickerOption < 4 && global.currentStickers[stickerOption - 1] != -1) || (stickerOption == 0 && global.collectedSticker != -1))
                        {
                            available = 0.5;
                            availableActions[i] = true;
                        }
                        break;
                }
                draw_set_alpha(0.5 + available);
                draw_sprite(hud_unselectButton, 0, (stickerContainer[0] - 88) + (i * 88), stickerContainer[1] + 218);
            }
            var whichAction = i;
            if (whichAction == 0)
            {
                whichAction += ((global.collectedSticker != -1 && stickerOption != 0 && global.currentStickers[stickerOption - 1] != -1) * 4);
            }
            if (whichAction == 1)
            {
                whichAction += ((global.collectedSticker == -1) * 2);
            }
            draw_text_scribble((stickerContainer[0] - 88) + (i * 88), stickerContainer[1] + 212, global.TextContainer.stickerActions.selectedLanguage[whichAction]);
            draw_set_alpha(1);
            if (MouseOverButton("short", (stickerContainer[0] - 88) + (i * 88), stickerContainer[1] + 218) && !stickerActionSelected)
            {
                if (obj_InputManager.MouseMoved() && stickerAction != i && availableActions[i])
                {
                    audio_play_sound(snd_menu_select, 30, 0);
                    stickerAction = i;
                }
                if (stickerAction == i)
                {
                    ClickButton();
                }
            }
            if (stickerAction == 0 || stickerAction == 1)
            {
                var selectedCoord = -1;
                var selectBox = -1;
                if (stickerOption == 0)
                {
                    var firstEmpty = -1;
                    for (var k = 0; k < 3; k++)
                    {
                        if (global.currentStickers[k] == -1)
                        {
                            firstEmpty = k + 1;
                            break;
                        }
                    }
                    if (firstEmpty > -1)
                    {
                        selectBox = firstEmpty;
                    }
                }
                else
                {
                    selectBox = stickerOption;
                }
                switch (selectBox)
                {
                    case 1:
                        selectedCoord = [stickerContainer[0] - 93, stickerContainer[1] + 101];
                        break;
                    case 2:
                        selectedCoord = [stickerContainer[0], stickerContainer[1] + 101];
                        break;
                    case 3:
                        selectedCoord = [stickerContainer[0] + 96, stickerContainer[1] + 101];
                        break;
                }
                if (selectedCoord != -1)
                {
                    draw_dotted_line(stickerContainer[0] - 136, stickerContainer[1] + 47, selectedCoord[0], selectedCoord[1] - 20, max(0, selectBox - 1) * 5, 5 + (max(0, selectBox - 1) * 3), stickerLineTime);
                    draw_sprite(spr_stickerArrow, 0, selectedCoord[0], selectedCoord[1] - 20);
                }
                if (stickerAction == 1)
                {
                    draw_sprite_ext(spr_stickerArrow, 0, stickerContainer[0] - 146, stickerContainer[1] + 47, 1, 1, -90, c_white, 1);
                }
            }
        }
    }
    else if (stickerActionSelected)
    {
        draw_sprite(hud_confirmButton, 0, stickerContainer[0], stickerContainer[1] + 218);
        draw_set_color(c_black);
        draw_set_halign(fa_center);
        draw_text_scribble(stickerContainer[0], stickerContainer[1] + 212, global.TextContainer.controllerButtons.selectedLanguage[6]);
        if (MouseOverButton("short", stickerContainer[0], stickerContainer[1] + 218))
        {
            ClickButton();
        }
    }
    if (stickerOption == 4)
    {
        draw_sprite(hud_confirmButton, 0, stickerContainer[0] + 155, stickerContainer[1] + 40);
        draw_set_color(c_black);
        draw_set_halign(fa_center);
    }
    else
    {
        draw_sprite(hud_unselectButton, 0, stickerContainer[0] + 155, stickerContainer[1] + 40);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
    }
    draw_text_scribble(stickerContainer[0] + 155, stickerContainer[1] + 34, global.TextContainer.stickerFinish.selectedLanguage);
}
if (paused && reviving)
{
    draw_set_halign(fa_center);
    draw_sprite(hud_confirmButton, 0, 320, 240);
    draw_set_font(Galmuri9);
    draw_set_color(c_black);
    draw_text_scribble(320, 235, "REVIVE");
    draw_set_color(c_yellow);
    draw_text_scribble(320, 150, "Revives Remaining: " + string(global.lives));
    if (MouseOverButton("short", 320, 240))
    {
        ClickButton();
    }
}
if (global.goldenHammerPieces > 0 && global.goldFlag)
{
    draw_set_alpha(0.1 + (0.3 * global.goldenHammerPieces));
    draw_sprite(spr_GoldenHammerPieces, global.goldenHammerPieces - 1, 620, 45);
    draw_set_alpha(1);
}
draw_set_font(Galmuri9);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_alpha(0.8);
draw_set_alpha(1);
if (!gameOvered && !gameWon)
{
    draw_set_alpha(blackFlash);
    depth = 0;
    draw_rectangle_colour(0, 0, 1000, 1000, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}
if (ds_map_find_value(global.PlayerSave, "firstTime"))
{
    draw_set_halign(fa_center);
    if (!playerFlags.moved || (global.time[UnknownEnum.Value_1] == 0 && global.time[UnknownEnum.Value_2] < 5))
    {
        var directionString = string(key_to_string(global.theButtons[4])) + ", " + string(key_to_string(global.theButtons[2])) + ", " + string(key_to_string(global.theButtons[5])) + ", " + string(key_to_string(global.theButtons[3])) + " ";
        draw_text_outline(200, 100, string(directionString) + global.TextContainer.moveTutorial.selectedLanguage, 1, 0, 14, 15, 160, 16777215, 1);
        draw_sprite_ext(spr_moveInstruct, image_index / 20, 200, 140, 2, 2, 0, c_white, 1);
    }
    if (!playerFlags.aimed || (global.time[UnknownEnum.Value_1] == 0 && global.time[UnknownEnum.Value_2] < 5))
    {
        draw_text_outline(440, 100, global.TextContainer.aimTutorial.selectedLanguage, 1, 0, 14, 15, 160, 16777215, 1);
        draw_sprite_ext(spr_aimInstruct, image_index / 20, 440, 140, 2, 2, 0, c_white, 1);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4
}
