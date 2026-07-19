var selectedColor = [16777215, 0];
if (interacting)
{
    draw_sprite(spr_SandWindow, 0, 488, 20);
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    draw_text_scribble(610, 26, ds_map_find_value(global.PlayerSave, "fishSand"));
    draw_sprite(spr_Sand, 0, 505, 38);
    draw_sprite(spr_SandWindow, 0, 338, 20);
    draw_set_halign(fa_right);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    draw_text_scribble(460, 26, ds_map_find_value(global.PlayerSave, "holoCoins"));
    draw_sprite(spr_holoCoin, 0, 355, 30);
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.fishOptions.selectedLanguage[i]);
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.fishOptions.selectedLanguage[i]);
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
            draw_text_scribble(inventoryMenu[0] + 193, inventoryMenu[1] + 10, global.TextContainer.bloopShop.selectedLanguage);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            var spacing = 75;
            for (var i = 0; i < min(3, array_length(displayingInventory)); i++)
            {
                draw_set_halign(fa_left);
                if (inventorySelect == i && array_length(displayingInventory) > 0)
                {
                    draw_sprite(spr_holoCursor, image_index / 3, inventoryMenu[0] + 22, inventoryMenu[1] + 60 + (i * spacing));
                    draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle(inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing), inventoryMenu[0] + 380, inventoryMenu[1] + 60 + 50 + (i * spacing), false);
                    draw_set_alpha(1);
                }
                if (MouseOverButton("largeShopMenu", inventoryMenu[0] + 30, ((inventoryMenu[1] + 60) - 20) + (i * spacing)))
                {
                    if (obj_InputManager.MouseMoved() && inventorySelect != i && !rodBuyConfirm)
                    {
                        inventorySelect = i;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (inventorySelect == i)
                    {
                        ClickButton();
                    }
                }
                draw_sprite(displayingInventory[i + startingPosition].inventoryIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * spacing));
                draw_sprite(hud_optionIconCase, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * spacing));
                draw_set_color(c_yellow);
                var equipped = "";
                if (ds_map_find_value(global.PlayerSave, "fishRod") == (i + startingPosition))
                {
                    equipped = " [[EQUIPPED]";
                }
                draw_text_scribble(inventoryMenu[0] + 50 + 20, ((inventoryMenu[1] + 60) - 5 - 10) + (i * spacing), displayingInventory[i + startingPosition].inventoryName + " " + equipped);
                if (equipped != "")
                {
                    draw_sprite(spr_shopLevels_Maxed, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * spacing));
                }
                draw_set_halign(fa_right);
                var unlock = "";
                if (!array_get(ds_map_find_value(global.PlayerSave, "rodUnlock"), i + startingPosition))
                {
                    unlock = string(displayingInventory[i + startingPosition].inventoryValue);
                }
                else
                {
                    unlock = "BOUGHT";
                }
                if (unlock != "BOUGHT")
                {
                    draw_text_scribble(inventoryMenu[0] + 290 + 20, ((inventoryMenu[1] + 60) - 5 - 10) + (i * spacing), "Cost: ");
                    draw_sprite(spr_Sand, 0, (inventoryMenu[0] + 355 + 20) - string_width(unlock) - 15, ((inventoryMenu[1] + 11 + 60) - 5 - 10) + (i * spacing));
                }
                draw_text_scribble(inventoryMenu[0] + 355 + 20, ((inventoryMenu[1] + 60) - 5 - 10) + (i * spacing), unlock);
                if (i == inventorySelect && rodBuyConfirm)
                {
                    draw_set_halign(fa_center);
                    draw_text_scribble(inventoryMenu[0] + 200 + 20, inventoryMenu[1] + 60 + (i * spacing), global.TextContainer.fishRod.selectedLanguage[0]);
                    for (var j = 0; j < 2; j++)
                    {
                        var valid = false;
                        if (ds_map_find_value(global.PlayerSave, "fishSand") >= displayingInventory[i + startingPosition].inventoryValue || j == 1)
                        {
                            valid = true;
                        }
                        draw_sprite_ext(hud_LevelButton, rodBuySelect == j, ((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 60 + (i * spacing), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                        draw_set_color(selectedColor[rodBuySelect == j]);
                        draw_text_scribble(((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 5 + 60 + (i * spacing), global.TextContainer.fishRod.selectedLanguage[j + 1]);
                        draw_set_alpha(1);
                        if (MouseOverButton("levelButton", ((inventoryMenu[0] + 200 + 20) - 75) + (150 * j), inventoryMenu[1] + 15 + 60 + (i * spacing)))
                        {
                            if (obj_InputManager.MouseMoved() && rodBuySelect != j && canControl)
                            {
                                rodBuySelect = j;
                                audio_play_sound(snd_menu_select, 30, 0);
                            }
                            if (rodBuySelect == j)
                            {
                                ClickButton();
                            }
                        }
                    }
                }
                else
                {
                    draw_set_color(c_white);
                    draw_set_halign(fa_left);
                    draw_text_scribble_ext(inventoryMenu[0] + 50 + 20, inventoryMenu[1] + 60 + (i * spacing), displayingInventory[i + startingPosition].inventoryDescription, 300);
                }
                draw_set_halign(fa_right);
            }
            startingPosition = ScrollBar(displayingInventory, inventoryMenu[0] + 390, inventoryMenu[1] + 50, inventoryMenu[1] + 255, 1, 3, startingPosition, !rodBuyConfirm && !sellConfirm);
            if (instance_exists(obj_FishingMiniGame) && obj_FishingMiniGame.comboChain > 0)
            {
                draw_set_halign(fa_center);
                draw_text_outline(400, 336, global.TextContainer.fishingChangeWarning.selectedLanguage, 1, 0, 14, 15, 400, 255, 1);
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.fishOptions.selectedLanguage[i]);
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
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.bloopShop.selectedLanguage);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            for (var i = 0; i < min(5, array_length(displayingInventory)); i++)
            {
                draw_set_halign(fa_left);
                draw_set_font(Galmuri9);
                if (inventorySelect == i && array_length(displayingInventory) > 0)
                {
                    if (!sellConfirm)
                    {
                        draw_sprite(spr_holoCursor, image_index / 3, inventoryMenu[0] + 22, inventoryMenu[1] + 60 + (i * 35));
                        draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                        draw_set_color(c_white);
                        draw_rectangle(inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13, inventoryMenu[0] + 380, inventoryMenu[1] + 60 + (i * 35) + 13, false);
                        draw_set_alpha(1);
                    }
                }
                if (MouseOverButton("smallShopMenu", inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13) && !sellConfirm)
                {
                    if (obj_InputManager.MouseMoved() && inventorySelect != i)
                    {
                        inventorySelect = i;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (inventorySelect == i && (!MouseOverButton("arrow", (inventoryMenu[0] + 220) - string_width(string(sellingInventory[i + startingPosition]) + " / " + string(item_get(displayingInventory[i + startingPosition].id))) - 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5) && !MouseOverButton("arrow", inventoryMenu[0] + 220 + 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5)))
                    {
                        ClickButton();
                    }
                }
                if (item_get(displayingInventory[i + startingPosition].id) < 1)
                {
                    draw_set_alpha(0.4);
                }
                draw_sprite(displayingInventory[i + startingPosition].inventoryIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * 35));
                draw_text_scribble(inventoryMenu[0] + 50 + 20, ((inventoryMenu[1] + 60) - 5) + (i * 35), displayingInventory[i + startingPosition].inventoryName);
                draw_set_halign(fa_right);
                draw_text_scribble(inventoryMenu[0] + 220, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(sellingInventory[i + startingPosition]) + " / " + string(item_get(displayingInventory[i + startingPosition].id)));
                draw_sprite(hud_scrollArrows3, 0, (inventoryMenu[0] + 220) - string_width(string(sellingInventory[i + startingPosition]) + " / " + string(item_get(displayingInventory[i + startingPosition].id))) - 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5);
                if (MouseOverButton("arrow", (inventoryMenu[0] + 220) - string_width(string(sellingInventory[i + startingPosition]) + " / " + string(item_get(displayingInventory[i + startingPosition].id))) - 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5))
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        SelectLeft();
                    }
                }
                draw_sprite(hud_scrollArrows3, 1, inventoryMenu[0] + 220 + 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5);
                if (MouseOverButton("arrow", inventoryMenu[0] + 220 + 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5))
                {
                    if (mouse_check_button_pressed(mb_left))
                    {
                        SelectRight();
                    }
                }
                draw_sprite(spr_Sand, 0, inventoryMenu[0] + 255, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 10);
                draw_set_halign(fa_left);
                draw_text_scribble(inventoryMenu[0] + 272, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(displayingInventory[i + startingPosition].inventoryValue));
                draw_set_color(c_white);
                draw_rectangle(inventoryMenu[0] + 325, (inventoryMenu[1] + 60 + (i * 35)) - 10, inventoryMenu[0] + 375, inventoryMenu[1] + 60 + (i * 35) + 10, true);
                draw_set_halign(fa_right);
                draw_text_scribble(inventoryMenu[0] + 374, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(displayingInventory[i + startingPosition].inventoryValue * sellingInventory[i + startingPosition]));
                draw_set_alpha(1);
            }
            if (sellConfirm)
            {
                draw_sprite(spr_holoCursor, image_index / 3, inventoryMenu[0] + 22, inventoryMenu[1] + 249);
                draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                draw_set_color(c_white);
                draw_rectangle(inventoryMenu[0] + 35, (inventoryMenu[1] + 249) - 19, inventoryMenu[0] + 380, inventoryMenu[1] + 249 + 19, false);
                draw_set_alpha(1);
            }
            draw_rectangle(inventoryMenu[0] + 30, inventoryMenu[1] + 225, inventoryMenu[0] + 385, inventoryMenu[1] + 226, false);
            draw_set_font(Galmuri9);
            draw_text_scribble(inventoryMenu[0] + 250, inventoryMenu[1] + 244, "Sale Total: ");
            draw_set_font(Galmuri14);
            draw_set_halign(fa_right);
            var totalSale = 0;
            for (var i = 0; i < array_length(sellingInventory); i++)
            {
                totalSale += (displayingInventory[i].inventoryValue * sellingInventory[i]);
            }
            draw_text_scribble(inventoryMenu[0] + 370, inventoryMenu[1] + 237, totalSale);
            draw_rectangle(inventoryMenu[0] + 255, inventoryMenu[1] + 233, inventoryMenu[0] + 375, inventoryMenu[1] + 265, true);
            draw_sprite(hud_confirmButton, 0, inventoryMenu[0] + 85, inventoryMenu[1] + 249);
            draw_set_color(c_black);
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            draw_text_scribble(inventoryMenu[0] + 85, inventoryMenu[1] + 244, global.TextContainer.fishSell.selectedLanguage);
            startingPosition = ScrollBar(displayingInventory, inventoryMenu[0] + 390, inventoryMenu[1] + 50, inventoryMenu[1] + 220, 1, 5, startingPosition, !rodBuyConfirm && !sellConfirm);
            if (MouseOverButton("short", inventoryMenu[0] + 85, inventoryMenu[1] + 244))
            {
                if (sellConfirm)
                {
                    ClickButton();
                }
                else if (mouse_check_button_pressed(mb_left))
                {
                    sellConfirm = true;
                    audio_play_sound(snd_menu_confirm, 30, 0);
                }
            }
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.fishOptions.selectedLanguage[i]);
                draw_set_alpha(1);
            }
            if (exchangeMenu[0] > 250)
            {
                exchangeMenu[0] -= 250;
            }
            else
            {
                exchangeMenu[0] = 250;
            }
            draw_sprite(spr_ExchangeWindow, 0, exchangeMenu[0], exchangeMenu[1]);
            draw_set_color(c_white);
            draw_set_halign(fa_center);
            draw_set_font(Galmuri14);
            draw_text_scribble(exchangeMenu[0] + 157.5, exchangeMenu[1] + 5, "Exchange");
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            draw_rectangle(exchangeMenu[0] + 85, exchangeMenu[1] + 38, exchangeMenu[0] + 85 + 180, exchangeMenu[1] + 38 + 33, true);
            draw_sprite_ext(spr_Sand, 0, 300, 170, 2, 2, 0, c_white, 1);
            draw_sprite_ext(spr_holoCoin, 0, 300, 216, 2, 2, 0, c_white, 1);
            draw_sprite(spr_rhythmButtons, 1, exchangeMenu[0] + 157.5 + 15, exchangeMenu[1] + 81);
            draw_rectangle(exchangeMenu[0] + 85, exchangeMenu[1] + 35 + 60, exchangeMenu[0] + 85 + 180, exchangeMenu[1] + 35 + 38 + 55, true);
            draw_set_halign(fa_right);
            draw_set_font(Galmuri14);
            draw_text(exchangeMenu[0] + 258, exchangeMenu[1] + 42, currentSand);
            for (var i = 0; i < array_length(exchangeArray); i++)
            {
                if (currentExchangeIndex == i)
                {
                    draw_set_alpha(0.25 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle((exchangeMenu[0] + 258) - (13 * i) - 1, exchangeMenu[1] + 42 + 57 + 1, (exchangeMenu[0] + 258) - (13 * i) - 14, exchangeMenu[1] + 42 + 57 + 24, false);
                    draw_set_alpha(1);
                }
                draw_text((exchangeMenu[0] + 258) - (13 * i), exchangeMenu[1] + 42 + 57, exchangeArray[i]);
            }
            if (sellConfirm)
            {
                for (var i = 0; i < 2; i++)
                {
                    var valid = true;
                    draw_set_halign(fa_center);
                    draw_set_font(Galmuri9);
                    draw_sprite_ext(hud_LevelButton, exchangeOption == i, ((exchangeMenu[0] + 157.5) - 70) + (i * 140), exchangeMenu[1] + 145, 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                    draw_set_color(selectedColor[exchangeOption == i]);
                    draw_text_scribble(((exchangeMenu[0] + 157.5) - 70) + (i * 140), exchangeMenu[1] + 150, global.TextContainer.farmConfirm.selectedLanguage[i]);
                    if (MouseOverButton("levelButton", ((exchangeMenu[0] + 157.5) - 70) + (i * 140), exchangeMenu[1] + 145))
                    {
                        if (obj_InputManager.MouseMoved() && exchangeOption != i)
                        {
                            exchangeOption = i;
                            audio_play_sound(snd_menu_select, 0, 0);
                        }
                        if (exchangeOption == i)
                        {
                            ClickButton();
                        }
                    }
                }
            }
            else
            {
                ClickButton();
            }
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2
}
