var selectedColor = [16777215, 0];

function DrawScores()
{
    var leaderboard = GetCurrentTop100Leaderboard();
    var char = GetSelectedCharacterData();
    if (sprite_exists(char.large_port))
    {
        draw_sprite_ext(char.large_port, 0, 75, 350, 3, 3, 0, c_white, 0.7);
    }
    if (leaderboard == undefined)
    {
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        if (!fetchScoreError)
        {
            var fetchText = global.TextContainer.hiscoreMenu.selectedLanguage[0] + EllipsisString();
            draw_text_outline(300, 170, fetchText, 1, 0, 14, 2, 500, 16777215, 1);
        }
        else
        {
            var textIndex = fetchScoreNetworkStatusOK ? 6 : 7;
            var fetchText = global.TextContainer.hiscoreMenu.selectedLanguage[textIndex];
            draw_text_color(300, 170, fetchText, c_red, c_red, c_red, c_red, 1);
        }
        exit;
    }
    var leaderboardSize = array_length(leaderboard);
    if (leaderboardSize <= 0 && localScore == undefined)
    {
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_text_outline(300, 170, global.TextContainer.hiscoreMenu.selectedLanguage[1], 1, 0, 32, 4, 300, 16777215, 1);
        exit;
    }
    leaderboardSize = (leaderboardSize > 0) ? leaderboardSize : 0;
    for (var i = 0; i < 5; i++)
    {
        if (startingPosition == 0 && i < 3)
        {
            draw_sprite(menu_first, i, 120, 50 + (i * 58));
        }
        else
        {
            draw_sprite(menu_scorecontainer, 0, 120, 50 + (i * 58));
        }
        draw_sprite(menu_scorecontainer, 0, 300, 50 + (i * 58));
    }
    var pageIndex = floor(startingPosition / 10);
    var pagesAvailable = ceil((leaderboardSize + ((localScoreRanking >= 0) ? 1 : 0)) / 10);
    var pagesTotal = ceil(10);
    var pageXStart = 298 - (20 * floor(pagesTotal / 2));
    if ((pagesTotal % 2) == 0)
    {
        pageXStart += 10;
    }
    for (var i = 0; i < pagesTotal; i++)
    {
        draw_set_font((i == pageIndex) ? jpFont_Big : jpFont);
        draw_set_color((i == pageIndex) ? c_white : ((i < pagesAvailable) ? c_white : c_black));
        draw_set_alpha((i < pagesAvailable) ? 1 : 0.5);
        draw_set_halign(fa_center);
        draw_text_scribble(pageXStart + (i * 20), (i == pageIndex) ? 334 : 341, string(i + 1));
        if (!showOptions && MouseOverButton("arrow", pageXStart + 3 + (i * 20), ((i == pageIndex) ? 334 : 341) + 5, 1) && !showingAllCharacter)
        {
            if (mouse_check_button_pressed(mb_left))
            {
                leaderboard = GetCurrentTop100Leaderboard();
                if (leaderboard != undefined)
                {
                    if ((i * 10) < array_length(leaderboard))
                    {
                        startingPosition = i * 10;
                        audio_play_sound(snd_menu_confirm, 0, 0);
                    }
                }
            }
        }
    }
    draw_set_alpha(1);
    var dailyHoursLeft = GetDailyHoursLeft();
    var drawLocalScore = true;
    if (global.hiscoreTimeCategory == UnknownEnum.Value_1)
    {
        if (dailyHoursLeft == UnknownEnum.Value_0)
        {
            drawLocalScore = false;
        }
    }
    var stageType = GetStageType();
    var shortUID = GetShortUID();
    var scoresToDraw = min((leaderboardSize - startingPosition) + ((localScoreRanking >= 0) ? 1 : 0), 10);
    var scoresDrawn = 0;
    var localScoreDrawn = drawLocalScore && (localScoreRanking >= 0 && localScoreRanking < startingPosition);
    var localScoreIndex = min(localScoreRanking, 99);
    for (var column = 0; column < 2; column++)
    {
        for (var row = 0; row < 5 && scoresDrawn < scoresToDraw; row++)
        {
            var scoreIndex = startingPosition + row + ((column * 10) / 2);
            var offsetIndex = scoreIndex + (localScoreDrawn ? -1 : 0);
            var scoreRank = string(scoreIndex + 1);
            var scoreLevel = "1";
            var scoreName = "";
            var scoreScore = "0";
            var scoreDuration = "0";
            if (drawLocalScore && scoreIndex == localScoreIndex)
            {
                scoreLevel = string_replace(string(localScore.level), ".0", "");
                scoreName = global.hiscoreName ? global.username : "Anonymous";
                scoreScore = string_replace(string(localScore.score), ".0", "");
                scoreDuration = string_replace(string(localScore.duration), ".0", "");
                scoreRank = string(localScoreRanking + 1);
                if (localScoreRanking >= 900)
                {
                    scoreRank = scoreRank + "+";
                }
                else if (localScoreRanking >= 99)
                {
                    var top1000Leaderboard = GetCurrentTop1000Leaderboard();
                    if (top1000Leaderboard == undefined)
                    {
                        scoreRank = scoreRank + "+";
                    }
                }
                draw_sprite(menu_scorecontainer_new, 0, 120 + (column * 180), 50 + (row * 58));
                localScoreDrawn = true;
            }
            else
            {
                var overrideScoreName = false;
                if (offsetIndex == uidMatchRanking1 || offsetIndex == uidMatchRanking2)
                {
                    scoreName = global.hiscoreName ? global.username : "Anonymous";
                    overrideScoreName = true;
                    draw_sprite(menu_scorecontainer_new, 0, 120 + (column * 180), 50 + (row * 58));
                }
                if (offsetIndex > (leaderboardSize - 1))
                {
                    exit;
                }
                if (ds_map_exists(leaderboard[offsetIndex], "l") && is_int64(ds_map_find_value(array_get(leaderboard, offsetIndex), "l")))
                {
                    scoreLevel = string(ds_map_find_value(array_get(leaderboard, offsetIndex), "l"));
                }
                if (!overrideScoreName && ds_map_exists(leaderboard[offsetIndex], "n") && is_string(ds_map_find_value(array_get(leaderboard, offsetIndex), "n")))
                {
                    scoreName = ds_map_find_value(array_get(leaderboard, offsetIndex), "n");
                }
                if (ds_map_exists(leaderboard[offsetIndex], "s") && is_int64(ds_map_find_value(array_get(leaderboard, offsetIndex), "s")))
                {
                    scoreScore = string(ds_map_find_value(array_get(leaderboard, offsetIndex), "s"));
                }
                if (ds_map_exists(leaderboard[offsetIndex], "d") && is_int64(ds_map_find_value(array_get(leaderboard, offsetIndex), "d")))
                {
                    scoreDuration = string(ds_map_find_value(array_get(leaderboard, offsetIndex), "d"));
                }
            }
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            if (global.hiscorenames)
            {
                draw_text_scribble(132 + (column * 180), 55 + floor(0) + (row * 58), "[c_yellow]" + scoreName + "[/color]");
            }
            else
            {
                draw_text_scribble(132 + (column * 180), 55 + floor(0) + (row * 58), "[c_yellow]------------[/color]");
            }
            switch (stageType)
            {
                case UnknownEnum.Value_0:
                    draw_set_font(Galmuri7);
                    var durationLevel = "TIME: " + StringFormatTimeSeconds(scoreDuration) + "    LV: " + string(scoreLevel);
                    draw_text_scribble(132 + (column * 180), 61 + floor(25) + (row * 58), durationLevel);
                    draw_set_font(Galmuri9);
                    draw_text_scribble(132 + (column * 180), 58 + floor(12.5) + (row * 58), "점수: " + scoreScore);
                    break;
                case UnknownEnum.Value_1:
                    draw_set_font(Galmuri7);
                    scoreLevel = "SCORE: " + scoreScore + "    LV: " + string(scoreLevel);
                    draw_text_scribble(132 + (column * 180), 61 + floor(25) + (row * 58), scoreLevel);
                    draw_set_font(Galmuri9);
                    var timeText = "Time: " + StringFormatTimeSeconds(scoreDuration);
                    draw_text_scribble(132 + (column * 180), 58 + floor(12.5) + (row * 58), timeText);
                    break;
            }
            draw_set_halign(fa_right);
            draw_set_font(Galmuri9);
            draw_text_scribble(287 + (column * 180), ((55 + floor(0)) - 1) + (row * 58), "[c_silver]Rank[/color]");
            draw_set_font(Galmuri14);
            var localScoreColor = "[c_white]";
            if (offsetIndex == uidMatchRanking1 || offsetIndex == uidMatchRanking2 || (drawLocalScore && scoreIndex == localScoreIndex))
            {
                localScoreColor = "[c_yellow]";
            }
            draw_text_scribble(287 + (column * 180), 55 + floor(0) + 12 + (row * 58), localScoreColor + scoreRank + "[/color]");
            scoresDrawn++;
        }
    }
}

