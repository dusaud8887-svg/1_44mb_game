var selectedColor = [16777215, 0];
if (interacting)
{
    draw_set_halign(fa_right);
    draw_sprite(spr_SandWindow, 0, 488, 20);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    draw_text_scribble(610, 26, ds_map_find_value(global.PlayerSave, "holoCoins"));
    draw_sprite(spr_holoCoin, 0, 505, 30);
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
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.cookOptions.selectedLanguage[i]);
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.cookOptions.selectedLanguage[i]);
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
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.cookTitles.selectedLanguage[0]);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            if (array_length(displayingInventory) > 0)
            {
                draw_sprite(hud_optionIconCase, 0, inventoryMenu[0] + 200, inventoryMenu[1] + 55);
                draw_sprite(displayingInventory[inventorySelect].optionIcon, 0, inventoryMenu[0] + 200, inventoryMenu[1] + 55);
                if (array_length(displayingInventory) > 1)
                {
                    draw_sprite(spr_MoreArrow, image_index, inventoryMenu[0] + 200 + 60, inventoryMenu[1] + 55);
                }
                if (MouseOverButton("itemCase", inventoryMenu[0] + 200 + 60, inventoryMenu[1] + 55))
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        SelectRight();
                    }
                }
                else if (MouseOverButton("itemCase", (inventoryMenu[0] + 200) - 60, inventoryMenu[1] + 55))
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        SelectLeft();
                    }
                }
                if (array_length(displayingInventory) > 1)
                {
                    draw_sprite_ext(spr_MoreArrow, image_index, (inventoryMenu[0] + 200) - 60, inventoryMenu[1] + 55, -1, 1, 0, c_white, 1);
                }
                draw_set_color(c_lime);
                draw_text(inventoryMenu[0] + 200, inventoryMenu[1] + 75, string(inventorySelect + 1) + ". " + displayingInventory[inventorySelect].optionName);
                draw_set_color(c_white);
                draw_set_halign(fa_left);
                draw_set_color(c_yellow);
                draw_text(inventoryMenu[0] + 30, inventoryMenu[1] + 120, global.TextContainer.cookTitles.selectedLanguage[1]);
                draw_set_color(c_white);
                draw_text_scribble_ext(inventoryMenu[0] + 50, inventoryMenu[1] + 135, displayingInventory[inventorySelect].optionDescription, 300);
                draw_text_scribble(inventoryMenu[0] + 30, inventoryMenu[1] + 95, "[c_yellow]" + global.TextContainer.cookTitles.selectedLanguage[2] + "[/color]" + " " + string(displayingInventory[inventorySelect].useNumber));
                draw_set_color(c_yellow);
                draw_text(inventoryMenu[0] + 30, inventoryMenu[1] + 170, global.TextContainer.cookTitles.selectedLanguage[3]);
                draw_set_color(c_white);
                for (var i = 0; i < array_length(variable_struct_get_names(displayingInventory[inventorySelect].recipe)); i++)
                {
                    var getIngredient = ds_map_find_value(global.InventoryLibrary, array_get(variable_struct_get_names(displayingInventory[inventorySelect].recipe), i));
                    if (!is_undefined(getIngredient))
                    {
                        draw_set_color(c_white);
                        draw_set_halign(fa_left);
                        draw_text(inventoryMenu[0] + 50, inventoryMenu[1] + 185 + (i * 15), "- " + string(getIngredient.inventoryName));
                        var required = variable_struct_get(displayingInventory[inventorySelect].recipe, getIngredient.inventoryID);
                        var hasItem;
                        if (item_exists(getIngredient.inventoryID))
                        {
                            hasItem = item_get(getIngredient.inventoryID);
                        }
                        else
                        {
                            hasItem = 0;
                        }
                        draw_set_halign(fa_right);
                        if (hasItem >= required)
                        {
                            draw_set_color(c_lime);
                        }
                        else
                        {
                            draw_set_color(c_red);
                        }
                        draw_text(inventoryMenu[0] + 230, inventoryMenu[1] + 185 + (i * 15), string(hasItem) + " / " + string(required));
                    }
                }
                for (var i = 0; i < 2; i++)
                {
                    var valid = canCook || i == 1;
                    draw_set_alpha(1);
                    draw_set_halign(fa_center);
                    draw_sprite_ext(hud_LevelButton, cookSelect == i, inventoryMenu[0] + 310, inventoryMenu[1] + 180 + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                    draw_set_color(selectedColor[cookSelect == i]);
                    draw_text_scribble(inventoryMenu[0] + 310, inventoryMenu[1] + 180 + (i * 30) + 5, global.TextContainer.cookButtons.selectedLanguage[i]);
                    draw_set_alpha(1);
                    if (MouseOverButton("levelButton", inventoryMenu[0] + 310, inventoryMenu[1] + 180 + (i * 30)))
                    {
                        if (obj_InputManager.MouseMoved() && cookSelect != i && canControl)
                        {
                            cookSelect = i;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (cookSelect == i)
                        {
                            ClickButton();
                        }
                    }
                    if (ds_map_find_value(global.PlayerSave, "autoCook") == displayingInventory[inventorySelect].optionID)
                    {
                        draw_set_color(c_yellow);
                        draw_text(inventoryMenu[0] + 310, inventoryMenu[1] + 180 + 60, global.TextContainer.cookButtons.selectedLanguage[2]);
                    }
                }
            }
            break;
        case 3:
            if (beginCooking && cookPause == 180)
            {
                var dish = displayingInventory[inventorySelect];
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
                resultText = global.TextContainer.enhanceSuccess.selectedLanguage;
                draw_text_outline(resultsContainer[0], resultsContainer[1] + 10, resultText, 2, 0, 16, 4, 200, 16777215, 1);
                draw_sprite(hud_confirmButton, 0, resultsContainer[0], resultsContainer[1] + 155);
                draw_set_font(Galmuri9);
                draw_set_color(c_black);
                draw_text_outline(resultsContainer[0], resultsContainer[1] + 110, dish.optionName, 1, 0, 14, 2, 300, 16777215, 1);
                draw_text_scribble(resultsContainer[0], resultsContainer[1] + 150, "OK");
                draw_sprite(dish.optionIcon, 0, resultsContainer[0], resultsContainer[1] + 70);
                if (MouseOverButton("short", resultsContainer[0], resultsContainer[1] + 155))
                {
                    ClickButton();
                }
                draw_set_color(c_white);
                draw_set_font(Galmuri9);
                for (var i = 0; i < 5; i++)
                {
                    gpu_set_blendmode(bm_add);
                    draw_sprite_ext(hudfx_itemLightBeam, 0, resultsContainer[0], resultsContainer[1] + 70, 1, 1, lightTime + (i * 72), c_white, 1);
                    gpu_set_blendmode(bm_normal);
                }
                lightTime++;
            }
            break;
    }
}

enum UnknownEnum
{
    Value_0
}
