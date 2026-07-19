if (mouse_x > (x - 35) && mouse_x < (x + 35) && mouse_y > (y - 35) && mouse_y < (y + 35) && mouse_check_button_pressed(mb_left))
{
    Activate();
}
canActivate = place_meeting(x, y, obj_Player);
