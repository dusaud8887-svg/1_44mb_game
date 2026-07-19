dayTime++;
if (dayTime == 10000)
{
    changingTo = "night";
    if (instance_exists(obj_BG_Light))
    {
        obj_BG_Light.SetNight();
    }
    if (instance_exists(obj_playerNightLight))
    {
        obj_playerNightLight.SetNight();
    }
    alarm[0] = 1;
    if (!audio_is_playing(snd_crickets))
    {
        audio_sound_gain(snd_crickets, 0, 1);
        audio_sound_gain(snd_crickets, 1, 1000);
        audio_play_sound(snd_crickets, 0, true);
    }
    else
    {
        audio_sound_gain(snd_crickets, 1, 1000);
    }
}
if (dayTime == 17700)
{
    changingTo = "day";
    if (instance_exists(obj_BG_Light))
    {
        obj_BG_Light.SetDay();
    }
    if (instance_exists(obj_playerNightLight))
    {
        obj_playerNightLight.SetDay();
    }
    alarm[0] = 1;
    audio_sound_gain(snd_crickets, 0, 500);
}
if (dayTime == 18000)
{
    dayTime = 0;
}
if (rainTime > 0)
{
    rainTime--;
    if (instance_exists(obj_FarmingSpot))
    {
        with (obj_FarmingSpot)
        {
            if (seedID != -1)
            {
                Water(false);
            }
        }
    }
}
else
{
    rain = false;
    audio_sound_gain(snd_rain, 0, 300);
}
if (rain)
{
    if (rainCD > 0)
    {
        rainCD--;
    }
    else
    {
        instance_create_depth(camera_get_view_x(view_camera[0]) + 100 + irandom(600), camera_get_view_y(view_camera[0]) - irandom(320), depth - 100, obj_rain);
        instance_create_depth(camera_get_view_x(view_camera[0]) + 100 + irandom(600), camera_get_view_y(view_camera[0]) - irandom(320), depth - 100, obj_rain);
        instance_create_depth(camera_get_view_x(view_camera[0]) + 100 + irandom(600), camera_get_view_y(view_camera[0]) - irandom(320), depth - 100, obj_rain);
        rainCD = 3;
    }
}
