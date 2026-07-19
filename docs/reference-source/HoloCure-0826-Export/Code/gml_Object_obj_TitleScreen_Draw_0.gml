draw_set_alpha(1);
if (canControl)
{
    var selectedColor = [16777215, 0];
    var buttonSpacing = 29;
    var buttonX = 530;
    var buttonY = 104;
    draw_set_halign(fa_center);
    for (var i = 0; i < 8; i++)
    {
        if (obj_InputManager.mouseMoving && canControl && MouseOverButton("long", buttonX, buttonY + (i * buttonSpacing), 0.5))
        {
            if (currentOption != i && obj_InputManager.MouseMoved())
            {
                currentOption = i;
                audio_play_sound(snd_menu_select, 30, 0);
            }
        }
        var transparency = 1;
        draw_sprite_ext(hud_initButtons, currentOption == i, buttonX, buttonY + (i * buttonSpacing), 1, 1, 0, c_white, transparency);
    }
    draw_set_font(Galmuri9);
    for (var i = 0; i < 8; i++)
    {
        draw_set_halign(fa_center);
        if (!(i == 1 && !holoHouseUnlocked))
        {
            draw_text_color(buttonX, buttonY + 9 + (i * buttonSpacing), global.TextContainer.titleButtons.selectedLanguage[i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
        else
        {
            draw_text_color(buttonX, buttonY + 9 + (i * buttonSpacing), "????", selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], selectedColor[currentOption == i], 1);
        }
    }
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text_scribble(10, 345, "version " + version);
    commandPromps(true, true, true);
}
