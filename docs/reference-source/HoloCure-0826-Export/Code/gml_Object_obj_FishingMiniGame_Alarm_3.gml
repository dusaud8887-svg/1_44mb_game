fishingResults = true;
fishingMode = false;
resultsContainer[1] = -120;
lightTime = 0;
if (fishGauge >= 100)
{
    audio_play_sound(snd_summonShark1, 0, 0);
    var playerDir = point_direction(obj_Player.x, obj_Player.y, x, y);
    comboChain++;
    goldBonus++;
    bonusYield = comboChain div 10;
    difficultyUp = min(35, (comboChain div 10) * 5);
    var vfx = instance_create_depth(obj_Player.x + lengthdir_x(80, playerDir), obj_Player.y + lengthdir_y(80, playerDir), depth - 10, obj_vfx);
    vfx.sprite_index = spr_fishSplash;
    vfx.image_xscale = fishSize;
    vfx.image_yscale = fishSize;
}
else if (fishGauge < 1)
{
    comboChain = 0;
    goldBonus = 0;
    bonusYield = 0;
    difficultyUp = 0;
    canPress = 999;
}
fishResultsTimer = 0;
if (foundGold)
{
    instance_create_depth(91, 360, depth - 20, obj_fireworks);
    instance_create_depth(182, 360, depth - 20, obj_fireworks);
    instance_create_depth(273, 360, depth - 20, obj_fireworks);
    instance_create_depth(364, 360, depth - 20, obj_fireworks);
    instance_create_depth(455, 360, depth - 20, obj_fireworks);
    instance_create_depth(546, 360, depth - 20, obj_fireworks);
    with (obj_animezoom)
    {
        instance_destroy();
    }
}
audio_stop_sound(snd_fishreel);
