if (array_length(achievementPopUps) > 0)
{
    set_gui_size(640, 360);
    draw_sprite(spr_achievementPopUp, 0, popUpContainer[0], popUpContainer[1]);
    DrawPopUp(popUpContainer[0], popUpContainer[1], achievementPopUps[0]);
}
