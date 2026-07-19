var selectedColor = [16777215, 0];
commandPromps(true, true, true);
draw_set_halign(fa_center);
draw_set_font(Galmuri14);
draw_text_outline(60, 15, "SHOP", 1, 0, 32, 4, 100, 16777215, 1);
draw_set_halign(fa_right);
draw_set_font(Galmuri14);
draw_sprite_ext(hud_initButtons, 0, 550, 13, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_holoCoin, image_index * 2, 453, 26, 2, 2, 0, c_white, 1);
draw_set_color(c_white);
draw_text_scribble(620, 16, ds_map_find_value(global.PlayerSave, "holoCoins"));
draw_set_halign(fa_left);
if (shopMode == -1)
{
    for (var i = 0; i < 4; i++)
    {
        var transparency = 0.5;
        draw_sprite_ext(hud_initButtons, currentOption == i, 450, 140 + (i * 32), 1, 1, 0, c_white, 0.5 + transparency);
        if (MouseOverButton("long", 450, 140 + (i * 32), 1))
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
    for (var i = 0; i < 4; i++)
    {
        draw_set_halign(fa_center);
        draw_text_color(450, 149 + (i * 32), global.TextContainer.shopButtons.selectedLanguage[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
    }
}
else if (shopMode == 0)
{
    draw_sprite_ext(spr_shopBackDrop, 0, 0, 0, 1, 1, 0, c_white, 0.5);
    draw_sprite(gachaItems[gachaGroupOption].optionSprite, 0, 267, 49);
    if (!itemSelected)
    {
        draw_sprite(spr_gacha_arrows, image_index * 2, 0, 0);
        draw_sprite(ui_menu_upgrade_window_selected, 0, 246, 243);
        DrawGacha(246, 243, gachaItems[gachaGroupOption]);
    }
    draw_set_font(Galmuri14);
    draw_set_halign(fa_center);
    draw_set_halign(fa_left);
    draw_set_color(c_yellow);
    draw_set_font(Galmuri9);
    if (mouse_x > 275 && mouse_y > 54 && mouse_x < 602 && mouse_y < 238 && mouse_check_button_pressed(mb_left) && !itemSelected && !gachaing)
    {
        Confirmed();
    }
    else if (mouse_x > 243 && mouse_y > 54 && mouse_x < 274 && mouse_y < 238 && mouse_check_button_pressed(mb_left) && !itemSelected && !gachaing)
    {
        SelectLeft();
    }
    else if (mouse_x > 602 && mouse_y > 54 && mouse_x < 633 && mouse_y < 238 && mouse_check_button_pressed(mb_left) && !itemSelected && !gachaing)
    {
        SelectRight();
    }
    if (gachaConfirm && mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
    else if (gachaCompleted && mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
    else if (gachaing && gachatime < 160 && mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
    if (itemSelected)
    {
        var haveEnough = 0;
        haveEnough = ds_map_find_value(global.PlayerSave, "holoCoins") >= gachaItems[gachaGroupOption].cost;
        draw_sprite_ext(hud_OptionButton, buyingOption == 0, 440, 255, 1, 1, 0, c_white, 0.5 + (0.5 * haveEnough));
        draw_set_halign(fa_center);
        draw_text_color(440, 263, string(global.TextContainer.shopItemButtons.selectedLanguage[0]) + "  x " + string(gachaQuantity) + "  (" + string(gachaQuantity * 1000) + ")", selectedColor[buyingOption == 0], selectedColor[buyingOption == 0], selectedColor[buyingOption == 0], selectedColor[buyingOption == 0], 1);
        draw_set_halign(fa_center);
        draw_sprite(hud_scrollArrows2, 0, 340, 268);
        draw_sprite(hud_scrollArrows2, 1, 540, 268);
        if (MouseOverButton("long", 440, 255) && !gachaing)
        {
            if (buyingOption != 0 && obj_InputManager.mouseMoving && obj_InputManager.MouseMoved())
            {
                buyingOption = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (mouse_check_button_pressed(mb_left) && buyingOption == 0)
            {
                Confirmed();
            }
        }
        draw_sprite_ext(hud_OptionButton, buyingOption == 1, 440, 290, 1, 1, 0, c_white, 1);
        draw_set_halign(fa_center);
        draw_text_color(440, 297, global.TextContainer.shopItemButtons.selectedLanguage[2], selectedColor[buyingOption == 1], selectedColor[buyingOption == 1], selectedColor[buyingOption == 1], selectedColor[buyingOption == 1], 1);
        if (MouseOverButton("long", 440, 290) && !gachaing)
        {
            if (buyingOption != 1 && obj_InputManager.mouseMoving && obj_InputManager.MouseMoved())
            {
                buyingOption = 1;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (mouse_check_button_pressed(mb_left) && buyingOption == 1)
            {
                Confirmed();
            }
        }
    }
    if (gachaGroupOption < (array_length(gachaItems) - showTeaser))
    {
        draw_sprite(spr_gacha_tear, 0, 295, 100);
        draw_set_halign(fa_left);
        draw_set_color(c_white);
        draw_set_font(Galmuri9);
        draw_text_outline(310, 101, "x " + string(currentTears), 1, 0, 16, 10, 100, 16777215, 1);
    }
}
else if (shopMode == 1)
{
    if (array_length(separatedShop[shopCategory]) > 16)
    {
        draw_set_color(c_black);
        draw_set_alpha(0.5);
        draw_rectangle(618, 90, 632, 265, false);
        draw_set_alpha(1);
    }
    startingPosition = ScrollBar(separatedShop[shopCategory], 625, 95, 260, 4, 4, startingPosition, !itemSelected);
    draw_sprite(ui_menu_upgrade_window_selected, 0, 246, 268);
    draw_sprite(spr_shopBar, 0, 246, 50);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    for (var i = 0; i < 3; i++)
    {
        if (categorySelect && shopCategory == i)
        {
            draw_set_alpha(1);
            draw_sprite(spr_holoCursor, 0, (330 + (i * 120)) - (string_width(global.TextContainer.shopCategories.selectedLanguage[i]) / 2) - 15, 67);
        }
        if (shopCategory == i)
        {
            draw_set_alpha(1);
        }
        else
        {
            draw_set_alpha(0.5);
        }
        draw_text(330 + (i * 120), 61, global.TextContainer.shopCategories.selectedLanguage[i]);
        if (MouseOverButton("shopCategory", 330 + (i * 120), 65) && !itemSelected)
        {
            if (obj_InputManager.MouseMoved())
            {
                categorySelect = true;
            }
            if (shopCategory != i && mouse_check_button_pressed(mb_left))
            {
                shopCategory = i;
                audio_play_sound(snd_menu_select, 0, 0);
            }
        }
    }
    draw_set_alpha(1);
    if (!categorySelect)
    {
        DrawOption(246, 268, separatedShop[shopCategory][shopOption + startingPosition]);
    }
    var offsetY = 30;
    for (var i = 0; i < 4; i++)
    {
        for (var j = 0; j < 4; j++)
        {
            if (((i * 4) + j + startingPosition) < array_length(separatedShop[shopCategory]))
            {
                if (separatedShop[shopCategory][(i * 4) + j + startingPosition] != undefined)
                {
                    draw_set_alpha(0.7);
                    draw_set_color(c_black);
                    draw_rectangle((279 + (j * 90)) - 18, ((80 + (i * 45)) - 18) + offsetY, 279 + (j * 90) + 18, 80 + (i * 45) + 18 + offsetY, false);
                    draw_set_alpha(1);
                    draw_sprite(spr_shopItemBG, 0, 279 + (j * 90), 80 + (i * 45) + offsetY);
                    draw_sprite(separatedShop[shopCategory][(i * 4) + j + startingPosition].optionIcon, 0, 279 + (j * 90), 80 + (i * 45) + offsetY);
                    draw_sprite(spr_shopIcon, 0, 279 + (j * 90), 80 + (i * 45) + offsetY);
                    draw_sprite(spr_shopLevels_Empty, array_length(separatedShop[shopCategory][(i * 4) + j + startingPosition].cost), 279 + (j * 90), 80 + (i * 45) + offsetY);
                    draw_sprite(spr_shopLevels_Filled, ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][(i * 4) + j + startingPosition].optionID), 279 + (j * 90), 80 + (i * 45) + offsetY);
                    if (MouseOverButton("shopIcon", 279 + (j * 90), 80 + (i * 45) + offsetY, 1))
                    {
                        if (mouse_check_button_pressed(mb_left) && (!itemSelected || (itemSelected && ((i * 4) + j) == shopOption)))
                        {
                            Confirmed();
                        }
                        else if (obj_InputManager.mouseMoving && shopOption != ((i * 4) + j) && obj_InputManager.MouseMoved() && !itemSelected)
                        {
                            shopOption = (i * 4) + j;
                            categorySelect = false;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                        else if (obj_InputManager.mouseMoving && categorySelect && obj_InputManager.MouseMoved() && !itemSelected)
                        {
                            categorySelect = false;
                            audio_play_sound(snd_menu_select, 30, 0);
                        }
                    }
                    if (ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][(i * 4) + j + startingPosition].optionID) == array_length(separatedShop[shopCategory][(i * 4) + j + startingPosition].cost))
                    {
                        draw_set_alpha(0.4);
                        draw_set_color(c_black);
                        draw_rectangle((279 + (j * 90)) - 18, ((82 + (i * 45)) - 18) + offsetY, 279 + (j * 90) + 15, 80 + (i * 45) + 17 + offsetY, false);
                        draw_set_alpha(1);
                        draw_sprite(spr_shopLevels_Maxed, 0, 279 + (j * 90), 80 + (i * 45) + offsetY);
                    }
                    draw_set_halign(fa_left);
                    draw_set_color(c_yellow);
                    if (ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][(i * 4) + j + startingPosition].optionID) < array_length(separatedShop[shopCategory][(i * 4) + j + startingPosition].cost))
                    {
                        draw_text_scribble(282 + (j * 90) + 23, 82 + (i * 45) + offsetY, string(array_get(separatedShop[shopCategory][(i * 4) + j + startingPosition].cost, ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][(i * 4) + j + startingPosition].optionID))));
                    }
                    else
                    {
                        draw_text_scribble(282 + (j * 90) + 23, 82 + (i * 45) + offsetY, "SOLD!");
                    }
                    cursorlifetime++;
                    if (((i * 4) + j) == shopOption && !categorySelect)
                    {
                        draw_sprite(spr_shopIconSelected, 0, 279 + (j * 90), 80 + (i * 45) + offsetY);
                        draw_set_alpha(0.05 + abs(0.15 * sin(cursorlifetime / 100)));
                        draw_rectangle_color((279 + (j * 90)) - 21, ((80 + (i * 45)) - 21) + offsetY, 279 + (j * 90) + 65, 80 + (i * 45) + 21 + offsetY, c_white, c_white, c_white, c_white, false);
                        draw_set_alpha(1);
                    }
                }
            }
        }
    }
    if (itemSelected)
    {
        for (var i = 0; i < 2; i++)
        {
            var haveEnough = 0;
            if (i == 0 && ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) < array_length(separatedShop[shopCategory][shopOption + startingPosition].cost))
            {
                haveEnough = ds_map_find_value(global.PlayerSave, "holoCoins") >= array_get(separatedShop[shopCategory][shopOption + startingPosition].cost, ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID));
            }
            if (i == 1)
            {
                haveEnough = ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) > 0;
            }
            draw_sprite_ext(hud_shopButton, buyingOption == i, 400 + (i * 90), 310, 1, 1, 0, c_white, 0.5 + (0.5 * haveEnough));
            draw_set_halign(fa_center);
            draw_text_color(400 + (i * 90), 305, global.TextContainer.shopItemButtons.selectedLanguage[i], selectedColor[buyingOption == i], selectedColor[buyingOption == i], selectedColor[buyingOption == i], selectedColor[buyingOption == i], 1);
            if (MouseOverButton("short", 400 + (i * 90), 310, 1) && itemSelected)
            {
                if (mouse_check_button_pressed(mb_left) && buyingOption == i)
                {
                    Confirmed();
                }
                if (obj_InputManager.mouseMoving && buyingOption != i && obj_InputManager.MouseMoved())
                {
                    if (i == 0 && ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) < array_length(separatedShop[shopCategory][shopOption + startingPosition].cost))
                    {
                        buyingOption = i;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                    else if (i == 1 && ds_map_find_value(global.PlayerSave, separatedShop[shopCategory][shopOption + startingPosition].optionID) > 0)
                    {
                        buyingOption = i;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
            }
        }
    }
}
else if (shopMode == 2)
{
    draw_sprite_ext(spr_shopBackDrop, 0, 35, -5, 0.9, 1.16, 0, c_white, 0.5);
    for (var i = 0; i < 5; i++)
    {
        for (var j = 0; j < 7; j++)
        {
            if (((i * 7) + j + startingPosition) < totalThings)
            {
                if (MouseOverButton("itemCase", 310 + (j * 40), 80 + (i * 37), 1))
                {
                    if (obj_InputManager.mouseMoving && armorySelect != ((i * 7) + j) && obj_InputManager.MouseMoved())
                    {
                        armorySelect = (i * 7) + j;
                        audio_play_sound(snd_menu_select, 30, 0);
                    }
                }
                draw_set_alpha(0.5);
                draw_set_color(c_black);
                draw_rectangle((310 + (j * 40)) - 14, (80 + (i * 37)) - 14, 310 + (j * 40) + 14, 80 + (i * 37) + 14, false);
                draw_set_alpha(1);
                if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), armoryList[(i * 7) + j + startingPosition].optionID) || array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), armoryList[(i * 7) + j + startingPosition].optionID) || array_exists(collabNames, armoryList[(i * 7) + j + startingPosition].optionID))
                {
                    draw_sprite(armoryList[(i * 7) + j + startingPosition].optionIcon, 0, 309 + (j * 40), 80 + (i * 37));
                }
                else
                {
                    draw_sprite(spr_UnknownIcon, 0, 310 + (j * 40), 80 + (i * 37));
                }
                switch (armoryList[(i * 7) + j + startingPosition].optionType)
                {
                    case "Weapon":
                        draw_sprite(spr_optionWeaponIcon, 0, 310 + (j * 40), 80 + (i * 37));
                        break;
                    case "Item":
                        draw_sprite(spr_optionItemIcon, 0, 310 + (j * 40), 80 + (i * 37));
                        break;
                    case "Collab":
                        draw_sprite(spr_optionCollabWeaponIcon, 0, 310 + (j * 40), 80 + (i * 37));
                        break;
                    case "SuperCollab":
                        if (array_exists(ds_map_find_value(global.PlayerSave, "seenCollabs"), "KanaCoco") || array_exists(ds_map_find_value(global.PlayerSave, "seenCollabs"), "IdolLive"))
                        {
                            draw_sprite(spr_optionSuperCollabWeaponIcon, 0, 310 + (j * 40), 80 + (i * 37));
                        }
                        else
                        {
                            draw_sprite(spr_optionMystery, 0, 310 + (j * 40), 80 + (i * 37));
                        }
                        break;
                    default:
                        draw_sprite(hud_optionIconCase, 0, 310 + (j * 40), 80 + (i * 37));
                        break;
                }
            }
            if (armorySelect == ((i * 7) + j))
            {
                draw_sprite(hud_caseSelect_armory, 0, 310 + (j * 40), 80 + (i * 37));
            }
        }
    }
    draw_set_halign(fa_right);
    draw_set_color(c_yellow);
    draw_set_font(Galmuri9);
    draw_text_scribble(580, 250, "Found: " + string(array_length(ds_map_find_value(global.PlayerSave, "unlockedWeapons")) + array_length(ds_map_find_value(global.PlayerSave, "unlockedItems")) + array_length(collabNames)) + " / " + string(totalThings));
    draw_sprite(ui_menu_upgrade_window_selected, 0, 246, 270);
    draw_set_color(c_black);
    draw_set_alpha(0.5);
    draw_rectangle(608, 60, 622, 245, false);
    draw_set_alpha(1);
    draw_sprite(hud_scrollArrows, 0, 615, 65);
    draw_sprite(hud_scrollArrows, 1, 615, 240);
    var itemPerLine = 7;
    var rowsOnScreen = 5;
    var rectHeight = (165 * rowsOnScreen) / ((totalThings div itemPerLine) + ((totalThings % itemPerLine) > 0));
    var scrollDist = 165 / ((totalThings div itemPerLine) + ((totalThings % itemPerLine) > 0));
    draw_set_color(c_white);
    draw_rectangle(613, 69 + (scrollDist * (startingPosition div itemPerLine)), 617, 69 + rectHeight + (scrollDist * (startingPosition div itemPerLine)), false);
    var totalYSpace = 165;
    var yPos = 69;
    var numberOfTicks = ((totalThings div itemPerLine) + ((totalThings % itemPerLine) > 0)) - rowsOnScreen;
    draw_set_color(c_white);
    if (mouse_check_button(mb_left))
    {
        if (mouse_x >= 608 && mouse_x < 622 && mouse_y >= (yPos - (totalYSpace / numberOfTicks)) && mouse_y <= 240)
        {
            for (var j = 0; j < (numberOfTicks + 1); j++)
            {
                if (mouse_y > (yPos + (j * (totalYSpace / (numberOfTicks + 1)))) && mouse_y < (yPos + ((j + 1) * (totalYSpace / (numberOfTicks + 1)))))
                {
                    if (startingPosition != (j * itemPerLine))
                    {
                        startingPosition = j * itemPerLine;
                        audio_play_sound(snd_menu_select, 30, 0);
                        break;
                    }
                }
            }
        }
    }
    if ((armorySelect + startingPosition) < totalThings)
    {
        if (array_exists(ds_map_find_value(global.PlayerSave, "unlockedWeapons"), armoryList[armorySelect + startingPosition].optionID) || array_exists(ds_map_find_value(global.PlayerSave, "unlockedItems"), armoryList[armorySelect + startingPosition].optionID) || array_exists(collabNames, armoryList[armorySelect + startingPosition].optionID))
        {
            DrawOption(246, 270, armoryList[armorySelect + startingPosition], true);
        }
    }
}
else if (shopMode == 3)
{
    draw_set_halign(fa_right);
    draw_set_font(Galmuri14);
    draw_sprite_ext(hud_initButtons, 0, 550, 41, 1, 1, 0, c_white, 1);
    draw_sprite_ext(spr_gacha_tear, 0, 453, 54, 1, 1, 0, c_white, 1);
    draw_set_color(c_white);
    draw_text_scribble(620, 44, currentTears);
    draw_sprite(spr_redeemStage, 0, 255, 84);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_set_font(Galmuri9);
    var char = ds_map_find_value(global.characterData, gachaItems[gachaGroupOption].gachaCharacters[redeemCharacterSelect]);
    draw_set_halign(fa_center);
    draw_set_font(Galmuri14);
    var theOutfits = [];
    redeemCharOutfits = 0;
    if (variable_struct_exists(char, "outfits"))
    {
        redeemCharOutfits = variable_struct_names_count(char.outfits);
        theOutfits = variable_struct_get_names(char.outfits);
    }
    var charX = 430;
    var charY = 230;
    shader_set_uniform_f(grayscale, 1);
    var charIndex = 0;
    for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == char.id)
        {
            charIndex = i;
        }
    }
    if (outfitSelect == 0)
    {
        if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), charIndex), 1) != 0)
        {
            draw_sprite_ext(char.sprite1, image_index / 2, charX + 6, charY + 6, -3, 3, 0, c_white, 0.1);
            draw_sprite_ext(char.sprite1, image_index / 2, charX, charY, -3, 3, 0, c_white, 1);
        }
        else
        {
            shader_set(grayScale);
            draw_sprite_ext(char.sprite1, 0, charX + 6, charY + 6, -3, 3, 0, c_white, 0.1);
            draw_sprite_ext(char.sprite1, 0, charX, charY, -3, 3, 0, c_white, 1);
            shader_reset();
        }
        if (array_length(theOutfits) > 0)
        {
            var of = variable_struct_get(char.outfits, theOutfits[0]);
            if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), of.outfitID))
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(of.sprites[0].sprite1, 0, charX + 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
        if (array_length(theOutfits) > 0 && array_length(theOutfits) < 2)
        {
            var of = variable_struct_get(char.outfits, theOutfits[0]);
            if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), of.outfitID))
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(of.sprites[0].sprite1, 0, charX - 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
        else if (array_length(theOutfits) > 0)
        {
            var of = variable_struct_get(char.outfits, theOutfits[array_length(theOutfits) - 1]);
            if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), of.outfitID))
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(of.sprites[0].sprite1, 0, charX - 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
    }
    else if ((outfitSelect - 1) < array_length(theOutfits))
    {
        var of = variable_struct_get(char.outfits, theOutfits[outfitSelect - 1]);
        var ofUnlocked = image_index / 2;
        if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), of.outfitID))
        {
            shader_set(grayScale);
            ofUnlocked = 0;
        }
        draw_sprite_ext(of.sprites[0].sprite1, ofUnlocked, charX + 6, charY + 6, -3, 3, 0, c_white, 0.1);
        draw_sprite_ext(of.sprites[0].sprite1, ofUnlocked, charX, charY, -3, 3, 0, c_white, 1);
        shader_reset();
        if (array_length(theOutfits) > outfitSelect)
        {
            of = variable_struct_get(char.outfits, theOutfits[outfitSelect]);
            if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), of.outfitID))
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(of.sprites[0].sprite1, 0, charX + 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
        else
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), charIndex), 1) == 0)
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(char.sprite1, 0, charX + 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
        if (outfitSelect == 1)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), charIndex), 1) == 0)
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(char.sprite1, 0, charX - 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
        else
        {
            of = variable_struct_get(char.outfits, theOutfits[outfitSelect - 2]);
            if (!array_exists(ds_map_find_value(global.PlayerSave, "unlockedOutfits"), of.outfitID))
            {
                shader_set(grayScale);
            }
            draw_sprite_ext(of.sprites[0].sprite1, 0, charX - 120, charY - 10, -2, 2, 0, c_white, 0.4);
            shader_reset();
        }
    }
    if (redeemCharOutfits > 0)
    {
        var imNum = sprite_get_number(spr_StageSelectArrows);
        draw_sprite(spr_StageSelectArrows, (animPlayingSpeed / room_speed) * imNum, 440, 190);
    }
    var tearsSingleCost = 7 + ((outfitSelect > 0) * 8);
    var enoughTears = currentTears >= (tearsSingleCost * gachaTearsQuantity);
    if (mouse_x > 265 && mouse_y > 64 && mouse_x < 592 && mouse_y < 248 && mouse_check_button_pressed(mb_left) && !redeemSelected)
    {
        Confirmed();
    }
    if (gachaConfirm && mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
    else if (gachaCompleted && mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
    else if (gachaing && gachatime < 160 && mouse_check_button_pressed(mb_left))
    {
        Confirmed();
    }
    if (char.id != "")
    {
        for (var i = 0; i < array_length(ds_map_find_value(global.PlayerSave, "characters")); i++)
        {
            if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) >= 0)
            {
                if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 0) == char.id)
                {
                    draw_set_font(Galmuri9);
                    draw_set_halign(fa_left);
                    draw_text_scribble(280, 237, char.charName);
                    if (array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1) > 1)
                    {
                        draw_text_scribble(280, 252, "[c_yellow]G. RANK: " + string(array_get(array_get(ds_map_find_value(global.PlayerSave, "characters"), i), 1)) + "[/color]");
                    }
                }
            }
        }
    }
    draw_set_font(Galmuri9);
    draw_set_color(c_black);
    draw_set_halign(fa_left);
    var cost = 7 + ((outfitSelect > 0) * 8);
    draw_text_outline(510, 258, "COST:        " + string(cost), 1, 0, 16, 0, 300, 16777215, 1);
    draw_sprite(spr_gacha_tear, 0, 560, 262);
    if (redeemSelected)
    {
        draw_sprite_ext(hud_OptionButton, 1, 430, 290, 1, 1, 0, c_white, 0.5 + (enoughTears * 0.5));
        draw_set_halign(fa_center);
        draw_text_scribble(428, 298, "Redeem  x " + string(gachaTearsQuantity) + "  (" + string(gachaTearsQuantity * tearsSingleCost) + ")");
        draw_sprite(hud_scrollArrows2, 0, 350, 303);
        draw_sprite(hud_scrollArrows2, 1, 510, 303);
        if (MouseOverButton("long", 430, 290, 1) && mouse_check_button_pressed(mb_left))
        {
            Confirmed();
        }
    }
    var group = gachaItems[gachaGroupOption].gachaCharacters;
    var middle = 180;
    for (var i = 0; i < array_length(group); i++)
    {
        var sprite = ds_map_find_value(global.characterData, gachaItems[gachaGroupOption].gachaCharacters[i]).port;
        var selected = i == redeemCharacterSelect;
        draw_sprite_part_ext(sprite, 0, 0, 0, 49, 25, 655 - (15 * selected), (middle - ((array_length(group) / 2) * 25)) + (i * 26), -1, 1, c_white, 0.5 + (0.5 * selected));
        if (selected)
        {
            draw_sprite(spr_redeemCharSelect, 0, 640, (middle - ((array_length(group) / 2) * 25)) + (i * 26));
        }
        if (MouseOverButton("characterSelect", 595, (middle - ((array_length(group) / 2) * 25)) + (i * 26), 1, 25))
        {
            if (obj_InputManager.mouseMoving && redeemCharacterSelect != i && obj_InputManager.MouseMoved() && !redeemSelected)
            {
                redeemCharacterSelect = i;
                outfitSelect = 0;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
    }
}
draw_sprite(sprite_index, image_index, -5, 0);
if (gachaing)
{
    draw_set_color(c_black);
    draw_set_alpha(0.8);
    draw_rectangle(0, 0, 640, 360, false);
    draw_set_alpha(1);
    if (gachaConfirm)
    {
        draw_sprite(spr_gacha_holologo, 0, 320, 180);
        draw_sprite_ext(hud_shopButton, 1, 320, 300, 1, 1, 0, c_white, 1);
        draw_set_halign(fa_center);
        draw_text_color(320, 294, global.TextContainer.gachaButton.selectedLanguage, c_black, c_black, c_black, c_black, 1);
    }
    if (readyToDebut)
    {
        if (gachatime == 0)
        {
            var fx = instance_create_depth(320, 180, depth - 10, obj_vfx);
            fx.sprite_index = spr_gacha_pulse;
            audio_play_sound(snd_gachading, 10, false);
        }
        if (gachatime == 30)
        {
            audio_play_sound(snd_gachaopening, 10, false);
        }
        if (gachatime < 30)
        {
            draw_sprite(spr_gacha_holologo, 0, 320, 180);
        }
        if (gachatime >= 30 && gachatime <= 160)
        {
            draw_sprite_ext(spr_gacha_holologo, 0, 315 + random(10), 175 + random(10), 1 + ((gachatime - 30) * 0.005), 1 + ((gachatime - 30) * 0.005), 0, c_white, 1);
            var roll = irandom(3);
            switch (roll)
            {
                case 0:
                    instance_create_depth(random(640), 0, depth - 10, obj_gachaorb);
                    break;
                case 1:
                    instance_create_depth(random(640), 360, depth - 10, obj_gachaorb);
                    break;
                case 2:
                    instance_create_depth(640, random(360), depth - 10, obj_gachaorb);
                    break;
                case 3:
                    instance_create_depth(0, random(360), depth - 10, obj_gachaorb);
                    break;
            }
            roll = irandom(3);
            switch (roll)
            {
                case 0:
                    instance_create_depth(random(640), 0, depth - 10, obj_risingParticle2);
                    break;
                case 1:
                    instance_create_depth(random(640), 360, depth - 10, obj_risingParticle2);
                    break;
                case 2:
                    instance_create_depth(640, random(360), depth - 10, obj_risingParticle2);
                    break;
                case 3:
                    instance_create_depth(0, random(360), depth - 10, obj_risingParticle2);
                    break;
            }
        }
        if (gachatime == 160)
        {
            whiteFlash = true;
            gachaCompleted = true;
            canControl = false;
            alarm[0] = 30;
            audio_play_sound(snd_gacha_get, 50, 0);
            for (var i = 0; i < 300; i++)
            {
                var sparks = instance_create_depth(320, 180, depth, obj_sparkle);
            }
        }
        gachatime++;
    }
    if (gachaCompleted)
    {
        gpu_set_blendmode(bm_add);
        draw_sprite_ext(hud_boxSpotLight, 0, 0, 0, 1, 1, 45, c_white, 1);
        draw_sprite_ext(hud_boxSpotLight, 0, 640, 0, -1, 1, -45, c_white, 1);
        gpu_set_blendmode(bm_normal);
        var sparks = instance_create_depth(random(640), -10, depth - 20, obj_sparkle);
        sparks.speed = 0;
        var lights = instance_create_depth(295 + random(50), 365, depth - 20, obj_idollights);
        lights.rotDir = 1 - (random(1) * 2);
        lights.rotSpeed = 2 + random(2);
    }
    if (whiteFlash)
    {
        flashTime++;
        draw_set_color(c_white);
        draw_set_alpha(1 - (flashTime / 60));
        draw_rectangle(0, 0, 640, 360, false);
        if (flashTime > 60)
        {
            flashTime = 0;
            whiteFlash = false;
        }
    }
}
