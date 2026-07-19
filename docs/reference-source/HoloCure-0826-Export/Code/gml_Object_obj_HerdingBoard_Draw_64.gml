var selectedColor = [16777215, 0];
rectTime++;
if (rectTime >= 20)
{
    rectTime = 0;
    rectVis = -rectVis;
}
if (interacting)
{
    draw_set_halign(fa_right);
    draw_sprite(spr_SandWindow, 0, 488, 20);
    draw_sprite(spr_SandWindow, 0, 338, 20);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    draw_text_scribble(610, 26, ds_map_find_value(global.PlayerSave, "holoCoins"));
    draw_sprite(spr_holoCoin, 0, 505, 30);
    draw_set_alpha(0.5);
    draw_healthbar(341, 22, 467, 40, (ds_map_find_value(global.PlayerSave, "manageEXP") / manageNextEXP) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
    draw_set_alpha(1);
    draw_text_scribble(460, 26, ds_map_find_value(global.PlayerSave, "manageLevel"));
    draw_set_halign(fa_left);
    draw_text_scribble(350, 26, global.TextContainer.workerLevelText.selectedLanguage);
    switch (pauseMenu)
    {
        case -1:
            if (menuContainer[0] != 110)
            {
                menuContainer[0] += 80;
            }
            if (menuContainer[0] > 110)
            {
                menuContainer[0] = 110;
            }
            commandPromps(true, true, true);
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = true;
                if (instance_exists(obj_DialogueController) && obj_DialogueController.showingDialogue)
                {
                    valid = false;
                    draw_set_alpha(0.5);
                }
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.herdOptions.selectedLanguage[i]);
                if (MouseOverButton("levelButton", menuContainer[0], menuContainer[1] + (i * 30)))
                {
                    if (obj_InputManager.MouseMoved() && pauseOption != i && canControl)
                    {
                        pauseOption = i;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    if (pauseOption == i)
                    {
                        ClickButton();
                    }
                }
                draw_set_alpha(1);
            }
            break;
        case UnknownEnum.Value_0:
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = false;
                draw_set_alpha(0.5);
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.herdOptions.selectedLanguage[i]);
                draw_set_alpha(1);
            }
            if (inventoryMenu[0] > 200)
            {
                inventoryMenu[0] -= 100;
            }
            else
            {
                inventoryMenu[0] = 200;
            }
            draw_sprite(spr_inventoryWindow, 0, inventoryMenu[0], inventoryMenu[1]);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri14);
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.herdTitles.selectedLanguage[0]);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            if (array_length(workers) == 0)
            {
                draw_text_scribble(inventoryMenu[0] + 30, inventoryMenu[1] + 50, global.TextContainer.noWorkers.selectedLanguage);
            }
            draw_text_scribble(inventoryMenu[0] + 330, inventoryMenu[1] + 20, string(array_length(workers)) + " / 10");
            var spacing = 75;
            for (var i = 0; i < min(3, array_length(workers)); i++)
            {
                draw_set_halign(fa_left);
                if (inventorySelect == i && array_length(recruits) > 0)
                {
                    draw_sprite(spr_holoCursor, animationTime div 10, inventoryMenu[0] + 22, inventoryMenu[1] + 60 + 15 + (i * spacing));
                    draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle(inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing), inventoryMenu[0] + 380, inventoryMenu[1] + 60 + 50 + (i * spacing), false);
                    draw_set_alpha(1);
                }
                if (MouseOverButton("largeShopMenu", inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing)) && !removeConfirm)
                {
                    if (!manageConfirm && inventorySelect != i && obj_InputManager.MouseMoved())
                    {
                        inventorySelect = i;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (!manageConfirm && inventorySelect == i)
                    {
                        ClickButton();
                    }
                }
                if (canType && inventorySelect == i)
                {
                    var recruitBox = [inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing)];
                    draw_sprite(workers[i + startingPosition][0].sprite, animationTime div 10, recruitBox[0] + 25, recruitBox[1] + 60);
                    draw_text_scribble(recruitBox[0] + 115, recruitBox[1] + 10, global.TextContainer.workerEnterName.selectedLanguage);
                    draw_set_halign(fa_left);
                    draw_rectangle((recruitBox[0] - 65) + 125, recruitBox[1] + 30, ((recruitBox[0] + 130) - 65) + 175, recruitBox[1] + 30 + 20, true);
                    draw_text_scribble((recruitBox[0] + 125 + 9) - 65, recruitBox[1] + 30 + 5, renameString);
                    if (rectVis && renameOption == -1)
                    {
                        draw_rectangle(((recruitBox[0] + 125) - 56) + string_width(renameString), recruitBox[1] + 30 + 4, ((recruitBox[0] + 125) - 56) + string_width(renameString) + 7, recruitBox[1] + 30 + 16, false);
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
                            draw_sprite(hud_confirmButton, 0, recruitBox[0] + 300, recruitBox[1] + 20 + (j * 30));
                        }
                        else
                        {
                            draw_sprite(hud_unselectButton, 0, recruitBox[0] + 300, recruitBox[1] + 20 + (j * 30));
                        }
                        if (MouseOverButton("short", recruitBox[0] + 300, recruitBox[1] + 20 + (j * 30), 2) && !removeConfirm)
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
                        draw_text_scribble(recruitBox[0] + 300, recruitBox[1] + 14 + (j * 30), global.TextContainer.farmConfirm.selectedLanguage[j]);
                    }
                }
                else if (manageConfirm && i == inventorySelect)
                {
                    var recruitBox = [inventoryMenu[0] + 30, (inventoryMenu[1] + 60) - 20];
                    draw_sprite(workers[i + startingPosition][0].sprite, animationTime div 10, recruitBox[0] + 25, recruitBox[1] + 60 + (i * spacing));
                    for (var j = 0; j < 2; j++)
                    {
                        draw_set_halign(fa_center);
                        draw_sprite_ext(hud_LevelButton, workerOption == (j * 2), recruitBox[0] + 110 + (j * 150), recruitBox[1] + 10 + (i * spacing), 1, 1, 0, c_white, 1);
                        draw_set_color(selectedColor[workerOption == (j * 2)]);
                        draw_text_scribble(recruitBox[0] + 110 + (j * 150), recruitBox[1] + 15 + (spacing * i), global.TextContainer.workerOptions.selectedLanguage[0 + (j * 2)]);
                        if (MouseOverButton("levelButton", recruitBox[0] + 110 + (j * 150), recruitBox[1] + 10 + (spacing * i), 2) && !removeConfirm)
                        {
                            if (workerOption != (j * 2) && obj_InputManager.MouseMoved())
                            {
                                workerOption = j * 2;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                            if (workerOption == (j * 2))
                            {
                                ClickButton();
                            }
                        }
                        draw_sprite_ext(hud_LevelButton, workerOption == ((j * 2) + 1), recruitBox[0] + 110 + (j * 150), recruitBox[1] + 10 + 30 + (i * spacing), 1, 1, 0, c_white, 1);
                        draw_set_color(selectedColor[workerOption == ((j * 2) + 1)]);
                        draw_text_scribble(recruitBox[0] + 110 + (j * 150), recruitBox[1] + 30 + 15 + (spacing * i), global.TextContainer.workerOptions.selectedLanguage[1 + (j * 2)]);
                        if (MouseOverButton("levelButton", recruitBox[0] + 110 + (j * 150), recruitBox[1] + 30 + 10 + (spacing * i), 2) && !removeConfirm)
                        {
                            if (workerOption != ((j * 2) + 1) && obj_InputManager.MouseMoved())
                            {
                                workerOption = (j * 2) + 1;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                            if (workerOption == ((j * 2) + 1))
                            {
                                ClickButton();
                            }
                        }
                        draw_set_alpha(1);
                    }
                }
                else
                {
                    draw_set_color(c_white);
                    var recruitBox = [inventoryMenu[0] + 30, (inventoryMenu[1] + 60) - 20];
                    draw_sprite(workers[i + startingPosition][0].sprite, animationTime div 10, recruitBox[0] + 25, recruitBox[1] + 60 + (i * spacing));
                    var tierColor = "[c_white]";
                    switch (workers[i + startingPosition][0].tier)
                    {
                        case 0:
                            tierColor = "[c_white]";
                            break;
                        case 1:
                            tierColor = "[c_green]";
                            break;
                        case 2:
                            tierColor = "[c_yellow]";
                            break;
                        case 3:
                            tierColor = "[c_pink]";
                            break;
                    }
                    draw_text_scribble(recruitBox[0] + 25, recruitBox[1] + 5 + (i * spacing), tierColor + workers[i + startingPosition][0].recruitName + "[/color]");
                    draw_sprite(spr_Tiers, workers[i + startingPosition][0].tier, recruitBox[0] + 11, recruitBox[1] + 10 + (i * spacing));
                    draw_set_halign(fa_left);
                    draw_healthbar(recruitBox[0] + 108, recruitBox[1] + 58 + (i * spacing), recruitBox[0] + 152, recruitBox[1] + 64 + (i * spacing), (workers[i + startingPosition][1].currentStamina / workers[i + startingPosition][0].maxStamina) * 100, c_red, c_yellow, c_yellow, 0, 0, 0);
                    draw_healthbar(recruitBox[0] + 108, recruitBox[1] + 43 + (i * spacing), recruitBox[0] + 152, recruitBox[1] + 49 + (i * spacing), (workers[i + startingPosition][0].currentEXP / workers[i + startingPosition][0].nextEXP) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
                    var workerLevel = string(workers[i + startingPosition][0].currentLevel) + " / " + string(workers[i + startingPosition][0].maxLevel);
                    draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 25 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[1] + workerLevel);
                    draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 55 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[2]);
                    draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 40 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[3]);
                    draw_text_scribble(recruitBox[0] + 160, recruitBox[1] + 55 + (i * spacing), string(workers[i + startingPosition][1].currentStamina) + " / " + string(workers[i + startingPosition][1].maxStamina));
                    draw_text_scribble(recruitBox[0] + 160, recruitBox[1] + 40 + (i * spacing), string(floor((workers[i + startingPosition][0].currentEXP / workers[i + startingPosition][0].nextEXP) * 100)) + "%");
                    var getFeed = ds_map_find_value(global.InventoryLibrary, workers[i + startingPosition][0].currentFeed);
                    var feedHas = item_get(workers[i + startingPosition][0].currentFeed);
                    var statusColor = "c_white";
                    if (!is_undefined(feedHas) && feedHas > 0)
                    {
                        statusColor = "c_green";
                    }
                    else
                    {
                        statusColor = "c_red";
                    }
                    draw_set_halign(fa_right);
                    var status = "[c_green]" + global.TextContainer.workerStatus.selectedLanguage[1] + "[/color]";
                    if (!workers[i + startingPosition][1].isWorking)
                    {
                        status = "[c_red]" + global.TextContainer.workerStatus.selectedLanguage[0] + "[/color]";
                    }
                    draw_text_scribble(recruitBox[0] + 330, recruitBox[1] + 5 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[0] + status);
                    draw_text_scribble(recruitBox[0] + 330, recruitBox[1] + 20 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[7] + "[" + statusColor + "]" + getFeed.inventoryName + "[/color]");
                    draw_set_halign(fa_left);
                    draw_text_scribble(recruitBox[0] + 227, recruitBox[1] + 55 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[5] + string(workers[i + startingPosition][0].currentCoin));
                    draw_text_scribble(recruitBox[0] + 227, recruitBox[1] + 40 + (i * spacing), global.TextContainer.workerStats.selectedLanguage[6] + string(workers[i + startingPosition][0].totalCollected));
                }
            }
            startingPosition = ScrollBar(workers, inventoryMenu[0] + 387, inventoryMenu[1] + 50, inventoryMenu[1] + 255, 1, 3, startingPosition, !manageConfirm && !removeConfirm && !manageLevelConfirm && !levelUpConfirm);
            if (removeConfirm)
            {
                draw_set_color(c_black);
                draw_set_alpha(0.7);
                draw_rectangle(0, 0, 10000, 10000, false);
                draw_set_alpha(1);
                commandPromps(true, true, true);
                draw_sprite(hud_quitConfirm, 0, pauseContainer[0], pauseContainer[1] + 40);
                draw_set_halign(fa_center);
                draw_set_color(c_white);
                draw_set_font(Galmuri9);
                draw_set_alpha(1);
                draw_text_outline(pauseContainer[0], pauseContainer[1] + 48, global.TextContainer.workerRemove.selectedLanguage, 1, 0, 32, 15, 120, 16777215, 1);
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 160, "[c_red]" + global.TextContainer.workerWarning.selectedLanguage + "[/color]");
                for (var i = 0; i < 2; i++)
                {
                    if (removeOption == i)
                    {
                        draw_sprite(hud_confirmButton, 0, pauseContainer[0], pauseContainer[1] + 35 + 62 + (i * 30));
                    }
                    else
                    {
                        draw_sprite(hud_unselectButton, 0, pauseContainer[0], pauseContainer[1] + 35 + 62 + (i * 30));
                    }
                    if (MouseOverButton("short", pauseContainer[0], pauseContainer[1] + 35 + 62 + (i * 30)))
                    {
                        if (removeOption != i && obj_InputManager.MouseMoved())
                        {
                            removeOption = i;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (i == removeOption)
                        {
                            ClickButton();
                        }
                    }
                }
                draw_set_font(Galmuri9);
                draw_set_halign(fa_center);
                if (removeOption == 0)
                {
                    draw_set_color(c_black);
                }
                else
                {
                    draw_set_color(c_white);
                }
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 35 + 56, global.TextContainer.yesno.selectedLanguage[0]);
                if (removeOption == 1)
                {
                    draw_set_color(c_black);
                }
                else
                {
                    draw_set_color(c_white);
                }
                draw_text_scribble(pauseContainer[0], pauseContainer[1] + 35 + 86, global.TextContainer.yesno.selectedLanguage[1]);
            }
            break;
        case UnknownEnum.Value_1:
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = false;
                draw_set_alpha(0.5);
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.herdOptions.selectedLanguage[i]);
                draw_set_alpha(1);
            }
            if (inventoryMenu[0] > 200)
            {
                inventoryMenu[0] -= 200;
            }
            else
            {
                inventoryMenu[0] = 200;
            }
            draw_sprite(spr_inventoryWindow, 0, inventoryMenu[0], inventoryMenu[1]);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri14);
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.herdTitles.selectedLanguage[1]);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            var spacing = 75;
            for (var i = 0; i < min(3, array_length(recruits)); i++)
            {
                draw_set_halign(fa_left);
                if (inventorySelect == i && array_length(recruits) > 0)
                {
                    draw_sprite(spr_holoCursor, animationTime div 10, inventoryMenu[0] + 22, inventoryMenu[1] + 60 + 15 + (i * spacing));
                    draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle(inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing), inventoryMenu[0] + 380, inventoryMenu[1] + 60 + 50 + (i * spacing), false);
                    draw_set_alpha(1);
                }
                if ((i + startingPosition) == (array_length(recruits) - 1))
                {
                    if (hireConfirm && (inventorySelect + startingPosition) == (array_length(recruits) - 1))
                    {
                        var costText = global.TextContainer.getRecruits.selectedLanguage[1];
                        costText = string_replace(costText, "[cost]", string(hireCost));
                        draw_text_scribble_ext(inventoryMenu[0] + 70, (inventoryMenu[1] + 70 + (i * spacing)) - 15, costText, 400);
                        draw_sprite(spr_shop_advertising, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 75 + (i * spacing));
                        draw_set_halign(fa_center);
                        for (var j = 0; j < 2; j++)
                        {
                            var valid = false;
                            if (array_length(workers) < 10 && ds_map_find_value(global.PlayerSave, "holoCoins") >= hireCost)
                            {
                                valid = true;
                            }
                            draw_sprite_ext(hud_LevelButton, hireSelect == j, ((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 60 + (i * spacing), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                            draw_set_color(selectedColor[hireSelect == j]);
                            draw_text_scribble(((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 5 + 60 + (i * spacing), global.TextContainer.fishRod.selectedLanguage[j + 1]);
                            draw_set_alpha(1);
                            draw_set_color(c_white);
                            if (MouseOverButton("levelButton", ((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 60 + (i * spacing)))
                            {
                                if (obj_InputManager.MouseMoved() && hireSelect != j)
                                {
                                    hireSelect = j;
                                    audio_play_sound(snd_menu_select, 0, 0);
                                }
                                if (hireSelect == j)
                                {
                                    ClickButton();
                                }
                            }
                        }
                    }
                    else
                    {
                        if (array_length(workers) == 10)
                        {
                            draw_set_alpha(0.5);
                        }
                        else
                        {
                            draw_set_alpha(1);
                        }
                        draw_text_scribble_ext(inventoryMenu[0] + 70, inventoryMenu[1] + 70 + (i * spacing), global.TextContainer.getRecruits.selectedLanguage[0], 400);
                        draw_text_scribble(inventoryMenu[0] + 290 + 25, ((inventoryMenu[1] + 60) - 5 - 10) + (i * spacing), "Cost: " + string(hireCost));
                        draw_sprite(spr_holoCoin, 0, (inventoryMenu[0] + 355 + 20) - 75, ((inventoryMenu[1] + 11 + 60) - 5 - 16) + (i * spacing));
                        draw_sprite(spr_shop_advertising, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 75 + (i * spacing));
                        draw_set_alpha(1);
                        if (array_length(workers) == 10)
                        {
                            draw_text_scribble_ext(inventoryMenu[0] + 90, ((inventoryMenu[1] + 70 + (i * spacing)) - 15) + 30, "[c_red]" + global.TextContainer.fullWorkers.selectedLanguage + "[/color]", 300, 12);
                        }
                    }
                }
                else if (hireConfirm && i == inventorySelect)
                {
                    draw_text_scribble_ext(inventoryMenu[0] + 70, (inventoryMenu[1] + 70 + (i * spacing)) - 15, global.TextContainer.getRecruits.selectedLanguage[2], 400);
                    draw_set_halign(fa_center);
                    for (var j = 0; j < 2; j++)
                    {
                        var valid = true;
                        draw_sprite_ext(hud_LevelButton, hireSelect == j, ((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 60 + (i * spacing), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                        draw_set_color(selectedColor[hireSelect == j]);
                        draw_text_scribble(((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 5 + 60 + (i * spacing), global.TextContainer.fishRod.selectedLanguage[j + 1]);
                        draw_set_alpha(1);
                        if (MouseOverButton("levelButton", ((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 60 + (i * spacing)))
                        {
                            if (obj_InputManager.MouseMoved() && hireSelect != j)
                            {
                                hireSelect = j;
                                audio_play_sound(snd_menu_select, 0, 0);
                            }
                            if (hireSelect == j)
                            {
                                ClickButton();
                            }
                        }
                    }
                    draw_set_color(c_white);
                }
                else
                {
                    var recruitBox = [inventoryMenu[0] + 30, (inventoryMenu[1] + 60) - 20];
                    draw_sprite(recruits[i + startingPosition].sprite, animationTime div 10, recruitBox[0] + 25, recruitBox[1] + 60 + (i * spacing));
                    var tierColor = "[c_white]";
                    switch (recruits[i + startingPosition].tier)
                    {
                        case 0:
                            tierColor = "[c_white]";
                            break;
                        case 1:
                            tierColor = "[c_green]";
                            break;
                        case 2:
                            tierColor = "[c_yellow]";
                            break;
                        case 3:
                            tierColor = "[c_pink]";
                            break;
                    }
                    draw_text_scribble(recruitBox[0] + 25, recruitBox[1] + 5 + (i * spacing), tierColor + recruits[i + startingPosition].recruitName + "[/color]");
                    draw_sprite(spr_Tiers, recruits[i + startingPosition].tier, recruitBox[0] + 11, recruitBox[1] + 10 + (i * spacing));
                    draw_text_scribble(recruitBox[0] + 275, recruitBox[1] + 5 + (i * spacing), recruits[i + startingPosition].fanID);
                    for (var j = 0; j < 2; j++)
                    {
                        draw_set_halign(fa_left);
                        draw_text_scribble(recruitBox[0] + 57 + (150 * j), recruitBox[1] + 25 + (i * spacing), global.TextContainer.recruitStats.selectedLanguage[2 + (j * 2)]);
                        draw_set_halign(fa_left);
                        draw_text_scribble(recruitBox[0] + 57 + (150 * j), recruitBox[1] + 25 + (i * spacing) + 25, global.TextContainer.recruitStats.selectedLanguage[3 + (j * 2)]);
                    }
                    var statX = 127;
                    var statY = 20;
                    var spacingY = 25;
                    draw_healthbar(recruitBox[0] + statX, recruitBox[1] + statY + 8 + (i * spacing), recruitBox[0] + statX + 62, recruitBox[1] + statY + 14 + (i * spacing), (recruits[i + startingPosition].efficiency / 10) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
                    draw_healthbar(recruitBox[0] + statX, recruitBox[1] + statY + 8 + spacingY + (i * spacing), recruitBox[0] + statX + 62, recruitBox[1] + statY + 14 + spacingY + (i * spacing), (recruits[i + startingPosition].maxStamina / 85) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
                    draw_healthbar(recruitBox[0] + statX + 150, recruitBox[1] + statY + 8 + (i * spacing), recruitBox[0] + statX + 62 + 150, recruitBox[1] + statY + 14 + (i * spacing), (recruits[i + startingPosition].maxLevel / 50) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
                    draw_healthbar(recruitBox[0] + statX + 150, recruitBox[1] + statY + 8 + spacingY + (i * spacing), recruitBox[0] + statX + 62 + 150, recruitBox[1] + statY + 14 + spacingY + (i * spacing), ((recruits[i + startingPosition].exprate - 1) / 0.5) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
                    draw_set_halign(fa_right);
                    draw_text_scribble(recruitBox[0] + statX + 60, recruitBox[1] + statY + 5 + (i * spacing), string(recruits[i + startingPosition].efficiency));
                    draw_text_scribble(recruitBox[0] + statX + 60, recruitBox[1] + statY + 5 + spacingY + (i * spacing), string(recruits[i + startingPosition].maxStamina));
                    draw_text_scribble(recruitBox[0] + statX + 60 + 150, recruitBox[1] + statY + 5 + (i * spacing), string(recruits[i + startingPosition].maxLevel));
                    draw_text_scribble(recruitBox[0] + statX + 60 + 150, recruitBox[1] + statY + 5 + spacingY + (i * spacing), string(recruits[i + startingPosition].exprate));
                }
                if (MouseOverButton("largeShopMenu", inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing)))
                {
                    if (!hireConfirm && inventorySelect != i && obj_InputManager.MouseMoved())
                    {
                        inventorySelect = i;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (inventorySelect == i)
                    {
                        ClickButton();
                    }
                }
            }
            startingPosition = ScrollBar(recruits, inventoryMenu[0] + 387, inventoryMenu[1] + 50, inventoryMenu[1] + 255, 1, 3, startingPosition, !removeConfirm && !manageLevelConfirm && !levelUpConfirm && !hireConfirm);
            break;
        case UnknownEnum.Value_2:
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = false;
                draw_set_alpha(0.5);
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.herdOptions.selectedLanguage[i]);
                draw_set_alpha(1);
            }
            if (inventoryMenu[0] > 200)
            {
                inventoryMenu[0] -= 100;
            }
            else
            {
                inventoryMenu[0] = 200;
            }
            draw_set_font(Galmuri14);
            draw_sprite(spr_inventoryWindow, 0, inventoryMenu[0], inventoryMenu[1]);
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.herdTitles.selectedLanguage[2]);
            draw_set_font(Galmuri9);
            for (var i = 0; i < array_length(workers); i++)
            {
                var coinText = string(workers[i][0].currentCoin);
                draw_sprite(workers[i][0].sprite, 0, inventoryMenu[0] + 50 + ((i % 5) * 75), inventoryMenu[1] + 90 + ((i div 5) * 90));
                draw_set_halign(fa_center);
                draw_set_color(c_white);
                draw_sprite(spr_holoCoin, 0, (inventoryMenu[0] + 50 + ((i % 5) * 75)) - (string_width(coinText) / 2) - 8, inventoryMenu[1] + 104 + ((i div 5) * 90));
                draw_text(inventoryMenu[0] + 50 + ((i % 5) * 75) + 5, inventoryMenu[1] + 100 + ((i div 5) * 90), coinText);
            }
            draw_set_halign(fa_right);
            draw_rectangle(inventoryMenu[0] + 30, inventoryMenu[1] + 225, inventoryMenu[0] + 385, inventoryMenu[1] + 226, false);
            draw_set_font(Galmuri9);
            draw_text_scribble(inventoryMenu[0] + 250, inventoryMenu[1] + 244, "Total: ");
            draw_set_font(Galmuri14);
            draw_set_halign(fa_right);
            var totalSale = 0;
            for (var i = 0; i < array_length(workers); i++)
            {
                totalSale += workers[i][0].currentCoin;
            }
            draw_text_scribble(inventoryMenu[0] + 370, inventoryMenu[1] + 237, totalSale);
            draw_rectangle(inventoryMenu[0] + 255, inventoryMenu[1] + 233, inventoryMenu[0] + 375, inventoryMenu[1] + 265, true);
            draw_sprite(hud_confirmButton, 0, inventoryMenu[0] + 85, inventoryMenu[1] + 249);
            draw_set_color(c_black);
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            draw_text_scribble(inventoryMenu[0] + 85, inventoryMenu[1] + 244, global.TextContainer.recruitCollect.selectedLanguage);
            if (MouseOverButton("short", inventoryMenu[0] + 85, inventoryMenu[1] + 249))
            {
                ClickButton();
            }
            draw_sprite(spr_holoCursor, animationTime div 10, inventoryMenu[0] + 22, inventoryMenu[1] + 249);
            draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
            draw_set_color(c_white);
            draw_rectangle(inventoryMenu[0] + 35, (inventoryMenu[1] + 249) - 19, inventoryMenu[0] + 380, inventoryMenu[1] + 249 + 19, false);
            draw_set_alpha(1);
            break;
        case UnknownEnum.Value_5:
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = false;
                draw_set_alpha(0.5);
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.herdOptions.selectedLanguage[i]);
                draw_set_alpha(1);
            }
            if (inventoryMenu[0] > 200)
            {
                inventoryMenu[0] -= 200;
            }
            else
            {
                inventoryMenu[0] = 200;
            }
            draw_sprite(spr_inventoryWindow, 0, inventoryMenu[0], inventoryMenu[1]);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri14);
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.herdTitles.selectedLanguage[3]);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            draw_set_halign(fa_left);
            var recruitBox = [inventoryMenu[0] + 30, (inventoryMenu[1] + 60) - 20];
            draw_sprite(workers[inventorySelect + startingPosition][0].sprite, animationTime div 10, recruitBox[0] + 25, recruitBox[1] + 60);
            var tierColor = "[c_white]";
            switch (workers[inventorySelect + startingPosition][0].tier)
            {
                case 0:
                    tierColor = "[c_white]";
                    break;
                case 1:
                    tierColor = "[c_green]";
                    break;
                case 2:
                    tierColor = "[c_yellow]";
                    break;
                case 3:
                    tierColor = "[c_pink]";
                    break;
            }
            draw_text_scribble(recruitBox[0] + 5, recruitBox[1] + 5, tierColor + workers[inventorySelect + startingPosition][0].recruitName + "[/color]");
            draw_set_halign(fa_left);
            var status = "[c_green]" + global.TextContainer.workerStatus.selectedLanguage[1] + "[/color]";
            if (!workers[inventorySelect + startingPosition][1].isWorking)
            {
                status = "[c_red]" + global.TextContainer.workerStatus.selectedLanguage[0] + "[/color]";
            }
            draw_text_scribble(recruitBox[0] + 5 + 200, recruitBox[1] + 5, global.TextContainer.workerStats.selectedLanguage[0] + status);
            draw_healthbar(recruitBox[0] + 108, recruitBox[1] + 58, recruitBox[0] + 152, recruitBox[1] + 64, (workers[inventorySelect + startingPosition][1].currentStamina / workers[inventorySelect + startingPosition][0].maxStamina) * 100, c_red, c_yellow, c_yellow, 0, 0, 0);
            draw_healthbar(recruitBox[0] + 108, recruitBox[1] + 43, recruitBox[0] + 152, recruitBox[1] + 49, (workers[inventorySelect + startingPosition][0].currentEXP / workers[inventorySelect + startingPosition][0].nextEXP) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
            var workerLevel = string(workers[inventorySelect + startingPosition][0].currentLevel) + " / " + string(workers[inventorySelect + startingPosition][0].maxLevel);
            draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 25, global.TextContainer.workerStats.selectedLanguage[1] + workerLevel);
            draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 55, global.TextContainer.workerStats.selectedLanguage[2]);
            draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 40, global.TextContainer.workerStats.selectedLanguage[3]);
            draw_text_scribble(recruitBox[0] + 160, recruitBox[1] + 55, string(workers[inventorySelect + startingPosition][0].currentStamina) + " / " + string(workers[inventorySelect + startingPosition][0].maxStamina));
            draw_text_scribble(recruitBox[0] + 160, recruitBox[1] + 40, string(floor((workers[inventorySelect + startingPosition][0].currentEXP / workers[inventorySelect + startingPosition][0].nextEXP) * 100)) + "%");
            draw_text_scribble(recruitBox[0] + 227, recruitBox[1] + 40, global.TextContainer.workerStats.selectedLanguage[5] + string(workers[inventorySelect + startingPosition][0].currentCoin));
            draw_text_scribble(recruitBox[0] + 227, recruitBox[1] + 55, global.TextContainer.workerStats.selectedLanguage[6] + string(workers[inventorySelect + startingPosition][0].totalCollected));
            draw_sprite(spr_Tiers, workers[inventorySelect + startingPosition][0].tier, recruitBox[0] + 337, recruitBox[1] + 10);
            var statX = 127;
            var statY = 20;
            var spacingY = 25;
            draw_set_halign(fa_left);
            draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 55 + spacingY, global.TextContainer.recruitStats.selectedLanguage[2] + " " + string(workers[inventorySelect + startingPosition][0].efficiency));
            draw_set_halign(fa_left);
            draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 55 + spacingY + 15, global.TextContainer.recruitStats.selectedLanguage[5] + " " + string(workers[inventorySelect + startingPosition][0].exprate));
            draw_text_scribble(recruitBox[0] + 57, recruitBox[1] + 120, global.TextContainer.workerFood.selectedLanguage);
            draw_sprite(hud_optionIconCase, 0, recruitBox[0] + 57 + 20, recruitBox[1] + 155);
            if (workers[inventorySelect + startingPosition][0].currentFeed != -1)
            {
                var getFeed = ds_map_find_value(global.InventoryLibrary, workers[inventorySelect + startingPosition][0].currentFeed);
                draw_sprite(getFeed.inventoryIcon, 0, recruitBox[0] + 57 + 20, recruitBox[1] + 155);
                draw_text_scribble(recruitBox[0] + 57 + 45, recruitBox[1] + 150, getFeed.inventoryName);
            }
            break;
        case UnknownEnum.Value_6:
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = false;
                draw_set_alpha(0.5);
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.herdOptions.selectedLanguage[i]);
                draw_set_alpha(1);
            }
            if (inventoryMenu[0] > 200)
            {
                inventoryMenu[0] -= 200;
            }
            else
            {
                inventoryMenu[0] = 200;
            }
            var confirm = [390, 135];
            draw_sprite(spr_feedWindow, 0, confirm[0] - 190, confirm[1]);
            draw_set_halign(fa_center);
            draw_set_color(c_white);
            draw_text_scribble((confirm[0] - 190) + 90, confirm[1] + 25, workers[inventorySelect + startingPosition][0].recruitName);
            draw_sprite(workers[inventorySelect + startingPosition][0].sprite, animationTime div 10, (confirm[0] - 190) + 90, confirm[1] + 90);
            draw_sprite_ext(menu_charselec_morearrow, animationTime div 5, (confirm[0] - 190) + 90, confirm[1] + 10, 1, -1, 0, c_white, 1);
            if (MouseOverButton("longArrow", (confirm[0] - 190) + 90, confirm[1] + 10) && !feedConfirm)
            {
                if (mouse_check_button_pressed(mb_left))
                {
                    SelectUp();
                }
            }
            draw_sprite_ext(menu_charselec_morearrow, animationTime div 5, (confirm[0] - 190) + 90, confirm[1] + 110, 1, 1, 0, c_white, 1);
            if (MouseOverButton("longArrow", (confirm[0] - 190) + 90, confirm[1] + 110) && !feedConfirm)
            {
                if (mouse_check_button_pressed(mb_left))
                {
                    SelectDown();
                }
            }
            draw_sprite(hud_farmConfirmWindow, 0, confirm[0], confirm[1]);
            draw_set_halign(fa_left);
            draw_set_color(c_white);
            draw_text_scribble((confirm[0] + 112) - 40, confirm[1] + 5, global.TextContainer.workerStats.selectedLanguage[1]);
            draw_text_scribble((confirm[0] + 112) - 40, confirm[1] + 35, global.TextContainer.workerStats.selectedLanguage[2]);
            draw_text_scribble((confirm[0] + 112) - 40, confirm[1] + 20, global.TextContainer.workerStats.selectedLanguage[3]);
            var getFeed = ds_map_find_value(global.InventoryLibrary, workers[inventorySelect + startingPosition][0].currentFeed);
            if (workers[inventorySelect + startingPosition][0].currentFeed != -1)
            {
                draw_set_halign(fa_center);
                draw_text_scribble((confirm[0] + 112) - 70, confirm[1] + 45, getFeed.inventoryName);
                draw_sprite(getFeed.inventoryIcon, 0, (confirm[0] + 112) - 70, confirm[1] + 25);
            }
            draw_sprite(hud_optionIconCase, 0, (confirm[0] + 112) - 70, confirm[1] + 25);
            var showingLevel = workers[inventorySelect + startingPosition][0].currentLevel;
            var staminaHeal = feedAmount * floor(workers[inventorySelect + startingPosition][0].maxStamina * 0.2);
            var expGain = feedAmount * workers[inventorySelect + startingPosition][0].exprate * (1 + getFeed.config.tier);
            var extraLevels = 0;
            if (workers[inventorySelect + startingPosition][0].currentLevel == workers[inventorySelect + startingPosition][0].maxLevel)
            {
                expGain = 0;
            }
            draw_set_halign(fa_left);
            var levelUp = "[c_white]";
            if ((workers[inventorySelect + startingPosition][0].currentEXP + expGain) >= workers[inventorySelect + startingPosition][0].nextEXP)
            {
                extraLevels++;
                levelUp = "[c_green]";
            }
            draw_text_scribble(confirm[0] + 112 + 75, confirm[1] + 5, levelUp + string(showingLevel + extraLevels) + "[/color]");
            var stamText = string(workers[inventorySelect + startingPosition][0].currentStamina);
            var expText = string(floor((workers[inventorySelect + startingPosition][0].currentEXP / workers[inventorySelect + startingPosition][0].nextEXP) * 100)) + "%";
            if (staminaHeal > 0)
            {
                stamText = "[c_green]" + string(min(workers[inventorySelect + startingPosition][0].maxStamina, workers[inventorySelect + startingPosition][0].currentStamina + staminaHeal)) + "[/color]";
            }
            if (expGain > 0)
            {
                expText = "[c_green]" + string(min(100, floor(((workers[inventorySelect + startingPosition][0].currentEXP + expGain) / workers[inventorySelect + startingPosition][0].nextEXP) * 100))) + "%" + "[/color]";
            }
            draw_text_scribble(confirm[0] + 112 + 75, confirm[1] + 35, stamText);
            draw_text_scribble(confirm[0] + 112 + 75, confirm[1] + 20, expText);
            draw_set_halign(fa_center);
            var inventoryAmount = item_get(getFeed.inventoryID);
            if (is_undefined(inventoryAmount))
            {
                inventoryAmount = 0;
            }
            draw_sprite(hud_scrollArrows3, 0, (confirm[0] + 112) - 50, confirm[1] + 65);
            if (MouseOverButton("arrow", (confirm[0] + 112) - 50, confirm[1] + 65) && !feedConfirm)
            {
                if (mouse_check_button_pressed(mb_left))
                {
                    SelectLeft();
                }
            }
            draw_sprite(hud_scrollArrows3, 1, confirm[0] + 112 + 50, confirm[1] + 65);
            if (MouseOverButton("arrow", confirm[0] + 112 + 50, confirm[1] + 65) && !feedConfirm)
            {
                if (mouse_check_button_pressed(mb_left))
                {
                    SelectRight();
                }
            }
            draw_text_scribble(confirm[0] + 112, confirm[1] + 60, string(feedAmount) + " / " + string(inventoryAmount));
            draw_set_alpha(0.8 + (0.2 * sin(cursorTime / 10)));
            draw_healthbar(confirm[0] + 112 + 15, confirm[1] + 38, confirm[0] + 112 + 65, confirm[1] + 44, ((workers[inventorySelect + startingPosition][1].currentStamina + staminaHeal) / workers[inventorySelect + startingPosition][0].maxStamina) * 100, c_red, c_yellow, c_yellow, 0, 0, 0);
            draw_healthbar(confirm[0] + 112 + 15, confirm[1] + 23, confirm[0] + 112 + 65, confirm[1] + 29, ((workers[inventorySelect + startingPosition][0].currentEXP + expGain) / workers[inventorySelect + startingPosition][0].nextEXP) * 100, c_red, c_yellow, c_yellow, 0, 0, 0);
            draw_set_alpha(1);
            draw_healthbar(confirm[0] + 112 + 15, confirm[1] + 38, confirm[0] + 112 + 65, confirm[1] + 44, (workers[inventorySelect + startingPosition][1].currentStamina / workers[inventorySelect + startingPosition][0].maxStamina) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
            draw_healthbar(confirm[0] + 112 + 15, confirm[1] + 23, confirm[0] + 112 + 65, confirm[1] + 29, (workers[inventorySelect + startingPosition][0].currentEXP / workers[inventorySelect + startingPosition][0].nextEXP) * 100, c_red, make_color_rgb(58, 202, 255), make_color_rgb(58, 202, 255), 0, 0, 0);
            if (feedConfirm)
            {
                for (var j = 0; j < 2; j++)
                {
                    var valid = true;
                    draw_sprite_ext(hud_confirmButton2, feedSelect == j, ((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 97, 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                    draw_set_color(selectedColor[feedSelect == j]);
                    draw_text_scribble(((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 91, global.TextContainer.farmConfirm.selectedLanguage[j]);
                    draw_set_alpha(1);
                    if (MouseOverButton("short", ((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 97))
                    {
                        if (feedSelect != j && obj_InputManager.MouseMoved())
                        {
                            feedSelect = j;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (j == feedSelect)
                        {
                            ClickButton();
                        }
                    }
                }
            }
            else if (mouse_check_button_pressed(mb_left) && !MouseOverButton("arrow", (confirm[0] + 112) - 50, confirm[1] + 65) && !MouseOverButton("arrow", confirm[0] + 112 + 50, confirm[1] + 65) && !MouseOverButton("longArrow", (confirm[0] - 190) + 90, confirm[1] + 10) && !MouseOverButton("longArrow", (confirm[0] - 190) + 90, confirm[1] + 110))
            {
                ClickButton();
            }
            break;
    }
    if (levelUpConfirm && levelUpTimer >= waitTime)
    {
        if (resultsContainer[1] < 110)
        {
            resultsContainer[1] += 40;
        }
        else
        {
            resultsContainer[1] = 110;
        }
        draw_sprite(hud_fishingResults, 0, resultsContainer[0], resultsContainer[1]);
        draw_set_font(Galmuri14);
        draw_set_halign(fa_center);
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 10, "LEVEL UP!", 2, 0, 16, 4, 200, 16777215, 1);
        draw_sprite(hud_confirmButton, 0, resultsContainer[0], resultsContainer[1] + 155);
        draw_set_font(Galmuri9);
        draw_set_color(c_black);
        draw_text_scribble(resultsContainer[0], resultsContainer[1] + 150, "OK");
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_halign(fa_left);
        draw_text_outline(resultsContainer[0] - 70, resultsContainer[1] + 70, "LVL ", 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] - 70, resultsContainer[1] + 90, global.TextContainer.recruitStats.selectedLanguage[2], 1, 0, 16, 4, 200, 16777215, 1);
        draw_text_outline(resultsContainer[0] - 70, resultsContainer[1] + 110, global.TextContainer.recruitStats.selectedLanguage[3], 1, 0, 16, 4, 200, 16777215, 1);
        draw_set_halign(fa_center);
        draw_text_outline(resultsContainer[0] + 5, resultsContainer[1] + 70, string(workers[inventorySelect + startingPosition][0].currentLevel - 1), 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] + 5, resultsContainer[1] + 90, string(workers[inventorySelect + startingPosition][0].efficiency - 1), 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] + 5, resultsContainer[1] + 110, string(workers[inventorySelect + startingPosition][0].maxStamina - 2), 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] + 35, resultsContainer[1] + 70, "->", 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] + 35, resultsContainer[1] + 90, "->", 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] + 35, resultsContainer[1] + 110, "->", 1, 0, 16, 4, 175, 16777215, 1);
        draw_set_halign(fa_right);
        draw_text_outline(resultsContainer[0] + 65, resultsContainer[1] + 70, string(workers[inventorySelect + startingPosition][0].currentLevel), 1, 0, 16, 4, 175, make_color_rgb(72, 239, 112), 1);
        draw_text_outline(resultsContainer[0] + 65, resultsContainer[1] + 90, string(workers[inventorySelect + startingPosition][0].efficiency), 1, 0, 16, 4, 200, make_color_rgb(72, 239, 112), 1);
        draw_text_outline(resultsContainer[0] + 65, resultsContainer[1] + 110, string(workers[inventorySelect + startingPosition][0].maxStamina), 1, 0, 16, 4, 200, make_color_rgb(72, 239, 112), 1);
    }
    else if (manageLevelConfirm && manageLevelTimer >= waitTime)
    {
        if (resultsContainer[1] < 110)
        {
            resultsContainer[1] += 40;
        }
        else
        {
            resultsContainer[1] = 110;
        }
        draw_sprite(hud_fishingResults, 0, resultsContainer[0], resultsContainer[1]);
        draw_set_font(Galmuri14);
        draw_set_halign(fa_center);
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 10, "LEVEL UP!", 2, 0, 16, 4, 200, 16777215, 1);
        draw_sprite(hud_confirmButton, 0, resultsContainer[0], resultsContainer[1] + 155);
        draw_set_font(Galmuri9);
        draw_set_color(c_black);
        draw_text_scribble(resultsContainer[0], resultsContainer[1] + 150, "OK");
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_set_halign(fa_center);
        draw_set_halign(fa_left);
        draw_text_outline(resultsContainer[0] - 70, resultsContainer[1] + 55, "Manage LV", 1, 0, 16, 4, 175, 16777215, 1);
        draw_set_halign(fa_center);
        draw_text_outline(resultsContainer[0] + 5, resultsContainer[1] + 55, string(ds_map_find_value(global.PlayerSave, "manageLevel") - 1), 1, 0, 16, 4, 175, 16777215, 1);
        draw_text_outline(resultsContainer[0] + 35, resultsContainer[1] + 55, "->", 1, 0, 16, 4, 175, 16777215, 1);
        draw_set_halign(fa_right);
        draw_text_outline(resultsContainer[0] + 65, resultsContainer[1] + 55, string(ds_map_find_value(global.PlayerSave, "manageLevel")), 1, 0, 16, 4, 175, make_color_rgb(72, 239, 112), 1);
        draw_set_halign(fa_center);
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 90, global.TextContainer.managerlevelText.selectedLanguage, 1, 0, 16, 15, 175, 16777215, 1);
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_5 = 5,
    Value_6
}
