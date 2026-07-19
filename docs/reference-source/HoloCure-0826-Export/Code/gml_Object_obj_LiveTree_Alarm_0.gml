if (global.lightFX)
{
    if (x > camera_get_view_x(view_camera[0]) && x < (camera_get_view_x(view_camera[0]) + 640) && y > camera_get_view_y(view_camera[0]) && y < (camera_get_view_y(view_camera[0]) + 360))
    {
        if (!instance_exists(obj_StageManager) || (instance_exists(obj_StageManager) && obj_StageManager.enemyAmount < 100))
        {
            var particle = instance_create_depth((x - 50) + random(100), y - 65, depth - 1, obj_flowerPart);
            particle.direction = 230 + random(80);
            particle.speed = 0.4 + random(0.6);
            if (room == rm_GrassPlains_Night)
            {
                particle.drawCol = make_color_rgb(63, 147, 187);
            }
            else
            {
                particle.drawCol = make_color_rgb(70, 170, 54);
            }
        }
    }
}
alarm[0] = 3 + floor(random(20));
