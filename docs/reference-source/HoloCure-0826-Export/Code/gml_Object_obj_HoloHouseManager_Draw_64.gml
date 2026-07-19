var selectedColor = [16777215, 0];
draw_sprite(spr_vignette, 0, 0, 0);
if (global.hhMessages && room == rm_HoloHouse_Entrance)
{
    for (var i = 0; i < array_length(HoloHouseMessages); i++)
    {
        draw_set_font(Galmuri9);
        draw_set_halign(fa_left);
        var textCopy = string_copy(HoloHouseMessages[i][0], 1, string_length(HoloHouseMessages[i][0]));
        textCopy = string_replace_all(textCopy, "[c_holoblue]", "");
        textCopy = string_replace_all(textCopy, "[c_yellow]", "");
        textCopy = string_replace_all(textCopy, "[c_green]", "");
        textCopy = string_replace_all(textCopy, "[c_red]", "");
        textCopy = string_replace_all(textCopy, "[/color]", "");
        var currentAlpha = HoloHouseMessages[i][1] / 60;
        var messageLength = string_width(textCopy);
        draw_set_alpha(min(0.33, currentAlpha / 3));
        draw_set_color(c_black);
        draw_rectangle(messagesContainer[0], messagesContainer[1] - (i * 25), messagesContainer[0] + messageLength + 9, (messagesContainer[1] + 19) - (i * 25), false);
        draw_set_alpha(currentAlpha);
        draw_set_color(c_white);
        draw_text_scribble(messagesContainer[0] + 5, (messagesContainer[1] + 4) - (i * 25), HoloHouseMessages[i][0]);
        draw_set_alpha(1);
    }
}
if (paused)
{
    if (!buildingMode)
    {
        draw_sprite_ext(spr_holoHouseLogo, 0, menuContainer[0] - 90, menuContainer[1] - 65, 0.32, 0.32, 0, c_white, 1);
    }
    switch (pauseMenu)
    {
        case UnknownEnum.Value_0:
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
                if ((i + 1) == UnknownEnum.Value_2)
                {
                    if (!instance_exists(obj_HoloHouseInterior))
                    {
                        valid = false;
                    }
                }
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.holoHousePause.selectedLanguage[i]);
                if (MouseOverButton("levelButton", menuContainer[0], menuContainer[1] + (i * 30)))
                {
                    if (obj_InputManager.MouseMoved() && pauseOption != i && canControl && !quitConfirm)
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
                        if (quitOption == i)
                        {
                            ClickButton();
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
            break;
        case UnknownEnum.Value_1:
            if (menuContainer[0] != 110)
            {
                menuContainer[0] += 80;
            }
            if (menuContainer[0] > 110)
            {
                menuContainer[0] = 110;
            }
            draw_set_color(c_black);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            for (var i = 0; i < pauseItems; i++)
            {
                var valid = true;
                if ((i + 1) == UnknownEnum.Value_2)
                {
                    if (!instance_exists(obj_HoloHouseInterior))
                    {
                        valid = false;
                    }
                }
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.holoHousePause.selectedLanguage[i]);
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
            for (var i = 0; i < 6; i++)
            {
                draw_sprite_ext(spr_inventoryTypes, i, inventoryMenu[0] + (i * 40) + 112, inventoryMenu[1] + 20, 1, 1, 0, c_white, 0.5 + (0.5 * (i == 0 || i == (array_length(categorizedItems) + 1) || i == (inventoryTab + 1))));
                if (i != 0 && i != 5 && MouseOverButton("itemCase", inventoryMenu[0] + (i * 40) + 112, inventoryMenu[1] + 20))
                {
                    if (mouse_check_button_pressed(mb_left) && inventoryTab != (i - 1) && canControl)
                    {
                        inventoryTab = i - 1;
                        startingPosition = 0;
                        inventorySelect = 0;
                        InitInventory();
                        RodInventory();
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
            }
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            if (inventoryTab == 3)
            {
                for (var i = 0; i < min(6, array_length(rodsInventory)); i++)
                {
                    draw_set_halign(fa_left);
                    if (inventorySelect == i && array_length(rodsInventory) > 0)
                    {
                        draw_sprite(spr_holoCursor, image_index / 3, inventoryMenu[0] + 22, inventoryMenu[1] + 60 + (i * 35));
                        draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                        draw_set_color(c_white);
                        draw_rectangle(inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13, inventoryMenu[0] + 230, inventoryMenu[1] + 60 + (i * 35) + 13, false);
                        draw_set_alpha(1);
                    }
                    draw_sprite(rodsInventory[i + startingPosition].inventoryIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * 35));
                    var equipped = "[/color]";
                    var textColor = "[c_white]";
                    if (ds_map_find_value(global.PlayerSave, "fishRod") == (i + startingPosition))
                    {
                        textColor = "[c_green]";
                        equipped = " [[E][/color]";
                    }
                    draw_text_scribble(inventoryMenu[0] + 60 + 20, ((inventoryMenu[1] + 60) - 5) + (i * 35), textColor + rodsInventory[i + startingPosition].inventoryName + equipped);
                    draw_set_halign(fa_left);
                    if (MouseOverButton("shortShopMenu", inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13))
                    {
                        if (obj_InputManager.MouseMoved() && inventorySelect != i)
                        {
                            inventorySelect = i;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (inventorySelect == i)
                        {
                            ClickButton();
                        }
                    }
                }
                draw_rectangle(inventoryMenu[0] + 240, inventoryMenu[1] + 45, inventoryMenu[0] + 370, inventoryMenu[1] + 240, true);
                draw_text(inventoryMenu[0] + 250, inventoryMenu[1] + 55, "Catchable");
                var rodArrayOrder = ["beginnersRod", "dadsRod", "blacksmithRod", "atlanticRod", "turkeyRod", "goldenRod"];
                var getSelectedRod = rodsInventory[inventorySelect].inventoryID;
                var rodIndex = 0;
                for (var i = 0; i < array_length(rodArrayOrder); i++)
                {
                    if (getSelectedRod == rodArrayOrder[i])
                    {
                        rodIndex = i;
                    }
                }
                var canCatch = [];
                for (var i = 0; i < array_length(categorizedItems[0]); i++)
                {
                    if (categorizedItems[0][i].config.spawnRate[rodIndex] > 0)
                    {
                        array_push(canCatch, categorizedItems[0][i]);
                    }
                }
                for (var i = 0; i < array_length(canCatch); i++)
                {
                    if (is_undefined(item_get(categorizedItems[0][i].inventoryID)))
                    {
                        draw_sprite(spr_UnknownIcon, 0, inventoryMenu[0] + 260 + (30 * (i % 4)), inventoryMenu[1] + 90 + (30 * (i div 4)));
                    }
                    else
                    {
                        draw_sprite(categorizedItems[0][i].inventoryIcon, 0, inventoryMenu[0] + 260 + (30 * (i % 4)), inventoryMenu[1] + 90 + (30 * (i div 4)));
                    }
                }
                if (instance_exists(obj_FishingMiniGame) && obj_FishingMiniGame.comboChain > 0)
                {
                    draw_set_halign(fa_center);
                    draw_text_outline(400, 336, global.TextContainer.fishingChangeWarning.selectedLanguage, 1, 0, 14, 15, 400, 255, 1);
                }
            }
            else
            {
                for (var i = 0; i < min(6, array_length(displayingInventory)); i++)
                {
                    draw_set_halign(fa_left);
                    if (inventorySelect == i && array_length(displayingInventory) > 0)
                    {
                        draw_sprite(spr_holoCursor, image_index / 3, inventoryMenu[0] + 22, inventoryMenu[1] + 60 + (i * 35));
                        draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                        draw_set_color(c_white);
                        draw_rectangle(inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13, inventoryMenu[0] + 380, inventoryMenu[1] + 60 + (i * 35) + 13, false);
                        draw_set_alpha(1);
                    }
                    draw_sprite(displayingInventory[i + startingPosition].inventoryIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * 35));
                    draw_text_scribble(inventoryMenu[0] + 50 + 20, ((inventoryMenu[1] + 60) - 5) + (i * 35), displayingInventory[i + startingPosition].inventoryName);
                    draw_set_halign(fa_right);
                    draw_text_scribble(inventoryMenu[0] + 210, ((inventoryMenu[1] + 60) - 5) + (i * 35), "x  " + string(item_get(displayingInventory[i + startingPosition].id)));
                    if (inventoryTab == 0)
                    {
                        draw_text_scribble(inventoryMenu[0] + 350, ((inventoryMenu[1] + 60) - 5) + (i * 35), global.TextContainer.fishCaught.selectedLanguage + string(item_get_total(displayingInventory[i + startingPosition].id)));
                    }
                    if (inventoryTab == 1)
                    {
                        draw_text_scribble(inventoryMenu[0] + 350, ((inventoryMenu[1] + 60) - 5) + (i * 35), global.TextContainer.cropsHarvested.selectedLanguage + string(item_get_total(displayingInventory[i + startingPosition].id)));
                    }
                    if (MouseOverButton("smallShopMenu", inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13))
                    {
                        if (inventorySelect != i && obj_InputManager.MouseMoved())
                        {
                            inventorySelect = i;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (inventorySelect == i)
                        {
                            ClickButton();
                        }
                    }
                }
            }
            startingPosition = ScrollBar(displayingInventory, inventoryMenu[0] + 390, inventoryMenu[1] + 50, inventoryMenu[1] + 255, 1, 6, startingPosition);
            break;
        case UnknownEnum.Value_2:
            if (openCatalog)
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
                for (var i = 0; i < array_length(categoryTypes); i++)
                {
                    draw_sprite_ext(hud_LevelButton, catalogPage == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 1);
                    draw_set_color(selectedColor[catalogPage == i]);
                    draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.furnitureTypes.selectedLanguage[i]);
                    if (MouseOverButton("levelButton", menuContainer[0], menuContainer[1] + (i * 30)))
                    {
                        if (obj_InputManager.MouseMoved() && catalogPage != i && !catalogSelected)
                        {
                            catalogPage = i;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (catalogPage == i)
                        {
                            ClickButton();
                        }
                    }
                }
                draw_set_color(c_black);
                draw_set_alpha(1);
                draw_sprite(spr_FurnitureCategoryWindow, 0, 173, 73);
                if (canControl && !catalogSelected && array_length(categoryTypeArray[catalogPage]) > 0 && mouse_check_button_pressed(mb_left) && mouse_x > 173 && mouse_x < 452 && mouse_y > 73 && mouse_y < 287)
                {
                    canControl = false;
                    alarm[1] = 2;
                    catalogSelected = true;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
                var columns = 8;
                var rows = 6;
                var spacing = 35;
                for (var j = 0; j < rows; j++)
                {
                    for (var i = 0; i < columns; i++)
                    {
                        if (((j * columns) + i + startingPosition) < array_length(categoryTypeArray[catalogPage]))
                        {
                            draw_sprite(categoryTypeArray[catalogPage][(j * columns) + i].furnitureIcon, 0, 190 + (i * spacing), 90 + (j * spacing));
                            draw_set_halign(fa_center);
                            draw_set_color(c_white);
                            draw_text(530, 95, " Preview:");
                            if (catalogSelected && ((j * columns) + i) == itemOption)
                            {
                                draw_sprite(hud_optionIconCase, 0, 190 + (i * spacing), 90 + (j * spacing));
                                if (categoryTypeArray[catalogPage][(j * columns) + i].sprites != -1)
                                {
                                    var sprite = categoryTypeArray[catalogPage][(j * columns) + i].sprites[0];
                                    var spriteMidX = (sprite_get_bbox_right(sprite) - sprite_get_bbox_left(sprite)) / 2;
                                    var spriteMidY = (sprite_get_bbox_bottom(sprite) - sprite_get_bbox_top(sprite)) / 2;
                                    var offsetY = sprite_get_bbox_top(sprite) - sprite_get_yoffset(sprite);
                                    draw_sprite(sprite, 0, 530 - spriteMidX, 185 - spriteMidY - offsetY);
                                }
                            }
                            if (MouseOverButton("itemCase", 190 + (i * spacing), 90 + (j * spacing)))
                            {
                                if (obj_InputManager.MouseMoved() && itemOption != ((j * columns) + i) && catalogSelected && canControl)
                                {
                                    itemOption = (j * columns) + i;
                                    audio_play_sound(snd_menu_select, 30, 0);
                                }
                                if (((j * columns) + i) == itemOption)
                                {
                                    ClickButton();
                                }
                            }
                        }
                        else
                        {
                            break;
                        }
                    }
                }
            }
            if (pickedUpMenu)
            {
                draw_set_color(c_black);
                draw_set_halign(fa_center);
                draw_set_font(Galmuri9);
                for (var i = 0; i < 2; i++)
                {
                    draw_sprite_ext(hud_shopButton, pickedUpOption == i, obj_HoloHouseInterior.x + 8 + (gridCursor[0] * 16), min(300, obj_HoloHouseInterior.y + 40 + (gridCursor[1] * 16)) + (i * 30), 1, 1, 0, c_white, 1);
                    draw_set_color(selectedColor[pickedUpOption == i]);
                    draw_text_scribble(obj_HoloHouseInterior.x + 8 + (gridCursor[0] * 16), (min(300, obj_HoloHouseInterior.y + 40 + (gridCursor[1] * 16)) - 5) + (i * 30), global.TextContainer.holoHouseObjectOption.selectedLanguage[i]);
                    if (MouseOverButton("short", obj_HoloHouseInterior.x + 8 + (gridCursor[0] * 16), min(300, obj_HoloHouseInterior.y + 40 + (gridCursor[1] * 16)) + (i * 30)))
                    {
                        if (obj_InputManager.MouseMoved() && pickedUpOption != i && canControl)
                        {
                            pickedUpOption = i;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (pickedUpOption == i)
                        {
                            ClickButton();
                        }
                    }
                }
            }
            break;
    }
}
if (blackFlash > 0)
{
    draw_set_alpha(blackFlash);
    draw_rectangle_colour(0, 0, 10000, 10000, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
