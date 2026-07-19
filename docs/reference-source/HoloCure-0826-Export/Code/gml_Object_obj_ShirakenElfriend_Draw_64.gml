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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.shirakenElfriendOptions.selectedLanguage[i]);
                draw_set_alpha(1);
                if (MouseOverButton("levelButton", menuContainer[0], menuContainer[1] + (i * 30)))
                {
                    if (obj_InputManager.MouseMoved() && pauseOption != i && canControl && !resetConfirm)
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
            if (resetConfirm)
            {
                draw_sprite(hud_farmConfirmWindow, 0, 208, 130);
                draw_set_halign(fa_center);
                draw_text_scribble_ext(320, 140, global.TextContainer.shirakenElfriendReset.selectedLanguage, 150, 14);
                for (var j = 0; j < 2; j++)
                {
                    draw_sprite_ext(hud_confirmButton2, resetOption == j, 270 + (j * 100), 225, 1, 1, 0, c_white, 1);
                    draw_set_color(selectedColor[resetOption == j]);
                    draw_text_scribble(270 + (j * 100), 218, global.TextContainer.farmConfirm.selectedLanguage[j]);
                    draw_set_alpha(1);
                    if (MouseOverButton("short", 270 + (j * 100), 225))
                    {
                        if (obj_InputManager.MouseMoved() && resetOption != j && canControl && resetConfirm)
                        {
                            resetOption = j;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        if (resetOption == j)
                        {
                            ClickButton();
                        }
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
                draw_text_scribble(menuContainer[0], menuContainer[1] + 5 + (30 * i), global.TextContainer.shirakenElfriendOptions.selectedLanguage[i]);
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
            draw_text_scribble(inventoryMenu[0] + 200, inventoryMenu[1] + 10, global.TextContainer.shirakenElfriendShop.selectedLanguage);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            for (var i = 0; i < 10; i++)
            {
                draw_sprite_ext(spr_FurnitureCategoryIcons, i, ((inventoryMenu[0] + 200) - 158) + (i * 35), inventoryMenu[1] + 60, 1, 1, 0, c_white, 0.5 + (0.5 * (furnitureCategory == (i - 1) || i == 0 || i == 9)));
                if (i != 0 && i != 9 && MouseOverButton("itemCase", ((inventoryMenu[0] + 200) - 158) + (i * 35), inventoryMenu[1] + 60) && !itemBuyConfirm && !resetConfirm)
                {
                    if (mouse_check_button_pressed(mb_left) && furnitureCategory != (i - 1))
                    {
                        furnitureCategory = i - 1;
                        startingPosition = 0;
                        inventorySelect = 0;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                }
            }
            for (var i = 0; i < min(5, array_length(obj_HoloHouseManager.allFurnitureArray[furnitureCategory])); i++)
            {
                if (!itemBuyConfirm && inventorySelect == i)
                {
                    draw_sprite(spr_holoCursor, image_index / 3, inventoryMenu[0] + 22, inventoryMenu[1] + 100 + (i * 35));
                    draw_set_alpha(0.15 + (0.1 * sin(cursorTime / 10)));
                    draw_set_color(c_white);
                    draw_rectangle(inventoryMenu[0] + 35, (inventoryMenu[1] + 100 + (i * 35)) - 13, inventoryMenu[0] + 380, inventoryMenu[1] + 100 + (i * 35) + 13, false);
                    draw_set_alpha(1);
                }
                var furnUnlocked = furniture_unlocked(obj_HoloHouseManager.allFurnitureArray[furnitureCategory][i + startingPosition].furnitureID);
                if (furnUnlocked)
                {
                    draw_set_alpha(0.5);
                }
                else
                {
                    draw_set_alpha(1);
                }
                draw_set_halign(fa_left);
                draw_set_color(c_white);
                draw_sprite(obj_HoloHouseManager.allFurnitureArray[furnitureCategory][i + startingPosition].furnitureIcon, 0, inventoryMenu[0] + 50, inventoryMenu[1] + 100 + (i * 35));
                draw_text(inventoryMenu[0] + 70, (inventoryMenu[1] - 5) + 100 + (i * 35), obj_HoloHouseManager.allFurnitureArray[furnitureCategory][i + startingPosition].furnitureName);
                if (itemBuyConfirm && inventorySelect == i)
                {
                    var valid = false;
                    draw_set_halign(fa_center);
                    if (ds_map_find_value(global.PlayerSave, "holoCoins") >= obj_HoloHouseManager.allFurnitureArray[furnitureCategory][i + startingPosition].furnitureCost)
                    {
                        valid = true;
                    }
                    draw_sprite_ext(hud_LevelButton, inventorySelect == i, inventoryMenu[0] + 320, inventoryMenu[1] + 90 + (i * 35), 1, 1, 0, c_white, 0.5 + (valid * 0.5));
                    draw_set_color(selectedColor[inventorySelect == i]);
                    draw_text_scribble(inventoryMenu[0] + 320, (inventoryMenu[1] - 5) + 100 + (i * 35), global.TextContainer.fishRod.selectedLanguage[1]);
                    draw_set_alpha(1);
                }
                else if (furnUnlocked)
                {
                    draw_set_halign(fa_right);
                    draw_set_color(c_yellow);
                    draw_text(inventoryMenu[0] + 370, (inventoryMenu[1] - 5) + 100 + (i * 35), "SOLD OUT!");
                }
                else
                {
                    draw_text(inventoryMenu[0] + 270, (inventoryMenu[1] - 5) + 100 + (i * 35), "COST:");
                    draw_set_halign(fa_right);
                    draw_set_color(c_yellow);
                    draw_text(inventoryMenu[0] + 370, (inventoryMenu[1] - 5) + 100 + (i * 35), obj_HoloHouseManager.allFurnitureArray[furnitureCategory][i + startingPosition].furnitureCost);
                }
                if (MouseOverButton("smallShopMenu", inventoryMenu[0] + 35, (inventoryMenu[1] + 100 + (i * 35)) - 13) && !itemBuyConfirm && !resetConfirm)
                {
                    if (obj_InputManager.MouseMoved() && inventorySelect != i)
                    {
                        inventorySelect = i;
                        audio_play_sound(snd_menu_select, 0, 0);
                    }
                    if (inventorySelect == i)
                    {
                        ClickButton();
                    }
                }
                else if (MouseOverButton("levelButton", inventoryMenu[0] + 320, inventoryMenu[1] + 90 + (i * 35)) && itemBuyConfirm && !resetConfirm)
                {
                    if (inventorySelect == i)
                    {
                        ClickButton();
                    }
                }
            }
            draw_set_alpha(1);
            startingPosition = ScrollBar(obj_HoloHouseManager.allFurnitureArray[furnitureCategory], inventoryMenu[0] + 390, inventoryMenu[1] + 90, inventoryMenu[1] + 250, 1, 5, startingPosition, !sellConfirm && !itemBuyConfirm);
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
            startingPosition = ScrollBar(displayingInventory, inventoryMenu[0] + 390, inventoryMenu[1] + 50, inventoryMenu[1] + 220, 1, 5, startingPosition, !sellConfirm && !itemBuyConfirm);
            break;
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1
}
