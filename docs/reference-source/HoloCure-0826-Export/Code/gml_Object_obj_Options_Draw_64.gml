var selectedColor = [16777215, 0];
draw_sprite(hud_optionsmenu, 0, container[0], container[1]);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(Galmuri14);
var showingSettings = -1;
if (optionPage == 0)
{
    showingSettings = global.TextContainer.optionButtons;
}
else
{
    showingSettings = global.TextContainer.graphicOptions;
}
if (room == rm_Title)
{
    commandPromps(true, true, true);
}
else
{
    commandPromps(true, true, true);
}
if (!keybindMenu && !controllerMenu)
{
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_set_font(Galmuri14);
    draw_text_outline(container[0], container[1] + 13, "SETTINGS", 1, 0, 32, 4, 100, 0, 1);
    draw_text_outline(container[0], container[1] + 10, "SETTINGS", 1, 0, 32, 4, 100, 16777215, 1);
    for (var i = 0; i < 7; i++)
    {
        var screensize = 1;
        if (room == rm_PauseRoom)
        {
            screensize++;
        }
        if (obj_InputManager.mouseMoving && MouseOverButton("long", container[0] + 12, container[1] + 43 + (i * 34), screensize) && !remapping && !changingName && !deleteConfirm)
        {
            if (currentOption != i && obj_InputManager.MouseMoved())
            {
                currentOption = i;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        draw_sprite(hud_OptionButton, currentOption == i, container[0] + 12, container[1] + 43 + (i * 34));
        if (optionPage == 0)
        {
            draw_sprite(hud_optionIcons, ((i + showOptionRange) * 2) + (currentOption == i), container[0] - 98, container[1] + 56 + (i * 34));
        }
        else if (optionPage == 1)
        {
            draw_sprite(hud_graphicIcons, ((i + showOptionRange) * 2) + (currentOption == i), container[0] - 98, container[1] + 56 + (i * 34));
        }
    }
    draw_set_font(Galmuri9);
    for (var i = 0; i < 7; i++)
    {
        draw_set_halign(fa_left);
        if ((i + showOptionRange) == UnknownEnum.Value_9 && optionPage == 0)
        {
            draw_text_color(container[0] - 66, container[1] + 51 + (i * 34), showingSettings.selectedLanguage[i + showOptionRange], c_red, c_red, c_red, c_red, 1);
        }
        else
        {
            draw_text_color(container[0] - 66, container[1] + 51 + (i * 34), showingSettings.selectedLanguage[i + showOptionRange], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
        if (optionPage == 0 && !controllerMenu && !keybindMenu)
        {
            switch (i + showOptionRange)
            {
                case UnknownEnum.Value_1:
                    draw_sprite(hud_sliderBar, 0, container[0] + 10, container[1] + 43 + (i * 34));
                    draw_sprite(hud_slider, 0, container[0] + 20 + (global.musicVolume * 70), container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_2:
                    draw_sprite(hud_sliderBar, 0, container[0] + 10, container[1] + 43 + (i * 34));
                    draw_sprite(hud_slider, 0, container[0] + 20 + (global.soundVolume * 70), container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_3:
                    draw_set_halign(fa_center);
                    break;
                case UnknownEnum.Value_5:
                    draw_sprite(hud_toggleButton, global.vibration + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_7:
                    draw_sprite(hud_toggleButton, global.hhCustomNames + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_8:
                    draw_sprite(hud_toggleButton, global.hhMessages + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_6:
                    draw_set_halign(fa_center);
                    draw_sprite(hud_scrollArrows2, 0, (container[0] + 52) - 38, container[1] + 56 + (i * 34));
                    draw_sprite(hud_scrollArrows2, 1, container[0] + 52 + 38, container[1] + 56 + (i * 34));
                    draw_text_color(container[0] + 52, container[1] + 51 + (i * 34), languageOptions[selectedLanguageOption], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
            }
        }
        else if (optionPage == 1)
        {
            switch (i + showOptionRange)
            {
                case UnknownEnum.Value_0:
                    draw_set_halign(fa_center);
                    draw_sprite(hud_scrollArrows2, 0, (container[0] + 52) - 38, container[1] + 56 + (i * 34));
                    draw_sprite(hud_scrollArrows2, 1, container[0] + 52 + 38, container[1] + 56 + (i * 34));
                    draw_text_color(container[0] + 52, container[1] + 51 + (i * 34), resolutionOptions[selectedResolution], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case UnknownEnum.Value_1:
                    draw_sprite(hud_toggleButton, global.fullscreen + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_3:
                    draw_sprite(hud_toggleButton, global.showDamageText + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_4:
                    draw_sprite(hud_toggleButton, global.lightFX + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_5:
                    draw_sprite(hud_toggleButton, global.screenshake + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_2:
                    draw_sprite(hud_sliderBar, 0, container[0] + 10, container[1] + 43 + (i * 34));
                    draw_sprite(hud_slider, 0, container[0] + 20 + (((global.attackAlpha - 0.3) / 0.7) * 70), container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_7:
                    draw_sprite(hud_toggleButton, global.showHUDHP + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_8:
                    draw_sprite(hud_toggleButton, global.showHPVal + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_6:
                    draw_set_halign(fa_center);
                    draw_sprite(hud_scrollArrows2, 0, (container[0] + 52) - 18, container[1] + 56 + (i * 34));
                    draw_sprite(hud_scrollArrows2, 1, container[0] + 52 + 38, container[1] + 56 + (i * 34));
                    draw_text_color(container[0] + 64, container[1] + 51 + (i * 34), global.TextContainer.portDisplay.selectedLanguage[global.portDisplay], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case UnknownEnum.Value_9:
                    draw_sprite(hud_toggleButton, global.aboveHP + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_10:
                    draw_sprite(hud_toggleButton, global.hideFullHP + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_11:
                    draw_sprite(hud_toggleButton, global.showSkillRadius + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
                case UnknownEnum.Value_12:
                    draw_sprite(hud_toggleButton, global.showStamps + (2 * (currentOption == i)), container[0] + 81, container[1] + 56 + (i * 34));
                    break;
            }
        }
    }
    draw_sprite(hud_scrollArrows, 0, container[0] + 109, container[1] + 39);
    draw_sprite(hud_scrollArrows, 1, container[0] + 109, container[1] + 269);
    var rectHeight = 1540 / maxOptions[optionPage];
    var scrollDist = 220 / maxOptions[optionPage];
    draw_set_color(c_white);
    draw_rectangle(container[0] + 108, container[1] + 44 + (scrollDist * showOptionRange), container[0] + 110, container[1] + 44 + rectHeight + (scrollDist * showOptionRange), false);
}
else if (keybindMenu)
{
    draw_set_font(Galmuri14);
    draw_set_halign(fa_center);
    draw_text_outline(container[0], container[1] + 13, "KEYBINDS", 1, 0, 32, 4, 100, 0, 1);
    draw_text_outline(container[0], container[1] + 10, "KEYBINDS", 1, 0, 32, 4, 100, 16777215, 1);
    for (var i = 0; i < 7; i++)
    {
        var screensize = 1;
        if (room == rm_PauseRoom)
        {
            screensize++;
        }
        if (obj_InputManager.mouseMoving && MouseOverButton("long", container[0] + 12, container[1] + 43 + (i * 34), screensize) && !remapping && !changingName && !deleteConfirm)
        {
            if (currentOption != i && obj_InputManager.MouseMoved())
            {
                currentOption = i;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        draw_sprite(hud_OptionButton, currentOption == i, container[0] + 12, container[1] + 43 + (i * 34));
        draw_sprite(hud_keybindIcons, ((i + showOptionRange) * 2) + (currentOption == i), container[0] - 98, container[1] + 56 + (i * 34));
    }
    draw_set_font(Galmuri9);
    if (instance_exists(inputMan))
    {
        for (var i = 0; i < 7; i++)
        {
            draw_set_halign(fa_left);
            draw_text_color(container[0] - 66, container[1] + 51 + (i * 34), global.TextContainer.KeyBindButtons.selectedLanguage[i + showOptionRange], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
            draw_set_halign(fa_right);
            draw_set_color(c_black);
            if (remapping && currentOption == i)
            {
                draw_set_alpha(0.5);
                draw_rectangle(container[0] + 50, container[1] + 48 + (i * 34), container[0] + 91, container[1] + 65 + (i * 34), false);
                draw_set_alpha(1);
            }
            switch (i + showOptionRange)
            {
                case 0:
                    draw_text_color(container[0] + 90, container[1] + 51 + (i * 34), key_to_string(global.theButtons[i]), selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case 1:
                    draw_text_color(container[0] + 90, container[1] + 51 + (i * 34), key_to_string(global.theButtons[i]), selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case 2:
                    draw_text_color(container[0] + 90, container[1] + 51 + (i * 34), key_to_string(global.theButtons[i]), selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case 3:
                    draw_text_color(container[0] + 90, container[1] + 51 + (i * 34), key_to_string(global.theButtons[i]), selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case 4:
                    draw_text_color(container[0] + 90, container[1] + 51 + (i * 34), key_to_string(global.theButtons[i]), selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
                case 5:
                    draw_text_color(container[0] + 90, container[1] + 51 + (i * 34), key_to_string(global.theButtons[i]), selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
                    break;
            }
        }
    }
}
else if (controllerMenu)
{
    draw_set_font(Galmuri14);
    draw_set_halign(fa_center);
    draw_text_outline(container[0], container[1] + 13, "CONTROLLER", 1, 0, 32, 4, 100, 0, 1);
    draw_text_outline(container[0], container[1] + 10, "CONTROLLER", 1, 0, 32, 4, 100, 16777215, 1);
    for (var i = 0; i < 7; i++)
    {
        var screensize = 1;
        if (room == rm_PauseRoom)
        {
            screensize++;
        }
        if (obj_InputManager.mouseMoving && MouseOverButton("long", container[0] + 12, container[1] + 43 + (i * 34), screensize) && !remapping && !changingName && !deleteConfirm)
        {
            if (currentOption != i && obj_InputManager.MouseMoved())
            {
                currentOption = i;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        draw_sprite(hud_OptionButton, currentOption == i, container[0] + 12, container[1] + 43 + (i * 34));
    }
    draw_sprite(spr_brackets, 0, 228, 104);
    draw_set_font(Galmuri9);
    if (instance_exists(inputMan))
    {
        for (var i = 0; i < 7; i++)
        {
            draw_set_halign(fa_left);
            draw_text_color(container[0] - 66, container[1] + 51 + (i * 34), global.TextContainer.controllerButtons.selectedLanguage[i + showOptionRange], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
            draw_set_halign(fa_right);
            draw_set_color(c_black);
            if (currentOption == i && i != 6)
            {
                draw_set_alpha(0.5);
                draw_rectangle((container[0] + 75) - 12, container[1] + 46 + (i * 34), container[0] + 75 + 12, container[1] + 67 + (i * 34), false);
                draw_set_alpha(1);
            }
            if (i != 6)
            {
                draw_sprite(hud_scrollArrows2, 0, (container[0] + 75) - 18, container[1] + 56 + (i * 34));
                draw_sprite(hud_scrollArrows2, 1, container[0] + 75 + 18, container[1] + 56 + (i * 34));
                draw_sprite(hud_controllerButtonIcons, currentPositions[i], container[0] + 75, container[1] + 56 + (i * 34));
            }
        }
    }
    if (controllerSet)
    {
        draw_text_outline(container[0] + 80, container[1] + 50 + 204, "OK!", 1, 16777215, 16, 10, 100, 32768, 1);
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
if (deleteConfirm)
{
    draw_sprite(spr_option_widebox, 0, 320, 130);
    draw_set_halign(fa_center);
    draw_text_scribble_ext(320, 140, global.TextContainer.deleteSaveWarning.selectedLanguage, 280, 14);
    for (var j = 0; j < 2; j++)
    {
        draw_sprite_ext(hud_confirmButton2, deleteOption == j, 270 + (j * 100), 215, 1, 1, 0, c_white, 1);
        draw_set_color(selectedColor[deleteOption == j]);
        var holdTimer = "";
        if (holdDeleteTimer < 180 && j == 0)
        {
            holdTimer = " (" + string(holdDeleteTimer div 60) + ")";
        }
        draw_text_scribble(270 + (j * 100), 208, global.TextContainer.farmConfirm.selectedLanguage[j] + holdTimer);
        draw_set_alpha(1);
        if (MouseOverButton("short", 270 + (j * 100), 215))
        {
            if (obj_InputManager.MouseMoved() && deleteOption != j && canControl && deleteConfirm)
            {
                deleteOption = j;
                audio_play_sound(snd_menu_select, 30, 0);
            }
            if (deleteOption == j)
            {
                ClickButton();
            }
        }
    }
}

enum UnknownEnum
{
    Value_0,
    Value_1,
    Value_2,
    Value_3,
    Value_4,
    Value_5,
    Value_6,
    Value_7,
    Value_8,
    Value_9,
    Value_10,
    Value_11,
    Value_12
}
