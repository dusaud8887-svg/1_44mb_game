event_inherited();
cursorTime++;
if (cursorTime >= 10000)
{
    cursorTime = 0;
}
var player = instance_find(obj_Player, 0);
if (player.x > x)
{
    image_xscale = abs(image_xscale);
}
else
{
    image_xscale = -abs(image_xscale);
}
if (interacting)
{
    if (pauseMenu == 0 || pauseMenu == 1)
    {
        global.new_camera_scale = 2;
        global.cameraXOffset = 120 + (x - obj_Player.x);
        global.cameraYOffset = -55;
    }
    else
    {
        global.new_camera_scale = 1;
        global.cameraXOffset = 0;
        global.cameraYOffset = 0;
    }
}
