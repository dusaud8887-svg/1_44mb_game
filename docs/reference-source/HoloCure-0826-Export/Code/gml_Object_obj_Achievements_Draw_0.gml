var selectedColor = [16777215, 0];
if (room == rm_Achievements)
{
    if (achievementMode == 0)
    {
        commandPromps(true, true, true);
        draw_set_halign(fa_center);
        draw_set_font(Galmuri14);
        draw_text_outline(320, 15, "ACHIEVEMENTS", 1, 0, 32, 4, 100, 16777215, 1);
        for (var i = 0; i < 3; i++)
        {
            var transparency = 0.5;
            draw_sprite_ext(hud_initButtons, currentOption == i, 320, 140 + (i * 32), 1, 1, 0, c_white, 0.5 + transparency);
            if (MouseOverButton("long", 320, 140 + (i * 32), 1))
            {
                if (mouse_check_button_pressed(mb_left))
                {
                    Confirmed();
                }
                else if (obj_InputManager.mouseMoving && currentOption != i && obj_InputManager.MouseMoved())
                {
                    currentOption = i;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
        }
        draw_set_font(Galmuri9);
        for (var i = 0; i < 3; i++)
        {
            draw_set_halign(fa_center);
            if (i == 1 && ds_map_find_value(global.PlayerSave, "fandom") == 0)
            {
                draw_text_color(320, 149 + (i * 32), global.TextContainer.achievementButtons.selectedLanguage[3], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
            }
            else
            {
                draw_text_color(320, 149 + (i * 32), global.TextContainer.achievementButtons.selectedLanguage[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
            }
        }
    }
    if (achievementMode == 1)
    {
        selectedColor = [16777215, 0];
        draw_set_halign(fa_center);
        draw_set_font(Galmuri14);
        draw_text_outline(320, 10, "Achievements", 1, 0, 32, 4, 400, 16777215, 1);
        commandPromps(true, true, true);
        draw_sprite(hud_OptionButton, 1, 320, 40);
        draw_set_halign(fa_center);
        draw_text_color(320, 48, global.TextContainer.achType.selectedLanguage[achievementType], selectedColor[1], selectedColor[1], selectedColor[1], selectedColor[1], 1);
        draw_sprite(hud_scrollArrows2, 0, 220, 53);
        draw_sprite(hud_scrollArrows2, 1, 420, 53);
        if (mouse_x > 210 && mouse_x < 230 && mouse_y > 43 && mouse_y < 63 && mouse_check_button_pressed(mb_left))
        {
            SelectLeft();
        }
        if (mouse_x > 410 && mouse_x < 430 && mouse_y > 43 && mouse_y < 63 && mouse_check_button_pressed(mb_left))
        {
            SelectRight();
        }
        for (var i = 0; i < min(array_length(achievementSeparated[achievementType]), 5); i++)
        {
            var entry = showingIndex + i;
            draw_sprite(spr_achievement_bar, 0, 145, 75 + (i * 53));
            DrawAchievement(145, 75 + (i * 53), achievementSeparated[achievementType][entry]);
        }
        if (array_length(achievementSeparated[achievementType]) > 5)
        {
            draw_sprite(hud_scrollArrows, 0, 500, 77);
            draw_sprite(hud_scrollArrows, 1, 500, 338);
            var totalYSpace = 251;
            var itemPerLine = 1;
            var rowsOnScreen = 5;
            var yPos = 81;
            var numberOfTicks = array_length(achievementSeparated[achievementType]) - rowsOnScreen;
            var rectHeight = 1255 / array_length(achievementSeparated[achievementType]);
            var scrollDist = 251 / array_length(achievementSeparated[achievementType]);
            draw_set_color(c_white);
            draw_rectangle(497, yPos + (scrollDist * showingIndex), 503, yPos + rectHeight + (scrollDist * showingIndex), false);
            if (mouse_check_button(mb_left))
            {
                if (mouse_x >= 492 && mouse_x < 508 && mouse_y >= (yPos - (totalYSpace / (numberOfTicks + 1))) && mouse_y <= (338 + (totalYSpace / (numberOfTicks + 1))))
                {
                    for (var j = 0; j < (numberOfTicks + 1); j++)
                    {
                        if (mouse_y > (yPos + (j * (totalYSpace / (numberOfTicks + 1)))) && mouse_y < (yPos + ((j + 1) * (totalYSpace / (numberOfTicks + 1)))))
                        {
                            if (showingIndex != j)
                            {
                                showingIndex = j;
                                audio_play_sound(snd_menu_select, 30, 0);
                                break;
                            }
                        }
                    }
                }
            }
        }
        if (MouseOverButton("long", 320, 40) && mouse_check_button_pressed(mb_left))
        {
            SelectRight();
        }
        draw_set_halign(fa_left);
        draw_set_font(Galmuri9);
        draw_sprite_ext(spr_achievementinfo, 0, 502, 6, 1, 1, 0, c_white, 0.7);
        draw_text(507, 16, global.TextContainer.achTexts.selectedLanguage[0] + string(unlockedCount) + " / " + string(array_length(achievementArray)));
        draw_text(507, 31, global.TextContainer.achTexts.selectedLanguage[1] + string(floor((unlockedCount / array_length(achievementArray)) * 100)) + "%");
    }
    else if (achievementMode == 2)
    {
        selectedColor = [16777215, 0];
        draw_set_halign(fa_center);
        draw_set_font(Galmuri14);
        draw_text_outline(320, 10, "Fandoms", 1, 0, 32, 4, 400, 16777215, 1);
        commandPromps(true, true, true);
        draw_sprite(hud_scrollArrows, 0, 276, 54);
        draw_sprite(hud_scrollArrows, 1, 276, 339);
        var totalYSpace = 276;
        var itemPerLine = 1;
        var rowsOnScreen = 5;
        var numberOfTicks = array_length(global.characterList) - 1 - rowsOnScreen;
        var rectHeight = (totalYSpace * rowsOnScreen) / (((array_length(global.characterList) - 1) div itemPerLine) + (((array_length(global.characterList) - 1) % itemPerLine) > 0));
        var scrollDist = totalYSpace / (((array_length(global.characterList) - 1) div itemPerLine) + (((array_length(global.characterList) - 1) % itemPerLine) > 0));
        draw_set_color(c_white);
        draw_rectangle(274, 58 + (scrollDist * (startingPosition div itemPerLine)), 278, 58 + rectHeight + (scrollDist * (startingPosition div itemPerLine)), false);
        if (mouse_check_button(mb_left))
        {
            if (mouse_x >= 269 && mouse_x < 283 && mouse_y >= (54 - (totalYSpace / (numberOfTicks + 1))) && mouse_y <= (339 + (totalYSpace / (numberOfTicks + 1))))
            {
                for (var j = 0; j < (numberOfTicks + 1); j++)
                {
                    if (mouse_y > (54 + (j * (totalYSpace / (numberOfTicks + 1)))) && mouse_y < (54 + ((j + 1) * (totalYSpace / (numberOfTicks + 1)))))
                    {
                        if (startingPosition != j)
                        {
                            startingPosition = j;
                            audio_play_sound(snd_menu_select, 30, 0);
                            break;
                        }
                    }
                }
            }
        }
        draw_set_color(c_black);
        draw_set_alpha(0.1);
        draw_rectangle(311, 110, 605, 337, false);
        draw_set_alpha(1);
        draw_set_color(c_white);
        draw_set_halign(fa_left);
        draw_rectangle(311, 110, 605, 337, true);
        draw_rectangle(311, 110, 605, 129, false);
        draw_set_color(c_black);
        draw_set_alpha(1);
        draw_set_font(Galmuri9);
        draw_set_color(make_color_rgb(74, 190, 249));
        draw_text_scribble(316, 115, "CURRENT LEVEL");
        var charBox = [90, 50];
        draw_set_font(Galmuri9);
        for (var i = 0; i < 5; i++)
        {
            var getChar = ds_map_find_value(global.characterData, global.characterList[i + startingPosition]);
            draw_set_alpha(0.5);
            draw_set_color(c_black);
            draw_rectangle(charBox[0], charBox[1] + (i * 59), charBox[0] + 173, charBox[1] + 56 + (i * 59), false);
            draw_set_alpha(1);
            draw_set_halign(fa_left);
            draw_set_color(c_white);
            draw_text(charBox[0] + 4, charBox[1] + 4 + (i * 59), getChar.charName);
            draw_sprite(getChar.port, 0, charBox[0], charBox[1] + 17 + (i * 59));
            if (MouseOverButton("fandomBox", charBox[0], charBox[1] + (i * 59)))
            {
                if (obj_InputManager.mouseMoving && obj_InputManager.MouseMoved() && charOption != i)
                {
                    charOption = i;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
            }
            if (charOption == i)
            {
                draw_sprite_ext(spr_holoCursor, image_index / 4, charBox[0] - 37, charBox[1] + (i * 59) + 30, 2, 2, 0, c_white, 1);
            }
            var followingIcons = [2300, 1547, 994];
            var followingLevel = 0;
            for (var j = 0; j < 3; j++)
            {
                draw_sprite(spr_FollowingLevels, j, charBox[0] + 68 + (j * 40), charBox[1] + 36 + (i * 59));
                var charIndex = -1;
                for (var k = 0; k < array_length(global.characterFollowings); k++)
                {
                    if (global.characterFollowings[k][0] == getChar.id)
                    {
                        charIndex = k;
                        followingLevel = global.characterFollowings[k][1];
                    }
                }
                if (charIndex > -1 && global.characterFollowings[charIndex][1] > j)
                {
                    draw_sprite(followingIcons[j], image_index / 3, charBox[0] + 69 + (j * 40), charBox[1] + 36 + (i * 59));
                }
            }
            draw_set_color(c_white);
            if (charOption == i)
            {
                var charIndex = -1;
                for (var k = 0; k < array_length(global.characterFollowings); k++)
                {
                    if (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), k), 0) == getChar.id)
                    {
                        charIndex = k;
                        followingLevel = global.characterFollowings[k][1];
                    }
                }
                draw_text_scribble(316, 85, "Fandom EXP: ");
                draw_sprite(spr_fandombarback, 0, 385, 87);
                draw_healthbar(385, 87, 587, 93, (array_get(array_get(ds_map_find_value(global.PlayerSave, "fandomEXP"), charIndex), 1) / 100) * 100, c_red, c_yellow, c_yellow, 0, 0, 0);
                draw_sprite(spr_fandombarcase, 0, 385, 87);
                draw_sprite(followingIcons[0], image_index / 3, 452, 70);
                draw_sprite(followingIcons[1], image_index / 3, 520, 70);
                draw_sprite(followingIcons[2], image_index / 3, 588, 70);
                draw_text_scribble(320, 135, global.TextContainer.fandomTexts.selectedLanguage[0]);
                draw_text_scribble(320 + string_width(global.TextContainer.fandomTexts.selectedLanguage[0]), 135, global.TextContainer.fandomNames.selectedLanguage[followingLevel]);
                draw_text_scribble(320, 155, global.TextContainer.fandomTexts.selectedLanguage[1]);
                draw_text_scribble(326, 170, global.TextContainer.fandomBonuses.selectedLanguage[followingLevel]);
                if (followingLevel < 3)
                {
                    draw_text_scribble(320, 255, global.TextContainer.fandomTexts.selectedLanguage[2]);
                }
            }
        }
    }
}
if (unlockedCount == array_length(achievementArray) && room == rm_Achievements)
{
    if (fireworksCD > 0)
    {
        fireworksCD--;
    }
    else
    {
        fireworksCD = 10;
        instance_create_depth(irandom(640), 360, depth + 20, obj_fireworks);
    }
}
