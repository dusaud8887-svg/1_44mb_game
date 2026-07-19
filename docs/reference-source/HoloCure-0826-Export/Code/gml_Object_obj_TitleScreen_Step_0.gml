if (canControl)
{
    idletime++;
}
if (obj_InputManager.MouseMoved)
{
    idletime = 0;
}
if (idletime >= 3600)
{
    room_goto(rm_Intro);
}
global.camera_scale = 1;
with (obj_glareLighting)
{
    global.GLR_ZOOM = global.camera_scale;
}
lifetime += 0.02617993877991494;
if (lifetime >= (2 * pi))
{
    lifetime = 0;
}
titleY += (sin(lifetime) / 4);
