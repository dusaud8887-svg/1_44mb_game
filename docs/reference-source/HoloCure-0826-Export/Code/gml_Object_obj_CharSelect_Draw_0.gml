if (leftcontainer[0] < 20)
{
    leftcontainer[0] += 75;
}
else
{
    leftcontainer[0] = 20;
}
if (rightcontainer[0] > 620)
{
    rightcontainer[0] -= 75;
}
else
{
    rightcontainer[0] = 620;
}
var showingCharacter = -1;
if (selectedCharacter == randomSelectSlot)
{
    showingCharacter = randomSelect;
}
else
{
    showingCharacter = selectedCharacter;
}
if (global.charSelected != -1)
{
    if (bottomcontainer[1] > 20)
    {
        bottomcontainer[1] -= 35;
    }
    else
    {
        bottomcontainer[1] = 10;
    }
    bottomcontainer0[1] = bottomcontainer[1] + 150;
}
else
{
    if (bottomcontainer[1] < 220)
    {
        bottomcontainer[1] += 35;
    }
    else
    {
        bottomcontainer[1] = 220;
    }
    bottomcontainer0[0] = 320;
}
var howMuchMove = 640 * ((global.gameMode != -1) + choseOutfit + extraPush);
bottomcontainer2[1] = bottomcontainer0[1];
bottomcontainer3[1] = bottomcontainer2[1];
bottomcontainer2[0] = bottomcontainer0[0] + 640;
bottomcontainer3[0] = bottomcontainer2[0] + 640;
if (bottomcontainer0[0] != (320 - howMuchMove))
{
    var dirAdd = 0;
    if (bottomcontainer0[0] > (320 - howMuchMove))
    {
        dirAdd = -1;
    }
    if (bottomcontainer0[0] < (320 - howMuchMove))
    {
        dirAdd = 1;
    }
    bottomcontainer0[0] += dirAdd * 160;
}
var charPortHeight = 38;
var vertSpacing = 4;
var charPortY = 40;
commandPromps(true, true, true);
draw_set_color(c_black);
draw_set_alpha(0.3);
if (global.charSelected != -1)
{
    draw_rectangle(0, bottomcontainer[1] + 130, 640, bottomcontainer[1] + 130 + 200, 0);
}
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_rectangle(bottomcontainer[0], bottomcontainer[1], bottomcontainer[0] + 200, bottomcontainer[1] + 120, true);
draw_rectangle(bottomcontainer[0] + 200, bottomcontainer[1], bottomcontainer[0] + 400, bottomcontainer[1] + 120, true);
draw_rectangle(bottomcontainer[0] + 400, bottomcontainer[1], bottomcontainer[0] + 600, bottomcontainer[1] + 120, true);
draw_set_color(c_black);
draw_set_alpha(0.3);
draw_rectangle(bottomcontainer[0], bottomcontainer[1], bottomcontainer[0] + 600, bottomcontainer[1] + 120, false);
draw_set_alpha(1);
if (characterInfo[showingCharacter].large_port > -1)
{
    draw_sprite_ext(characterInfo[showingCharacter].large_port, 0, (leftcontainer[0] - 13) + 50, 300, 2, 2, 0, c_white, 0.6);
}
if (characterInfo[showingCharacter].large_port > -1)
{
    draw_sprite_ext(characterInfo[showingCharacter].large_port, 0, (rightcontainer[0] + 13) - 50, 300, -2, 2, 0, c_white, 0.6);
}
draw_set_color(c_white);
draw_rectangle(bottomcontainer[0], bottomcontainer[1], bottomcontainer[0] + 600, bottomcontainer[1] + 20, false);
draw_set_font(Galmuri9);
draw_set_color(make_color_rgb(74, 190, 249));
draw_text_scribble(bottomcontainer[0] + 5, bottomcontainer[1] + 5, characterInfo[showingCharacter].charName);
if (characterInfo[showingCharacter].sprite1 && characterInfo[showingCharacter].sprite2 > -1)
{
    var charData = characterInfo[showingCharacter];
    if (global.charSelected != -1 && variable_struct_exists(global.charSelected, "outfits") && variable_struct_exists(global.charSelected.outfits, availableOutfits[outfitSelect]) && variable_struct_exists(global.charSelected.outfits, availableOutfits[outfitSelect]))
    {
        var theOutfit = availableOutfits[outfitSelect];
        charData = variable_struct_get(global.charSelected.outfits, theOutfit).sprites[0];
    }
    if (charAnim == 0)
    {
        draw_sprite_ext(charData.sprite1, image_index / 12, bottomcontainer[0] + 60, bottomcontainer[1] + 100, 2, 2, 0, c_white, 1);
    }
    if (charAnim == 1)
    {
        draw_sprite_ext(charData.sprite2, image_index / 4, bottomcontainer[0] + 60, bottomcontainer[1] + 100, 2, 2, 0, c_white, 1);
    }
}
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(Galmuri9);
draw_set_valign(fa_top);
var statX = 110;
var statY = 25;
var spacingY = 19;
draw_healthbar(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 8, bottomcontainer[0] + statX + 82, bottomcontainer[1] + statY + 14, characterInfo[showingCharacter].HP, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
draw_healthbar(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 8 + spacingY, bottomcontainer[0] + statX + 82, bottomcontainer[1] + statY + 14 + spacingY, (characterInfo[showingCharacter].ATK / 2) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
draw_healthbar(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 8 + (spacingY * 2), bottomcontainer[0] + statX + 82, bottomcontainer[1] + statY + 14 + (spacingY * 2), ((characterInfo[showingCharacter].SPD - 1) / 0.6) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
draw_healthbar(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 8 + (spacingY * 3), bottomcontainer[0] + statX + 82, bottomcontainer[1] + statY + 14 + (spacingY * 3), (characterInfo[showingCharacter].crit / 15) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
draw_sprite(hud_HPicon, 0, bottomcontainer[0] + statX, bottomcontainer[1] + statY);
draw_text_scribble(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 2, "HP");
draw_sprite(ui_menu_stats_divider, 1, bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 15);
draw_sprite(hud_atkicon, 0, bottomcontainer[0] + statX, bottomcontainer[1] + statY + spacingY);
draw_text_scribble(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 2 + spacingY, "ATK");
draw_sprite(ui_menu_stats_divider, 1, bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 15 + spacingY);
draw_sprite(hud_spdicon, 0, bottomcontainer[0] + statX, bottomcontainer[1] + statY + (spacingY * 2));
draw_text_scribble(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 2 + (spacingY * 2), "SPD");
draw_sprite(ui_menu_stats_divider, 1, bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 15 + (spacingY * 2));
draw_sprite(hud_criticon, 0, bottomcontainer[0] + statX, bottomcontainer[1] + statY + (spacingY * 3));
draw_text_scribble(bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 2 + (spacingY * 3), "CRT");
draw_sprite(ui_menu_stats_divider, 1, bottomcontainer[0] + statX + 20, bottomcontainer[1] + statY + 15 + (spacingY * 3));
draw_set_halign(fa_right);
if (characterInfo[showingCharacter].HP == 44.5)
{
    draw_text_scribble(bottomcontainer[0] + statX + 80, bottomcontainer[1] + statY + 2, string_format(characterInfo[showingCharacter].HP, 1, 1));
}
else
{
    draw_text_scribble(bottomcontainer[0] + statX + 80, bottomcontainer[1] + statY + 2, string(characterInfo[showingCharacter].HP));
}
draw_text_scribble(bottomcontainer[0] + statX + 80, bottomcontainer[1] + statY + 2 + spacingY, string(characterInfo[showingCharacter].ATK));
draw_text_scribble(bottomcontainer[0] + statX + 80, bottomcontainer[1] + statY + 2 + (spacingY * 2), string(characterInfo[showingCharacter].SPD));
draw_text_scribble(bottomcontainer[0] + statX + 80, bottomcontainer[1] + statY + 2 + (spacingY * 3), string(characterInfo[showingCharacter].crit) + "%");
draw_set_color(c_yellow);
draw_set_halign(fa_left);
if (characterInfo[showingCharacter].id != "")
{
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) > 1)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == characterInfo[showingCharacter].id)
            {
                draw_set_halign(fa_right);
                draw_text_scribble(bottomcontainer[0] + statX + 80, bottomcontainer[1] + statY + 2 + (spacingY * 4), "G. RANK: " + string(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1)));
            }
        }
    }
    draw_set_halign(fa_left);
    if (ds_map_find_value(global.PlayerSave, "fandom"))
    {
        var charIndex = -1;
        for (var i = 0; i < array_length(global.characterFollowings); i++)
        {
            if (global.characterFollowings[i][0] == characterInfo[showingCharacter].id)
            {
                charIndex = i;
            }
        }
        if (charIndex > -1)
        {
            var followingStatus = global.characterFollowings[charIndex][1];
            if (followingStatus == 1)
            {
                draw_sprite(spr_Following_Fan, image_index / 3, bottomcontainer[0] + 20, bottomcontainer[1] + statY + 2 + (spacingY * 4));
            }
            else if (followingStatus == 2)
            {
                draw_sprite(spr_Following_Oshi, image_index / 3, bottomcontainer[0] + 20, bottomcontainer[1] + statY + 2 + (spacingY * 4));
            }
            else if (followingStatus == 3)
            {
                draw_sprite(spr_Following_Gachikoi, image_index / 3, bottomcontainer[0] + 20, bottomcontainer[1] + statY + 2 + (spacingY * 4));
            }
        }
    }
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characterClears")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characterClears"), i), 0) == characterInfo[showingCharacter].id)
        {
            draw_sprite(spr_ach_firstwin, 0, bottomcontainer[0] + 15, bottomcontainer[1] + 39);
            draw_text(bottomcontainer[0] + 29, bottomcontainer[1] + 35, string(min(9999, array_get(array_get(ds_map_find_value(global.PlayerSave, "characterClears"), i), 1))));
        }
    }
    draw_set_color(c_white);
    var textWidth = 190;
    if (showingCharacter != randomSelectSlot && characterInfo[showingCharacter] != ds_map_find_value(global.characterData, "empty") && characterInfo[showingCharacter] != ds_map_find_value(global.characterData, "random"))
    {
        draw_set_font(Galmuri9);
        draw_set_color(make_color_rgb(74, 190, 249));
        draw_sprite(characterInfo[showingCharacter].attackIcon, 0, bottomcontainer[0] + 200 + 12, bottomcontainer[1] + 12);
        draw_text_scribble_ext(bottomcontainer[0] + 200 + 27, bottomcontainer[1] + 5, characterInfo[showingCharacter].attack, textWidth);
        draw_set_color(c_white);
        draw_text_scribble_ext(bottomcontainer[0] + 200 + 7, bottomcontainer[1] + 30, characterInfo[showingCharacter].attackDesc[0], textWidth);
        if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0)
        {
            draw_set_font(Galmuri9);
            draw_set_color(make_color_rgb(74, 190, 249));
            draw_sprite(characterInfo[showingCharacter].specIcon, 0, bottomcontainer[0] + 400 + 12, bottomcontainer[1] + 12);
            draw_text_scribble_ext(bottomcontainer[0] + 400 + 27, bottomcontainer[1] + 5, characterInfo[showingCharacter].specName, textWidth);
            draw_set_color(c_white);
            draw_text_scribble_ext(bottomcontainer[0] + 400 + 7, bottomcontainer[1] + 30, characterInfo[showingCharacter].specDesc, textWidth);
        }
    }
    if (showingCharacter == randomSelectSlot && characterInfo[randomSelect] != ds_map_find_value(global.characterData, "empty") && characterInfo[randomSelect] != ds_map_find_value(global.characterData, "random"))
    {
        draw_sprite(characterInfo[randomSelect].attackIcon, 0, bottomcontainer[0] + 15, bottomcontainer[1] + 42);
        draw_text_scribble_ext(bottomcontainer[0] + 37, bottomcontainer[1] + 35, characterInfo[randomSelect].attack, textWidth);
        draw_text_scribble_ext(bottomcontainer[0] + 7, bottomcontainer[1] + 55, characterInfo[randomSelect].attackDesc[0], textWidth);
        if (ds_map_find_value(global.PlayerSave, "specUnlock") > 0)
        {
            draw_sprite(characterInfo[randomSelect].specIcon, 0, bottomcontainer[0] + 15, bottomcontainer[1] + 172);
            draw_text_scribble_ext(bottomcontainer[0] + 37, bottomcontainer[1] + 165, characterInfo[randomSelect].specName, textWidth);
            draw_text_scribble_ext(bottomcontainer[0] + 7, bottomcontainer[1] + 185, characterInfo[randomSelect].specDesc, textWidth);
        }
    }
}
draw_set_color(c_white);
draw_set_alpha(1);
draw_set_font(Galmuri7);
draw_set_halign(fa_left);
selectingAlpha++;
if (global.charSelected == -1)
{
    var charsPerRow = 6;
    if (global.charSelected == -1)
    {
        var charX = 180;
        for (var i = 0; i < min(10, array_length(charListByGen)); i++)
        {
            for (var j = 0; j < array_length(charListByGen[i]); j++)
            {
                var pushInX = (6 - array_length(charListByGen[i])) * 23;
                if (MouseOverButton("characterSelect", charX + (j * 46) + pushInX, charPortY + (i * (charPortHeight + vertSpacing)), 1, charPortHeight) && global.charSelected == -1)
                {
                    if (!(i == selectingGen && j == selectingChar) && obj_InputManager.MouseMoved() && canControl)
                    {
                        selectingGen = i;
                        selectingChar = j;
                        CalculateChar();
                        leftcontainer[0] = -280;
                        rightcontainer[0] = 920;
                        audio_play_sound(snd_charSelectWoosh, 0, 0);
                    }
                    if (mouse_check_button_pressed(mb_left))
                    {
                        Select();
                    }
                }
                if (charListByGen[i][j].port != -1)
                {
                    draw_rectangle_color(charX + (j * 46) + 3 + pushInX, charPortY + (i * (charPortHeight + vertSpacing)), charX + pushInX + (j * 46) + 45, charPortY + (i * (charPortHeight + vertSpacing)) + (charPortHeight - 1), c_white, c_white, c_white, c_white, true);
                    draw_sprite_part(charListByGen[i][j].port, 0, 0, 0, 49, charPortHeight, charX + (j * 46) + pushInX, charPortY + (i * (charPortHeight + vertSpacing)));
                }
                if (i == selectingGen && j == selectingChar)
                {
                    draw_set_alpha(sin(selectingAlpha / 5) * 0.4);
                    draw_rectangle_color(charX + (j * 46) + 3 + pushInX, charPortY + (i * (charPortHeight + vertSpacing)), charX + pushInX + (j * 46) + 45, charPortY + (i * (charPortHeight + vertSpacing)) + (charPortHeight - 1), c_white, c_white, c_white, c_white, false);
                    draw_set_alpha(1);
                }
            }
        }
        draw_set_color(c_black);
        draw_set_alpha(0.25);
        draw_rectangle(0, 10, 1000, 33, 0);
        draw_set_alpha(1);
        draw_set_halign(fa_center);
        draw_set_font(Galmuri14);
        draw_set_color(c_white);
        draw_text_scribble(320, 10, "아이돌을 선택하세요");
    }
}
if (global.charSelected != -1 && array_length(availableOutfits) > 1)
{
    var dressingRoomY = bottomcontainer0[1] + 90;
    draw_set_alpha(0.5);
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_sprite_ext(menu_dressroom, 0, bottomcontainer0[0], dressingRoomY + 40, 3, 3, 0, c_white, 1);
    if (outfitSelect == 0)
    {
        draw_sprite_ext(global.charSelected.sprite1, image_index / 12, bottomcontainer0[0], dressingRoomY + 40, 3, 3, 0, c_white, 1);
    }
    else if (variable_struct_exists(global.charSelected.outfits, availableOutfits[outfitSelect]))
    {
        var theOutfit = availableOutfits[outfitSelect];
        draw_sprite_ext(variable_struct_get(global.charSelected.outfits, theOutfit).sprites[0].sprite1, image_index / 12, bottomcontainer0[0], dressingRoomY + 40, 3, 3, 0, c_white, 1);
    }
    draw_sprite(spr_StageSelectArrows, image_index / 5, bottomcontainer0[0], dressingRoomY);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_text_scribble(bottomcontainer0[0], bottomcontainer0[1] - 10, "OUTFITS");
    if (mouse_x > (bottomcontainer0[0] - 47 - 72) && mouse_x < (bottomcontainer0[0] - 72) && mouse_y > (dressingRoomY - 43) && mouse_y < (dressingRoomY + 43) && mouse_check_button_pressed(mb_left) && !choseOutfit)
    {
        Left();
    }
    if (mouse_x > (bottomcontainer0[0] + 72) && mouse_x < (bottomcontainer0[0] + 72 + 47) && mouse_y > (dressingRoomY - 43) && mouse_y < (dressingRoomY + 43) && mouse_check_button_pressed(mb_left) && !choseOutfit)
    {
        Right();
    }
    if (mouse_x > (bottomcontainer0[0] - 72) && mouse_x < (bottomcontainer0[0] + 72) && mouse_y > (dressingRoomY - 73) && mouse_y < (dressingRoomY + 73) && mouse_check_button_pressed(mb_left) && !choseOutfit)
    {
        Select();
    }
}
draw_set_font(Galmuri9);
if (global.charSelected != -1 && choseOutfit && !global.holoHouseMode)
{
    var modeSpacing = 200;
    var offsetY = (ds_map_find_value(global.PlayerSave, "timeModeUnlocked") * modeSpacing) / 2;
    var availableModes = 2 + ds_map_find_value(global.PlayerSave, "timeModeUnlocked");
    var plusY = 40;
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_sprite(menu_modeSelect2, 1, bottomcontainer2[0] - (modeSpacing / 2) - offsetY, bottomcontainer2[1] + plusY);
    draw_sprite(menu_modeSelect2, 1, (bottomcontainer2[0] + (modeSpacing / 2)) - offsetY, bottomcontainer2[1] + plusY);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri9);
    draw_set_color(c_white);
    draw_text_scribble(bottomcontainer2[0] - (modeSpacing / 2) - offsetY, bottomcontainer2[1] + 5 + plusY, global.TextContainer.stageSelectTexts.selectedLanguage[0][0]);
    draw_text_scribble(bottomcontainer2[0] - (modeSpacing / 2) - offsetY, bottomcontainer2[1] + 20 + plusY, global.TextContainer.stageSelectTexts.selectedLanguage[0][1]);
    draw_text_scribble((bottomcontainer2[0] + (modeSpacing / 2)) - offsetY, bottomcontainer2[1] + 5 + plusY, global.TextContainer.stageSelectTexts.selectedLanguage[1][0]);
    draw_text_scribble((bottomcontainer2[0] + (modeSpacing / 2)) - offsetY, bottomcontainer2[1] + 20 + plusY, global.TextContainer.stageSelectTexts.selectedLanguage[1][1]);
    if (ds_map_find_value(global.PlayerSave, "timeModeUnlocked"))
    {
        draw_sprite(menu_modeSelect2, 1, (bottomcontainer2[0] + (modeSpacing * 1.5)) - offsetY, bottomcontainer2[1] + plusY);
        draw_text_scribble((bottomcontainer2[0] + (modeSpacing * 1.5)) - offsetY, bottomcontainer2[1] + 5 + plusY, global.TextContainer.stageSelectTexts.selectedLanguage[2][0]);
        draw_text_scribble((bottomcontainer2[0] + (modeSpacing * 1.5)) - offsetY, bottomcontainer2[1] + 20 + plusY, global.TextContainer.stageSelectTexts.selectedLanguage[2][1]);
    }
    draw_set_halign(fa_center);
    draw_sprite_ext(menu_modeSelect2, 0, (bottomcontainer2[0] - (modeSpacing / 2) - offsetY) + (modeSpacing * modeOption), bottomcontainer2[1] + plusY, 1, 1, 0, c_white, 0.2 + (0.1 * sin(selectingAlpha / 10)));
    for (var i = 0; i < availableModes; i++)
    {
        if (MouseOverButton("halfOption", (bottomcontainer2[0] - (modeSpacing / 2) - offsetY) + (modeSpacing * i), bottomcontainer2[1] + plusY))
        {
            if (modeOption != i && obj_InputManager.MouseMoved())
            {
                modeOption = i;
                audio_play_sound(snd_menu_select, 0, 0);
            }
            if (mouse_check_button_pressed(mb_left))
            {
                Select();
            }
        }
    }
    draw_set_font(Galmuri14);
    draw_text_scribble(bottomcontainer2[0], bottomcontainer2[1] - 10, "CHOOSE MODE");
}
if (global.charSelected != -1 && global.gameMode != -1)
{
    var yoffSet = 10;
    var whichSet = -1;
    switch (global.gameMode)
    {
        case 0:
            whichSet = availableStages;
            break;
        case 1:
            whichSet = availableStages;
            break;
        case 2:
            whichSet = availableTimeStages;
            break;
        case 3:
            whichSet = availableHouseStages;
            break;
    }
    draw_set_alpha(0.3);
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_sprite(whichSet[selectedStage].stageSprite, 0, bottomcontainer3[0] - 75 - 90, bottomcontainer3[1] + 30 + yoffSet);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri9);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri9);
    draw_text_scribble(bottomcontainer3[0] - 90, bottomcontainer3[1] + 10 + yoffSet, whichSet[selectedStage].stageIDName + " - " + whichSet[selectedStage].stageName());
    draw_set_halign(fa_center);
    draw_set_font(Galmuri9);
    draw_set_halign(fa_center);
    if (array_length(whichSet) > 1 && !foodOption)
    {
        draw_sprite(spr_StageSelectArrows, image_index / 5, bottomcontainer3[0] - 90, bottomcontainer3[1] + 75 + yoffSet);
    }
    if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedStages"), whichSet[selectedStage].stageIDName))
    {
        draw_set_alpha(0.5);
        draw_set_color(c_black);
        draw_rectangle(bottomcontainer3[0] - 75 - 90, bottomcontainer3[1] + 30 + yoffSet, (bottomcontainer3[0] + 75) - 90, bottomcontainer3[1] + 30 + 89 + yoffSet, false);
        draw_set_alpha(1);
        draw_sprite_ext(menu_stageLocked, 0, bottomcontainer3[0] - 90, bottomcontainer3[1] + 30 + 45 + yoffSet, 2, 2, 0, c_white, 1);
        draw_set_color(c_white);
    }
    if (global.gameMode < 2)
    {
        draw_set_halign(fa_left);
        draw_text_scribble(bottomcontainer3[0] + 30, bottomcontainer3[1] + 30 + yoffSet, "HoloCoin: ");
        draw_sprite(spr_holoCoin, image_index / 5, (bottomcontainer3[0] + 120) - 15, bottomcontainer3[1] + 34 + yoffSet);
        draw_text_scribble(bottomcontainer3[0] + 120, bottomcontainer3[1] + 30 + yoffSet, "x  " + string(whichSet[selectedStage].coinMultiplier));
    }
    if (mouse_x > (bottomcontainer3[0] - 75 - 90) && mouse_x < ((bottomcontainer3[0] + 75) - 90) && mouse_y > ((bottomcontainer3[1] + 75 + yoffSet) - 45) && mouse_y < (bottomcontainer3[1] + 75 + yoffSet + 45))
    {
        if (obj_InputManager.MouseMoved() && foodOption)
        {
            foodOption = false;
            audio_play_sound(snd_menu_select, 0, 0);
        }
        if (!readyToGo && mouse_check_button_pressed(mb_left))
        {
            Select();
        }
    }
    if (mouse_x > (bottomcontainer3[0] - 75 - 90 - 33) && mouse_x < (bottomcontainer3[0] - 75 - 90) && mouse_y > ((bottomcontainer3[1] + 75 + yoffSet) - 45) && mouse_y < (bottomcontainer3[1] + 75 + yoffSet + 45) && mouse_check_button_pressed(mb_left) && !foodOption)
    {
        if (!readyToGo)
        {
            Left();
        }
    }
    if (mouse_x > ((bottomcontainer3[0] + 75) - 90) && mouse_x < (((bottomcontainer3[0] + 75) - 90) + 33) && mouse_y > ((bottomcontainer3[1] + 75 + yoffSet) - 45) && mouse_y < (bottomcontainer3[1] + 75 + yoffSet + 45) && mouse_check_button_pressed(mb_left) && !foodOption)
    {
        if (!readyToGo)
        {
            Right();
        }
    }
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "completedStages")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 0) == whichSet[selectedStage].stageIDName)
        {
            for (var j = 0; j < array_length(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1)); j++)
            {
                if (array_get(array_get(array_get(ds_map_find_value(global.PlayerSave, "completedStages"), i), 1), j) == global.charSelected.id)
                {
                    draw_set_halign(fa_left);
                    draw_sprite(spr_ach_firstwin, 0, bottomcontainer3[0] - 70 - 45, bottomcontainer3[1] + 135 + yoffSet);
                    draw_text_scribble(bottomcontainer3[0] - 70 - 25, bottomcontainer3[1] + 130 + yoffSet, "CLEARED!");
                }
            }
        }
    }
    var reccStruct = variable_struct_get_names(whichSet[selectedStage].recommendedStats);
    if (global.gameMode < 2)
    {
        var foodAmount = "";
        if (array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 0) != "")
        {
            foodAmount = " (" + string(array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 1)) + ")";
            if (foodAmount != "")
            {
                draw_sprite(spr_useFood, ds_map_find_value(global.PlayerSave, "cookingOn"), bottomcontainer3[0] + 37, bottomcontainer3[1] + 5 + 130 + yoffSet);
                if (foodOption)
                {
                    draw_sprite(spr_holoCursor, image_index / 5, bottomcontainer3[0] + 10, bottomcontainer3[1] + 5 + 130 + yoffSet);
                    draw_set_color(c_yellow);
                }
                else
                {
                    draw_set_color(c_white);
                }
                draw_text(bottomcontainer3[0] + 52, bottomcontainer3[1] + 130 + yoffSet, global.TextContainer.useFood.selectedLanguage);
                var getFood = ds_map_find_value(global.FOOD, array_get(ds_map_find_value(global.PlayerSave, "currentFood"), 0));
                draw_text(bottomcontainer3[0] + 52, bottomcontainer3[1] + 145 + yoffSet, getFood.optionName + foodAmount);
                if ((mouse_x - camera_get_view_x(view_camera[0])) >= ((bottomcontainer3[0] + 37) - 9) && (mouse_x - camera_get_view_x(view_camera[0])) < (bottomcontainer3[0] + 37 + 75) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((bottomcontainer3[1] + 5 + 130 + yoffSet) - 9) && (mouse_y - camera_get_view_y(view_camera[0])) < (bottomcontainer3[1] + 5 + 130 + yoffSet + 9))
                {
                    if (!foodOption && obj_InputManager.MouseMoved() && !readyToGo)
                    {
                        foodOption = true;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (mouse_check_button_pressed(mb_left))
                    {
                        Select();
                    }
                }
            }
        }
        draw_set_color(c_white);
        if (array_length(reccStruct) > 0)
        {
            draw_set_halign(fa_left);
            draw_text(bottomcontainer3[0] + 30, bottomcontainer3[1] + 60 + yoffSet, global.TextContainer.recommended.selectedLanguage);
            for (var i = 0; i < array_length(reccStruct); i++)
            {
                switch (reccStruct[i])
                {
                    case "ATK":
                        draw_sprite(hud_atkicon, 0, (bottomcontainer3[0] + 120) - 22, bottomcontainer3[1] + 78 + yoffSet + (i * 20));
                        if (ds_map_find_value(global.PlayerSave, "ATK") >= variable_struct_get(whichSet[selectedStage].recommendedStats, reccStruct[i]))
                        {
                            draw_set_color(c_lime);
                        }
                        else
                        {
                            draw_set_color(c_red);
                        }
                        draw_text(bottomcontainer3[0] + 120, bottomcontainer3[1] + 80 + yoffSet + (i * 20), "x  LV " + string(variable_struct_get(whichSet[selectedStage].recommendedStats, reccStruct[i])));
                        break;
                    case "SPD":
                        if (ds_map_find_value(global.PlayerSave, "SPD") >= variable_struct_get(whichSet[selectedStage].recommendedStats, reccStruct[i]))
                        {
                            draw_set_color(c_lime);
                        }
                        else
                        {
                            draw_set_color(c_red);
                        }
                        draw_sprite(hud_spdicon, 0, (bottomcontainer3[0] + 120) - 22, bottomcontainer3[1] + 78 + yoffSet + (i * 20));
                        draw_text(bottomcontainer3[0] + 120, bottomcontainer3[1] + 80 + yoffSet + (i * 20), "x  LV " + string(variable_struct_get(whichSet[selectedStage].recommendedStats, reccStruct[i])));
                        break;
                }
            }
            draw_set_color(c_white);
        }
    }
    else if (global.gameMode == 2)
    {
        var bestTime = undefined;
        var localScore = GetLocalScore(whichSet[selectedStage].stageID, global.charSelected.id);
        var timeSeconds = (localScore != undefined) ? localScore.allTime.duration : undefined;
        bestTime = StringFormatTimeSeconds(timeSeconds);
        draw_set_halign(fa_center);
        draw_text(bottomcontainer3[0] + 60, 188, "BEST TIME:");
        draw_set_font(Galmuri14);
        draw_text(bottomcontainer3[0] + 160, 180, bestTime);
        draw_set_halign(fa_left);
        draw_set_font(Galmuri9);
        draw_text_scribble_ext(bottomcontainer3[0] + 10, 220, global.TextContainer.timeModeTexts.selectedLanguage[0], 300);
    }
    else if (global.holoHouseMode)
    {
        draw_set_halign(fa_left);
        draw_set_font(Galmuri9);
        draw_text_scribble_ext(bottomcontainer3[0] + 10, 210, global.TextContainer.holoHouseText.selectedLanguage, 200);
    }
    draw_set_font(Galmuri14);
    draw_set_halign(fa_center);
    draw_text_scribble(bottomcontainer3[0], bottomcontainer2[1] - 10, "CHOOSE STAGE");
}
if (readyToGo)
{
    draw_set_font(Galmuri9);
    draw_sprite_ext(spr_goButton, 1, 550, 235, 1, 1, 0, c_white, 1);
    if (MouseOverButton("goButton", 550, 235) && mouse_check_button_pressed(mb_left))
    {
        Select();
    }
}
