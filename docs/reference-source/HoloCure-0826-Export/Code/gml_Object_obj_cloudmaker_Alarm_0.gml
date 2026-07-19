if (global.lightFX)
{
    instance_create_depth(followPlayerID.x - 500 - random(200), (followPlayerID.y - 180) + random(360), -9999, obj_clouds);
}
alarm[0] = 180 + irandom(400);
