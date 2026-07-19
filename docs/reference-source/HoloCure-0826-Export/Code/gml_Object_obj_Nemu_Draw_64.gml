var selectedColor = [16777215, 0];
if (interacting)
{
    draw_sprite(spr_SandWindow, 0, 488, 20);
    draw_set_halign(fa_right);
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
                if (instance_exists(obj_DialogueController) && obj_DialogueController.showingDialogue)
                {
                    valid = false;
                    draw_set_alpha(0.5);
                }
                draw_sprite_ext(hud_LevelButton, pauseOption == i, menuContainer[0], menuContainer[1] + (i * 30), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                draw_set_color(selectedColor[pauseOption == i]);
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.nemuOptions.selectedLanguage[i]);
                draw_set_alpha(1);
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.nemuOptions.selectedLanguage[i]);
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
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.nemuShop.selectedLanguage);
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
                if (item_get(displayingInventory[i + startingPosition].inventoryID) == 99)
                {
                    draw_set_alpha(0.5);
                }
                else
                {
                    draw_set_alpha(1);
                }
                draw_sprite(displayingInventory[i + startingPosition].inventoryIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * 35));
                draw_text_scribble(inventoryMenu[0] + 50 + 20, ((inventoryMenu[1] + 60) - 5) + (i * 35), displayingInventory[i + startingPosition].inventoryName);
                draw_set_halign(fa_right);
                var itemHas = item_get(displayingInventory[i + startingPosition].inventoryID);
                if (is_undefined(itemHas))
                {
                    itemHas = 0;
                }
                draw_text_scribble(inventoryMenu[0] + 220, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(sellingInventory[i + startingPosition]) + " (" + string(itemHas) + ")");
                draw_sprite(hud_scrollArrows3, 0, (inventoryMenu[0] + 220) - string_width(string(sellingInventory[i + startingPosition]) + " (" + string(itemHas) + ")") - 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5);
                if (MouseOverButton("arrow", (inventoryMenu[0] + 220) - string_width(string(sellingInventory[i + startingPosition]) + " (" + string(itemHas) + ")") - 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5))
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
                draw_sprite(spr_holoCoin, 0, inventoryMenu[0] + 255, (((inventoryMenu[1] + 60) - 5) + (i * 35) + 10) - 5);
                draw_set_halign(fa_left);
                draw_text_scribble(inventoryMenu[0] + 272, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(displayingInventory[i + startingPosition].inventoryValue));
                draw_set_color(c_white);
                draw_rectangle(inventoryMenu[0] + 310, (inventoryMenu[1] + 60 + (i * 35)) - 10, inventoryMenu[0] + 375, inventoryMenu[1] + 60 + (i * 35) + 10, true);
                draw_set_halign(fa_right);
                draw_text_scribble(inventoryMenu[0] + 374, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(displayingInventory[i + startingPosition].inventoryValue * sellingInventory[i + startingPosition]));
                draw_set_alpha(1);
                if (MouseOverButton("smallShopMenu", inventoryMenu[0] + 35, (inventoryMenu[1] + 60 + (i * 35)) - 13) && !sellConfirm)
                {
                    if (obj_InputManager.MouseMoved() && inventorySelect != i)
                    {
                        inventorySelect = i;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (inventorySelect == i && (!MouseOverButton("arrow", (inventoryMenu[0] + 220) - string_width(string(sellingInventory[i + startingPosition]) + " (" + string(itemHas) + ")") - 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5) && !MouseOverButton("arrow", inventoryMenu[0] + 220 + 9, ((inventoryMenu[1] + 60) - 5) + (i * 35) + 5)))
                    {
                        ClickButton();
                    }
                }
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
            draw_text_scribble(inventoryMenu[0] + 250, inventoryMenu[1] + 244, "Buy Total: ");
            draw_set_font(Galmuri14);
            draw_set_halign(fa_right);
            var totalSale = 0;
            for (var i = 0; i < array_length(sellingInventory); i++)
            {
                totalSale += (displayingInventory[i].inventoryValue * sellingInventory[i]);
            }
            draw_text_scribble(inventoryMenu[0] + 370, inventoryMenu[1] + 237, totalSale);
            draw_rectangle(inventoryMenu[0] + 255, inventoryMenu[1] + 233, inventoryMenu[0] + 375, inventoryMenu[1] + 265, true);
            if (ds_map_find_value(global.PlayerSave, "holoCoins") >= totalSale)
            {
                draw_set_alpha(1);
            }
            else
            {
                draw_set_alpha(0.5);
            }
            draw_sprite(hud_confirmButton, 0, inventoryMenu[0] + 85, inventoryMenu[1] + 249);
            draw_set_color(c_black);
            draw_set_alpha(1);
            draw_set_font(Galmuri9);
            draw_set_halign(fa_center);
            draw_text_scribble(inventoryMenu[0] + 85, inventoryMenu[1] + 244, global.TextContainer.nemuOptions.selectedLanguage[0]);
            startingPosition = ScrollBar(displayingInventory, inventoryMenu[0] + 390, inventoryMenu[1] + 50, inventoryMenu[1] + 220, 1, 5, startingPosition, !sellConfirm && !itemBuyConfirm);
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.nemuOptions.selectedLanguage[i]);
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
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.nemuShop.selectedLanguage);
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
                if (item_get(displayingInventory[i + startingPosition].id) < 1)
                {
                    draw_set_alpha(0.4);
                }
                draw_sprite(displayingInventory[i + startingPosition].inventoryIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 60 + (i * 35));
                draw_text_scribble(inventoryMenu[0] + 50 + 20, ((inventoryMenu[1] + 60) - 5) + (i * 35), displayingInventory[i + startingPosition].inventoryName);
                draw_set_halign(fa_right);
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
                draw_sprite(spr_holoCoin, 0, inventoryMenu[0] + 255, inventoryMenu[1] + 60 + (i * 35));
                draw_set_halign(fa_left);
                draw_text_scribble(inventoryMenu[0] + 272, ((inventoryMenu[1] + 60) - 5) + (i * 35), string(displayingInventory[i + startingPosition].inventoryValue));
                draw_set_color(c_white);
                draw_rectangle(inventoryMenu[0] + 310, (inventoryMenu[1] + 60 + (i * 35)) - 10, inventoryMenu[0] + 375, inventoryMenu[1] + 60 + (i * 35) + 10, true);
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
            draw_set_font(Galmuri14);
            draw_set_halign(fa_right);
            draw_text_scribble(inventoryMenu[0] + 250, inventoryMenu[1] + 244, "Sale Total: ");
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
            startingPosition = ScrollBar(displayingInventory, inventoryMenu[0] + 390, inventoryMenu[1] + 50, inventoryMenu[1] + 220, 1, 5, startingPosition, !sellConfirm && !itemBuyConfirm);
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
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
