if (lastViewCheck > 0)
{
    lastViewCheck--;
}
if (makeParticle)
{
    alarm[0] = floor(random(60));
    makeParticle = false;
}
if (lastViewCheck == 0)
{
    amIinView = x > (camera_get_view_x(view_camera[0]) - 75) && x < (camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) + 75) && y > (camera_get_view_y(view_camera[0]) - 75) && y < (camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) + 75);
    lastViewCheck = 30;
}
if (instance_exists(obj_Player) && global.charSelected.id == "ina")
{
    if (point_distance(obj_Player.x, obj_Player.y, x, y) < 60 && !found)
    {
        found = true;
        sprite_index = spr_4thtakoFound;
        image_index = 0;
        if (obj_Player.x > x)
        {
            image_xscale = 1;
        }
        else
        {
            image_xscale = -1;
        }
        alarm[1] = 30;
    }
}
