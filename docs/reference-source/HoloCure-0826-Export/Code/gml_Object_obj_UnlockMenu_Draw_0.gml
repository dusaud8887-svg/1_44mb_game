var selectedColor = [16777215, 0];
draw_set_halign(fa_center);
draw_set_font(Galmuri14);
draw_text_outline(320, 30, "NEW UNLOCKS!", 1, 0, 32, 4, 400, 16777215, 1);
commandPromps(true, true, false);
if (itemContainer[0] > 120)
{
    itemContainer[0] -= 100;
}
else if (itemContainer[0] < 120)
{
    itemContainer[0] = 120;
}
if (array_length(global.unlockedThings) > 0 && currentThing < array_length(global.unlockedThings))
{
    draw_sprite(ui_menu_upgrade_window_selected, 0, itemContainer[0], itemContainer[1]);
    DrawOption(itemContainer[0], itemContainer[1], global.unlockedThings[currentThing]);
    draw_sprite_ext(hud_shopButton, 1, 320, 256, 1, 1, 0, c_white, 1);
    draw_set_halign(fa_center);
    draw_text_color(320, 250, "OK", c_black, c_black, c_black, c_black, 1);
}
if (MouseOverButton("short", 320, 256))
{
    ClickButton();
}
