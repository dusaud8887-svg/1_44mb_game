var selectedColor = [16777215, 0];
if (interacting)
{
    var i;
    if (!cropsResults)
    {
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
        if (currentMenu != 0)
        {
            draw_set_alpha(0.5);
        }
        for (i = 0; i < 3; i++)
        {
            var valid = true;
            if (currentMenu != 0)
            {
                valid = false;
            }
            if (i == 1 && (seedID == -1 || grown))
            {
                valid = false;
            }
            var water = 0;
            if (seedID != -1)
            {
                water = 3;
            }
            var watertext = "";
            if (water == 3 && i == 0 && waterCD > 0 && !grown)
            {
                watertext = " (" + string(waterCD div 60) + ")";
                valid = false;
            }
            draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
            draw_set_color(selectedColor[pauseOption == i]);
            draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.farmOptions.selectedLanguage[i + (water * (i == 0)) + ((i == 0) * grown)] + watertext);
            if (currentMenu == 0)
            {
                if (MouseOverButton("levelButton", menuContainer[0], menuContainer[1] + (i * 30)) && !removeConfirm)
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
            }
        }
    }
    if (currentMenu == UnknownEnum.Value_0)
    {
        if (removeConfirm)
        {
            var confirm = [390, 135];
            draw_sprite(hud_farmConfirmWindow, 0, confirm[0], confirm[1]);
            draw_set_halign(fa_center);
            draw_set_color(c_white);
            draw_text_scribble(confirm[0] + 112, confirm[1] + 40, "Remove [c_green]" + seedID.inventoryName + "[/color]" + "?");
            for (var j = 0; j < 2; j++)
            {
                var valid = true;
                if (i == 0 && grown)
                {
                    valid = false;
                }
                draw_sprite_ext(hud_confirmButton2, removeOption == j, ((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 97, 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[removeOption == j]);
                draw_text_scribble(((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 91, global.TextContainer.farmConfirm.selectedLanguage[j]);
                draw_set_alpha(1);
                if (MouseOverButton("short", ((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 97))
                {
                    if (obj_InputManager.MouseMoved() && j != removeOption)
                    {
                        removeOption = j;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (removeOption == j)
                    {
                        ClickButton();
                    }
                }
            }
        }
        if (seedID != -1 && !removeConfirm && !cropsResults)
        {
            var confirm = [390, 135];
            draw_sprite(hud_farmConfirmWindow, 0, confirm[0], confirm[1]);
            draw_set_halign(fa_center);
            draw_set_color(c_white);
            var text = "[[[c_green]" + soilID.config.tag + "[/color]] ";
            draw_text_scribble(confirm[0] + 112, confirm[1] + 13, text + seedID.inventoryName);
            draw_sprite(seedID.inventoryIcon, 0, confirm[0] + 112, confirm[1] + 51);
            draw_sprite(hud_optionIconCase, 0, confirm[0] + 112, confirm[1] + 51);
            var growthPercent = string(min(100, round((lifetime / growTime) * 100))) + "%";
            draw_text_scribble(confirm[0] + 112, confirm[1] + 75, "[c_green]" + global.TextContainer.farmStatus.selectedLanguage[0] + growthPercent + "[/color]");
            draw_text_scribble(confirm[0] + 112, confirm[1] + 95, global.TextContainer.farmStatus.selectedLanguage[1] + "[c_yellow]" + string_time(getTimeFromTicks(growTime - lifetime)) + "[/color]");
        }
    }
    draw_set_alpha(1);
    if (currentMenu == 1 || currentMenu == 2)
    {
        if (rightContainer1[0] != 187)
        {
            rightContainer1[0] -= 80;
        }
        if (rightContainer1[0] < 187)
        {
            rightContainer1[0] = 187;
        }
        draw_sprite(hud_farmListWindow, 0, rightContainer1[0], rightContainer1[1]);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_font(Galmuri14);
        draw_text_scribble(rightContainer1[0] + 92, rightContainer1[1] + 10, "SOILS");
        draw_set_font(Galmuri9);
        draw_set_color(c_white);
        for (i = 0; i < min(5, array_length(displayingInventory1)); i++)
        {
            draw_set_halign(fa_left);
            draw_set_font(Galmuri9);
            if (inventorySelect1 == i && array_length(displayingInventory1) > 0)
            {
                if (currentMenu == 1)
                {
                    draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle(rightContainer1[0] + 10, (rightContainer1[1] + 60 + (i * 35)) - 13, rightContainer1[0] + 175, rightContainer1[1] + 60 + (i * 35) + 13, false);
                    draw_set_alpha(1);
                }
                else
                {
                    draw_set_alpha(0.5);
                    draw_set_color(make_color_rgb(58, 202, 255));
                    draw_rectangle(rightContainer1[0] + 10, (rightContainer1[1] + 60 + (i * 35)) - 13, rightContainer1[0] + 175, rightContainer1[1] + 60 + (i * 35) + 13, false);
                    draw_set_alpha(1);
                    draw_set_color(c_white);
                }
            }
            if (item_get(displayingInventory1[i + startingPosition].id) < 1)
            {
                draw_set_alpha(0.5);
            }
            draw_sprite(displayingInventory1[i + startingPosition].inventoryIcon, 0, rightContainer1[0] + 25, rightContainer1[1] + 60 + (i * 35));
            draw_text_scribble(rightContainer1[0] + 25 + 20, ((rightContainer1[1] + 60) - 5) + (i * 35), displayingInventory1[i + startingPosition].inventoryName);
            draw_set_halign(fa_right);
            draw_text_scribble(rightContainer1[0] + 175, ((rightContainer1[1] + 60) - 5) + (i * 35), "x " + string(item_get(displayingInventory1[i + startingPosition].id)));
            draw_set_alpha(1);
            if (currentMenu == UnknownEnum.Value_1 && MouseOverButton("seedMenu", rightContainer1[0] + 10, (rightContainer1[1] + 60 + (i * 35)) - 13))
            {
                if (obj_InputManager.MouseMoved() && i != inventorySelect1)
                {
                    inventorySelect1 = i;
                    global.soilSelect = inventorySelect1;
                    audio_play_sound(snd_menu_select, 0, 0);
                }
                if (inventorySelect1 == i)
                {
                    ClickButton();
                }
            }
        }
    }
    if (currentMenu == 2)
    {
        if (rightContainer2[0] != 400)
        {
            rightContainer2[0] -= 80;
        }
        if (rightContainer2[0] < 400)
        {
            rightContainer2[0] = 400;
        }
        draw_sprite(hud_farmListWindow, 0, rightContainer2[0], rightContainer2[1]);
        draw_set_color(c_white);
        draw_set_halign(fa_center);
        draw_set_font(Galmuri14);
        draw_text_scribble(rightContainer2[0] + 92, rightContainer2[1] + 10, "SEEDS");
        draw_set_font(Galmuri9);
        draw_set_color(c_white);
        for (i = 0; i < min(6, array_length(displayingInventory2)); i++)
        {
            draw_set_halign(fa_left);
            draw_set_font(Galmuri9);
            if (inventorySelect2 == i && array_length(displayingInventory2) > 0)
            {
                if (currentMenu == 2)
                {
                    draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle(rightContainer2[0] + 10, (rightContainer2[1] + 60 + (i * 35)) - 13, rightContainer2[0] + 175, rightContainer2[1] + 60 + (i * 35) + 13, false);
                    draw_set_alpha(1);
                }
                else
                {
                    draw_set_alpha(0.5);
                    draw_set_color(make_color_rgb(58, 202, 255));
                    draw_rectangle(rightContainer2[0] + 10, (rightContainer2[1] + 60 + (i * 35)) - 13, rightContainer2[0] + 175, rightContainer2[1] + 60 + (i * 35) + 13, false);
                    draw_set_alpha(1);
                    draw_set_color(c_white);
                }
            }
            var itemHas = item_get(displayingInventory2[i + startingPosition2].id);
            if (is_undefined(itemHas))
            {
                itemHas = 0;
            }
            if (itemHas < 1)
            {
                draw_set_alpha(0.5);
            }
            draw_sprite(displayingInventory2[i + startingPosition2].inventoryIcon, 0, rightContainer2[0] + 25, rightContainer2[1] + 60 + (i * 35));
            draw_text_scribble(rightContainer2[0] + 25 + 20, ((rightContainer2[1] + 60) - 5) + (i * 35), displayingInventory2[i + startingPosition2].inventoryName);
            draw_set_halign(fa_right);
            draw_text_scribble(rightContainer2[0] + 175, ((rightContainer2[1] + 60) - 5) + (i * 35), "x " + string(itemHas));
            draw_set_alpha(1);
            if (MouseOverButton("seedMenu", rightContainer2[0] + 10, (rightContainer2[1] + 60 + (i * 35)) - 13))
            {
                if (obj_InputManager.MouseMoved() && i != inventorySelect2)
                {
                    inventorySelect2 = i;
                    global.plantSelect = inventorySelect2;
                    audio_play_sound(snd_menu_select, 0, 0);
                }
                if (inventorySelect2 == i)
                {
                    ClickButton();
                }
            }
            startingPosition2 = ScrollBar(displayingInventory2, rightContainer2[0] + 185, rightContainer2[1] + 45, rightContainer2[1] + 245, 1, 6, startingPosition2);
        }
    }
    else if (currentMenu == UnknownEnum.Value_3)
    {
        var confirm = [390, 135];
        draw_sprite(hud_farmConfirmWindow, 0, confirm[0], confirm[1]);
        draw_set_halign(fa_center);
        draw_set_color(c_white);
        draw_text_scribble(confirm[0] + 112 + 30, confirm[1] + 13, global.TextContainer.farmingConfirm.selectedLanguage[0]);
        draw_text_scribble(confirm[0] + 112 + 30, confirm[1] + 28, "[c_green]" + displayingInventory2[inventorySelect2 + startingPosition2].inventoryName + "[/color]");
        draw_text_scribble(confirm[0] + 112 + 30, confirm[1] + 43, global.TextContainer.farmingConfirm.selectedLanguage[1]);
        draw_text_scribble(confirm[0] + 112 + 30, confirm[1] + 58, "[c_green]" + displayingInventory1[inventorySelect1 + startingPosition].inventoryName + "[/color]");
        draw_sprite(displayingInventory2[inventorySelect2 + startingPosition2].inventoryIcon, 0, (confirm[0] + 112) - 60, confirm[1] + 25);
        draw_sprite(displayingInventory1[inventorySelect1 + startingPosition].inventoryIcon, 0, (confirm[0] + 112) - 60, confirm[1] + 60);
        draw_sprite(hud_optionIconCase, 0, (confirm[0] + 112) - 60, confirm[1] + 25);
        draw_sprite(hud_optionIconCase, 0, (confirm[0] + 112) - 60, confirm[1] + 60);
        for (var j = 0; j < 2; j++)
        {
            var valid = true;
            draw_sprite_ext(hud_confirmButton2, farmConfirmSelect == j, ((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 97, 1, 1, 0, c_white, 0.5 + (valid * 0.5));
            draw_set_color(selectedColor[farmConfirmSelect == j]);
            draw_text_scribble(((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 91, global.TextContainer.farmConfirm.selectedLanguage[j]);
            draw_set_alpha(1);
            if (MouseOverButton("short", ((confirm[0] + 112) - 50) + (100 * j), confirm[1] + 97))
            {
                if (obj_InputManager.MouseMoved() && j != farmConfirmSelect)
                {
                    farmConfirmSelect = j;
                    audio_play_sound(snd_menu_select, 0, 0);
                }
                if (farmConfirmSelect == j)
                {
                    ClickButton();
                }
            }
        }
    }
    if (cropsResults && cropsResultsTimer >= waitTime)
    {
        var theCrop = ds_map_find_value(global.InventoryLibrary, cropID);
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
        var resultText = "";
        resultText = global.TextContainer.cropsSuccess.selectedLanguage;
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 10, resultText, 2, 0, 16, 4, 200, 16777215, 1);
        draw_sprite(hud_confirmButton, 0, resultsContainer[0], resultsContainer[1] + 155);
        draw_set_font(Galmuri9);
        draw_set_color(c_black);
        draw_text_scribble(resultsContainer[0], resultsContainer[1] + 150, "OK");
        if (MouseOverButton("short", resultsContainer[0], resultsContainer[1] + 155))
        {
            ClickButton();
        }
        draw_sprite(theCrop.inventoryIcon, 0, resultsContainer[0], resultsContainer[1] + 70);
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        var resultsText = theCrop.inventoryName + " x " + string(yieldNumber);
        draw_text_outline(resultsContainer[0], resultsContainer[1] + 110, resultsText, 1, 0, 16, 4, 175, 16777215, 1);
        for (i = 0; i < 5; i++)
        {
            gpu_set_blendmode(bm_add);
            draw_sprite_ext(hudfx_itemLightBeam, 0, resultsContainer[0], resultsContainer[1] + 70, 1, 1, lightTime + (i * 72), c_white, 1);
            gpu_set_blendmode(bm_normal);
        }
        lightTime++;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_3 = 3
}
