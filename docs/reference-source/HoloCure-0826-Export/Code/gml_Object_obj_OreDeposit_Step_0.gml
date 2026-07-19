if (spawnTimer > 0)
{
    spawnTimer--;
}
else
{
    initialSpawn = false;
    speed = 0;
}
if (!place_meeting(x, y, obj_invisiWall))
{
    if (spawnTimer == 0)
    {
        initialSpawn = false;
    }
    image_alpha = 1;
}
if (HP < 1)
{
    if (!rarest)
    {
        switch (oreType)
        {
            case 0:
                obj_Player.scripts.MaterialGrind.config.oreA++;
                break;
            case 1:
                obj_Player.scripts.MaterialGrind.config.oreB++;
                break;
            case 2:
                obj_Player.scripts.MaterialGrind.config.oreC++;
                break;
        }
        var mineral = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
        mineral.sprite_index = spr_KaelaMinerals;
        mineral.image_index = 1 + oreType;
        mineral.image_speed = 0;
        mineral.waitTime = 30;
        mineral.image_xscale = 2;
        mineral.image_yscale = 2;
        audio_play_sound(snd_fishGet, 0, 0);
        instance_destroy();
    }
    else
    {
        obj_PlayerManager.ExecuteFlash(0.5);
        obj_Cam.ExecuteShake(100, 6);
        obj_AttackController.ApplyBuff(227, "Happiness", ds_map_find_value(obj_AttackController.Buffs, "Happiness"), 
        {
            buffIcon: 2451
        });
        var mineral = instance_create_depth(obj_Player.x, obj_Player.y - 16, obj_Player.depth - 10, obj_GetFish);
        mineral.sprite_index = spr_KaelaSpecial;
        mineral.image_index = 1 + oreType;
        mineral.image_speed = 0;
        mineral.image_xscale = 2;
        mineral.image_yscale = 2;
        mineral.waitTime = 30;
        audio_play_sound(snd_happiness, 0, 0);
        instance_destroy();
    }
}
if (shakeTime > 0)
{
    shakeTime--;
    if ((shakeTime % 2) == 0)
    {
        shakeAmount *= -1;
    }
}
if (hitCD > 0)
{
    hitCD--;
}
