if (other.attackID == "BlacksmithHammer" || other.attackID == "RarestMetalBurst")
{
    if (hitCD == 0 && !initialSpawn)
    {
        HP--;
        soundPlay([61], "oredeposit", 20, 0, true);
        hitCD = 30;
        shakeTime = 15;
        if (global.lightFX)
        {
            for (var i = 0; i < (4 + irandom(8)); i++)
            {
                var randSize = 0.25 + random(0.25);
                var vfx = instance_create_depth(x, y, depth, obj_vfx);
                vfx.sprite_index = spr_KaelaMinerals;
                vfx.duration = 30;
                vfx.image_index = 0;
                vfx.image_xscale = randSize;
                vfx.image_yscale = randSize;
                vfx.image_speed = 0;
                vfx.image_angle = irandom(359);
                vfx.image_alpha = 1;
                vfx.hspeed = -4 + irandom(8);
                vfx.vspeed = -4 - irandom(7);
                vfx.gravity = 0.5;
                vfx.alarm[1] = 20;
                vfx.alarm[2] = 1;
                vfx.rotSpeed = -5 + irandom(10);
            }
        }
        if (rarest)
        {
            obj_Cam.ExecuteShake(30, 5);
            obj_AttackController.ExecuteAttack("RarestMetalBurst", 227, 
            {
                x: x,
                y: y
            });
        }
    }
}
