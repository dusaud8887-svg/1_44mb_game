var selectedColor = [16777215, 0];
rectTime++;
if (rectTime >= 20)
{
    rectTime = 0;
    rectVis = -rectVis;
}
draw_sprite(spr_enterArrow, image_index, 569, 333);
draw_set_halign(fa_left);
draw_text_scribble(590, 335, global.TextContainer.hiscoreButtons.selectedLanguage[2]);
switch (initStep)
{
    case 0:
        draw_set_halign(fa_center);
        draw_text_scribble(320, 120, "Language / 言語 / Bahasa");
        for (var i = 0; i < 3; i++)
        {
            draw_sprite(hud_initButtons, currentOption == i, 320, 156 + (i * 34));
            if (MouseOverButton("long", 320, 156 + (i * 34)))
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
            draw_text_color(320, 165 + (i * 34), initLangOptions[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
        break;
    case 1:
        if (getTextManager > 0)
        {
            draw_set_halign(fa_center);
            draw_set_font(Galmuri9);
            draw_set_color(c_white);
            draw_text_scribble(320, 120, global.TextContainer.gameEnterName.selectedLanguage);
            draw_set_halign(fa_left);
            draw_rectangle(255, 165, 385, 185, true);
            draw_text_scribble(264, 170, inputText);
            if (rectVis)
            {
                draw_rectangle(264 + string_width(inputText), 169, 264 + string_width(inputText) + 7, 181, false);
            }
        }
        break;
    case 2:
        draw_set_halign(fa_center);
        draw_text_scribble(320, 120, global.TextContainer.gameShowNames.selectedLanguage);
        for (var i = 0; i < 2; i++)
        {
            draw_sprite(hud_initButtons, currentOption == i, 320, 156 + (i * 34));
            if (MouseOverButton("long", 320, 156 + (i * 34)))
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
        for (var i = 0; i < 2; i++)
        {
            draw_set_halign(fa_center);
            draw_text_color(320, 165 + (i * 34), global.TextContainer.gameNameOption.selectedLanguage[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
        draw_text_scribble_ext(320, 250, global.TextContainer.gameShowNamesWarning.selectedLanguage, 500);
        break;
    case 3:
        draw_set_halign(fa_center);
        draw_text_scribble(320, 70, "[c_yellow]" + string(global.TextContainer.gameEnterName.selectedLanguage) + ": " + string(global.username) + "[/color]");
        draw_set_halign(fa_center);
        draw_text_scribble(320, 105, global.TextContainer.gameUseName.selectedLanguage);
        for (var i = 0; i < 2; i++)
        {
            draw_sprite(hud_initButtons, currentOption == i, 320, 171 + (i * 34));
            if (MouseOverButton("long", 320, 171 + (i * 34)))
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
        for (var i = 0; i < 2; i++)
        {
            draw_set_halign(fa_center);
            draw_text_color(320, 181 + (i * 34), global.TextContainer.gameUseOption.selectedLanguage[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
        break;
    case 4:
        draw_set_halign(fa_left);
        draw_text_scribble(200, 90, global.TextContainer.optionButtons.selectedLanguage[6]);
        draw_text_scribble(400, 90, initLangOptions[langOption]);
        draw_text_scribble(200, 120, global.TextContainer.gameEnterName.selectedLanguage);
        draw_text_scribble(400, 120, global.username);
        draw_text_scribble(200, 150, global.TextContainer.hiScoreOptions.selectedLanguage[1]);
        draw_text_scribble(400, 150, global.TextContainer.gameNameOption.selectedLanguage[hnShow]);
        draw_text_scribble(200, 180, global.TextContainer.hiScoreOptions.selectedLanguage[2]);
        draw_text_scribble(400, 180, global.TextContainer.gameUseOption.selectedLanguage[useName]);
        for (var i = 0; i < 2; i++)
        {
            draw_sprite(hud_initButtons, currentOption == i, 320, 226 + (i * 34));
            if (MouseOverButton("long", 320, 226 + (i * 34)))
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
        for (var i = 0; i < 2; i++)
        {
            draw_set_halign(fa_center);
            draw_text_color(320, 235 + (i * 34), global.TextContainer.gameFinalizeOption.selectedLanguage[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
        break;
}
