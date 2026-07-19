with (obj_InputManager)
{
    hideMouse = true;
}
with (obj_Enemy)
{
    CompleteStop();
}
if (painting > 0)
{
    painting--;
}
if (x >= (camera_get_view_x(view_camera[0]) + 640))
{
    x = camera_get_view_x(view_camera[0]) + 640;
}
if (x <= camera_get_view_x(view_camera[0]))
{
    x = camera_get_view_x(view_camera[0]);
}
if (y >= (camera_get_view_y(view_camera[0]) + 360))
{
    y = camera_get_view_y(view_camera[0]) + 360;
}
if (y <= camera_get_view_y(view_camera[0]))
{
    y = camera_get_view_y(view_camera[0]);
}
with (obj_Player)
{
    invincibilityTimer = 30;
    invincible = true;
    stopAttacks = true;
    canControl = false;
}
if (paintTimer > 0)
{
    paintTimer--;
}
else
{
    if (paintAmount == 100)
    {
        DoAchievement("artblock");
    }
    EndPaint();
}
if (paintCD > 0)
{
    paintCD--;
}
else
{
    initial = false;
}
if (obj_InputManager.MouseMoved())
{
    x = mouse_x;
    y = mouse_y;
}
else
{
    if (obj_InputManager.moveUpDown)
    {
        y -= 5;
    }
    if (obj_InputManager.moveDownDown)
    {
        y += 5;
    }
    if (obj_InputManager.moveLeftDown)
    {
        x -= 5;
    }
    if (obj_InputManager.moveRightDown)
    {
        x += 5;
    }
}
if (obj_InputManager.actionOneDown || obj_InputManager.actionTwoDown)
{
    Paint();
}
if (obj_InputManager.actionOneReleased || obj_InputManager.actionOneReleased)
{
    if (initial)
    {
        initial = false;
        paintCD = 5;
    }
}