if (room == rm_HiScores)
{
    commandPromps(true, true, true);
    draw_set_font(Galmuri14);
    draw_set_halign(fa_left);
    draw_text_outline(20, 15, global.TextContainer.hiscoreMenu.selectedLanguage[2], 1, 0, 32, 4, 200, 16777215, 1);
    draw_set_halign(fa_center);
    var timeCategoryText = global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_2][global.hiscoreTimeCategory];
    draw_text_outline(300, 15, "- " + timeCategoryText + " -", 1, 0, 32, 4, 300, 16777215, 1);
    var dailyHoursLeft = GetDailyHoursLeft();
    if (dailyHoursLeft != undefined && global.hiscoreTimeCategory == UnknownEnum.Value_1)
    {
        draw_set_halign(fa_right);
        if (dailyHoursLeft == UnknownEnum.Value_m1)
        {
            draw_text_outline(620, 15, global.TextContainer.hiscoreMenu.selectedLanguage[3], 1, 0, 32, 4, 300, 16777215, 1);
        }
        else if (dailyHoursLeft == UnknownEnum.Value_0)
        {
            draw_text_outline(620, 15, global.TextContainer.hiscoreMenu.selectedLanguage[8], 1, 0, 32, 4, 300, 16777215, 1);
        }
        else
        {
            var hoursLeftPluralIndex = (dailyHoursLeft == UnknownEnum.Value_1) ? 4 : 5;
            var hoursLeftText = string(dailyHoursLeft) + global.TextContainer.hiscoreMenu.selectedLanguage[hoursLeftPluralIndex];
            draw_text_outline(620, 15, hoursLeftText, 1, 0, 32, 4, 300, 16777215, 1);
        }
    }
    DrawScores();
    for (var i = 0; i < UnknownEnum.Value_8; i++)
    {
        var updateButton = 1;
        if (i == UnknownEnum.Value_0 || i == UnknownEnum.Value_1)
        {
            updateButton = 0.5 + (canUpdate * 0.5);
        }
        var isSettings = i == UnknownEnum.Value_7;
        var sprite = isSettings ? 2160 : 1133;
        var buttonY = 65 + (i * 34) + (isSettings ? 8 : 0);
        draw_sprite_ext(sprite, currentOption == i, 560, buttonY, 1, 1, 0, c_white, updateButton);
        draw_set_halign(fa_center);
        draw_set_font(Galmuri9);
        var displayText = "";
        var drawScrollArrows = false;
        var color = selectedColor[currentOption == i];
        switch (i)
        {
            case UnknownEnum.Value_0:
                displayText = global.stageIDNames[global.stageLeaderboards[selectedStage].stageID];
                drawScrollArrows = true;
                break;
            case UnknownEnum.Value_1:
                displayText = ds_map_find_value(global.characterData, global.characterList[selectedCharacter]).charName;
                drawScrollArrows = true;
                break;
            case UnknownEnum.Value_2:
                displayText = global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_2][global.hiscoreTimeCategory];
                displayText = StringCapitalizeFirstLetters(displayText);
                drawScrollArrows = true;
                break;
            case UnknownEnum.Value_3:
                displayText = global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_3];
                break;
            case UnknownEnum.Value_4:
                displayText = global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_4];
                break;
            case UnknownEnum.Value_5:
                displayText = global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_5];
                break;
            case UnknownEnum.Value_6:
                displayText = global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_6];
                break;
            case UnknownEnum.Value_7:
                displayText = "";
                break;
        }
        draw_text_color(560, 60 + (i * 34), displayText, color, color, color, color, 1);
        if (!showOptions && MouseOverButton(isSettings ? "hiscoreSettings" : "hiscore", 560, buttonY, 1) && !showingAllCharacter)
        {
            if (mouse_check_button_pressed(mb_left))
            {
                if (!(i == UnknownEnum.Value_0 && (MouseOverButton("arrow", 500, 65 + (i * 34), 1) || MouseOverButton("arrow", 620, 65 + (i * 34), 1))))
                {
                    Confirmed();
                }
            }
            else if (obj_InputManager.mouseMoving && currentOption != i && obj_InputManager.MouseMoved())
            {
                currentOption = i;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        if (drawScrollArrows)
        {
            draw_sprite(hud_scrollArrows2, 0, 500, 65 + (i * 34));
            draw_sprite(hud_scrollArrows2, 1, 620, 65 + (i * 34));
            if (i == UnknownEnum.Value_0)
            {
                if (!showOptions && MouseOverButton("arrow", 500, 65 + (i * 34), 1) && !showingAllCharacter)
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        SelectLeft();
                    }
                }
                if (!showOptions && MouseOverButton("arrow", 620, 65 + (i * 34), 1) && !showingAllCharacter)
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        SelectRight();
                    }
                }
            }
        }
    }
    if (showingAllCharacter)
    {
        selectingAlpha++;
        var charsWindow = [165, 50];
        var rows = 6;
        var column = 7;
        draw_set_alpha(0.3);
        draw_set_color(c_black);
        draw_rectangle(160, 0, 442, 360, false);
        draw_set_alpha(1);
        for (var i = 0; i < column; i++)
        {
            for (var j = 0; j < rows; j++)
            {
                if (((i * rows) + j) < array_length(global.characterList) && global.characterList[(i * rows) + j] != "" && global.characterList[(i * rows) + j] != "random")
                {
                    if (IsCharacterUnlocked(global.characterList[(i * rows) + j]))
                    {
                        var getChar = ds_map_find_value(global.characterData, global.characterList[(i * rows) + j]);
                        draw_sprite(getChar.port, 0, charsWindow[0] + (j * 45), charsWindow[1] + (i * 40));
                    }
                    else
                    {
                        draw_sprite(menu_charselecLocked2, 0, charsWindow[0] + (j * 45), charsWindow[1] + (i * 40));
                    }
                }
                if (((i * rows) + j) == characterOption)
                {
                    draw_set_alpha(sin(selectingAlpha / 5) * 0.4);
                    draw_rectangle_color(charsWindow[0] + (j * 45) + 3, charsWindow[1] + (i * 40), charsWindow[0] + (j * 45) + 44, charsWindow[1] + (i * 40) + 37, c_white, c_white, c_white, c_white, false);
                    draw_set_alpha(1);
                    draw_rectangle_color(charsWindow[0] + (j * 45) + 3, charsWindow[1] + (i * 40), charsWindow[0] + (j * 45) + 44, charsWindow[1] + (i * 40) + 37, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), true);
                }
                if (!showOptions && MouseOverButton("characterSelect", charsWindow[0] + (j * 45), charsWindow[1] + (i * 40), 1) && showingAllCharacter)
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        Confirmed();
                    }
                    else if (obj_InputManager.mouseMoving && characterOption != ((i * rows) + j) && obj_InputManager.MouseMoved())
                    {
                        characterOption = (i * rows) + j;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
            }
        }
    }
}
if (showOptions)
{
    draw_sprite(spr_vignette, 0, 0, 0);
    draw_sprite(spr_vignette, 0, 0, 0);
    draw_sprite(spr_vignette, 0, 0, 0);
    draw_sprite(spr_vignette, 0, 0, 0);
    var posX = 320;
    var posY = 48;
    draw_sprite(hud_optionsmenu, 0, posX, posY);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_set_font(Galmuri14);
    draw_text_outline(posX, posY + 13, "SETTINGS", 1, 0, 32, 4, 100, 0, 1);
    draw_text_outline(posX, posY + 10, "SETTINGS", 1, 0, 32, 4, 100, 16777215, 1);
    var textOffsetX = 66;
    var textOffsetY = 51;
    var rowSpacingY = 34;
    var toggleOffsetX = 81;
    var toggleOffsetY = 56;
    if (!changingName)
    {
        for (var i = 0; i < 4; i++)
        {
            var screensize = 1;
            if (MouseOverButton("long", posX + 12, posY + 43 + (i * 34), 1))
            {
                if (currentSettingsOption != i && obj_InputManager.MouseMoved() && !deleteConfirm)
                {
                    currentSettingsOption = i;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                if (currentSettingsOption == i && mouse_check_button_pressed(mb_left))
                {
                    ClickButton();
                }
            }
        }
        if (MouseOverButton("long", posX + 12, posY + 43 + 204, 1) && !deleteConfirm)
        {
            if (currentSettingsOption != UnknownEnum.Value_4 && obj_InputManager.MouseMoved())
            {
                currentSettingsOption = UnknownEnum.Value_4;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (currentSettingsOption == UnknownEnum.Value_4 && mouse_check_button_pressed(mb_left))
            {
                ClickButton();
            }
        }
    }
    for (var i = 0; i < 4; i++)
    {
        draw_set_font(Galmuri9);
        draw_set_halign(fa_left);
        currentSelection = (i == currentSettingsOption) ? 1 : 0;
        draw_sprite(hud_OptionButton, currentSelection, posX + 12, posY + 43 + (i * rowSpacingY));
        draw_sprite(hud_hiscoreOptionIcons, (i * 2) + currentSelection, posX - 98, posY + 56 + (i * rowSpacingY));
        if (i == UnknownEnum.Value_3)
        {
            draw_text_color(posX - textOffsetX, posY + textOffsetY + (i * rowSpacingY), global.TextContainer.hiScoreOptions.selectedLanguage[i], c_red, c_red, c_red, c_red, 1);
        }
        else
        {
            draw_text_color(posX - textOffsetX, posY + textOffsetY + (i * rowSpacingY), global.TextContainer.hiScoreOptions.selectedLanguage[i], selectedColor[currentSelection], selectedColor[currentSelection], selectedColor[currentSelection], selectedColor[currentSelection], 1);
        }
        switch (i)
        {
            case UnknownEnum.Value_1:
                draw_sprite(hud_toggleButton, global.hiscorenames + (2 * currentSelection), posX + toggleOffsetX, posY + toggleOffsetY + (i * rowSpacingY));
                break;
            case UnknownEnum.Value_2:
                draw_sprite(hud_toggleButton, global.hiscoreName + (2 * currentSelection), posX + toggleOffsetX, posY + toggleOffsetY + (i * rowSpacingY));
                break;
            case UnknownEnum.Value_3:
                draw_set_halign(fa_center);
                if (deleteScoresCounter == 2)
                {
                    draw_text_scribble(posX, posY + textOffsetY + ((i + 1) * rowSpacingY), global.TextContainer.hiScoreOptions.selectedLanguage[5]);
                }
                break;
        }
    }
    draw_set_font(Galmuri9);
    draw_set_halign(fa_left);
    var currentSelection = (currentSettingsOption == UnknownEnum.Value_4) ? 1 : 0;
    draw_sprite(hud_OptionButton, currentSelection, posX + 12, posY + 43 + (6 * rowSpacingY));
    draw_text_color(posX - textOffsetX, posY + textOffsetY + (6 * rowSpacingY), global.TextContainer.hiscoreButtons.selectedLanguage[UnknownEnum.Value_6], selectedColor[currentSelection], selectedColor[currentSelection], selectedColor[currentSelection], selectedColor[currentSelection], 1);
    if (deleteConfirm)
    {
        commandPromps(true, true, true);
        draw_sprite(hud_quitConfirm, 0, pauseContainer[0], pauseContainer[1] + 40);
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_set_alpha(1);
        draw_text_scribble(pauseContainer[0], pauseContainer[1] + 53, global.TextContainer.hiScoreOptions.selectedLanguage[4]);
        for (var i = 0; i < 2; i++)
        {
            if (deleteOption == i)
            {
                draw_sprite(hud_confirmButton, 0, pauseContainer[0], pauseContainer[1] + 35 + 62 + (i * 30));
            }
            else
            {
                draw_sprite(hud_unselectButton, 0, pauseContainer[0], pauseContainer[1] + 35 + 62 + (i * 30));
            }
            if (MouseOverButton("short", pauseContainer[0], pauseContainer[1] + 35 + 62 + (i * 30)))
            {
                if (deleteOption != i && obj_InputManager.MouseMoved())
                {
                    deleteOption = i;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                if (i == deleteOption)
                {
                    ClickButton();
                }
            }
        }
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        if (deleteOption == 0)
        {
            draw_set_color(c_black);
        }
        else
        {
            draw_set_color(c_white);
        }
        draw_text_scribble(pauseContainer[0], pauseContainer[1] + 35 + 56, global.TextContainer.yesno.selectedLanguage[0]);
        if (deleteOption == 1)
        {
            draw_set_color(c_black);
        }
        else
        {
            draw_set_color(c_white);
        }
        draw_text_scribble(pauseContainer[0], pauseContainer[1] + 35 + 86, global.TextContainer.yesno.selectedLanguage[1]);
    }
}
if (changingName)
{
    var boxY = 130;
    draw_sprite(spr_option_widebox, 0, 320, boxY);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    draw_text_outline(320, boxY + 15, global.TextContainer.renameText.selectedLanguage, 1, 0, 16, 10, 200, 16777215, 1);
    if (canType)
    {
        var recruitBox = [170, 145];
        draw_set_halign(fa_left);
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_rectangle((recruitBox[0] - 65) + 125, recruitBox[1] + 30, ((recruitBox[0] + 130) - 65) + 175, recruitBox[1] + 30 + 20, false);
        draw_set_color(c_white);
        draw_set_alpha(1);
        draw_rectangle((recruitBox[0] - 65) + 125, recruitBox[1] + 30, ((recruitBox[0] + 130) - 65) + 175, recruitBox[1] + 30 + 20, true);
        draw_text_scribble((recruitBox[0] + 125 + 9) - 65, recruitBox[1] + 30 + 5, editingName);
        if (rectVis && renameOption == -1)
        {
            draw_rectangle(((recruitBox[0] + 125) - 56) + string_width(editingName), recruitBox[1] + 30 + 4, ((recruitBox[0] + 125) - 56) + string_width(editingName) + 7, recruitBox[1] + 30 + 16, false);
        }
        var screensize = 1 / global.camera_scale;
        if (((mouse_x - camera_get_view_x(view_camera[0])) >= (((recruitBox[0] - 65) + 125) * screensize) && (mouse_x - camera_get_view_x(view_camera[0])) < ((((recruitBox[0] + 130) - 65) + 175) * screensize) && (mouse_y - camera_get_view_y(view_camera[0])) >= ((recruitBox[1] + 30) * screensize) && (mouse_y - camera_get_view_y(view_camera[0])) < ((recruitBox[1] + 30 + 20) * screensize)) && mouse_check_button_pressed(mb_left))
        {
            if (renameOption != -1)
            {
                renameOption = -1;
                audio_play_sound(snd_menu_confirm, 30, 0);
            }
        }
        for (var j = 0; j < 2; j++)
        {
            if (renameOption == j)
            {
                draw_sprite(hud_confirmButton, 0, recruitBox[0] + 100 + (j * 100), recruitBox[1] + 70);
            }
            else
            {
                draw_sprite(hud_unselectButton, 0, recruitBox[0] + 100 + (j * 100), recruitBox[1] + 70);
            }
            if (MouseOverButton("short", recruitBox[0] + 100 + (j * 100), recruitBox[1] + 70, 2))
            {
                if (renameOption != j && obj_InputManager.MouseMoved())
                {
                    renameOption = j;
                    audio_play_sound(snd_menu_select, 30, 0);
                }
                if (j == renameOption)
                {
                    ClickButton();
                }
            }
            draw_set_halign(fa_center);
            draw_set_color(selectedColor[j == renameOption]);
            draw_text_scribble(recruitBox[0] + 100 + (j * 100), recruitBox[1] + 65, global.TextContainer.farmConfirm.selectedLanguage[j]);
        }
    }
}

enum UnknownEnum
{
    Value_m1 = -1,
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8
}
