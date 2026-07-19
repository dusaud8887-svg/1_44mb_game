event_inherited();
depth = -y - 5;
cursorTime++;
if (shaking)
{
    shakeDisplacement *= -1;
}
if (beginCooking)
{
    if (cookPause < 180)
    {
        cookPause++;
    }
    if (cookPause == 40)
    {
        shaking = true;
        audio_play_sound(snd_startcook, 0, 0);
        part_emitter_stream(global.psystem, emitter, global.partType20, 2);
    }
    if (cookPause == 140)
    {
        var vfx = instance_create_depth(x, y - 30, depth - 30, obj_vfx);
        vfx.sprite_index = spr_CookingDone;
        vfx.add = true;
        vfx.image_alpha = 0.5;
        audio_play_sound(snd_itemcooked, 0, 0);
        shaking = false;
        part_emitter_burst(global.psystem, emitter, global.partType21, 60);
        part_emitter_stream(global.psystem, emitter, global.partType20, -5);
    }
}
if (cookPause >= 180 && cookTimer > 0)
{
    if (cookTimer == 29)
    {
        audio_play_sound(snd_fishResults, 0, 0);
        cookConfirm = true;
    }
    cookTimer--;
}
if (point_distance(x, y, obj_Player.x, obj_Player.y) < 100)
{
    audio_sound_gain(snd_cookingpot, 1, 1);
}
else if (point_distance(x, y, obj_Player.x, obj_Player.y) > 200)
{
    audio_sound_gain(snd_cookingpot, 0, 1);
}
else
{
    audio_sound_gain(snd_cookingpot, min(1, (200 - point_distance(x, y, obj_Player.x, obj_Player.y)) / 100), 1);
}
if (cursorTime >= 10000)
{
    cursorTime = 0;
}
if (interacting)
{
    if (pauseMenu == 0)
    {
        global.new_camera_scale = 2;
        global.cameraXOffset = 100 + (x - obj_Player.x);
        global.cameraYOffset = -45;
    }
    else if (pauseMenu == 3 && cookPause < 140)
    {
        global.new_camera_scale = 2;
        global.cameraXOffset = x - obj_Player.x;
        global.cameraYOffset = 0;
    }
    else
    {
        global.new_camera_scale = 1;
        global.cameraXOffset = 0;
        global.cameraYOffset = 0;
    }
}
