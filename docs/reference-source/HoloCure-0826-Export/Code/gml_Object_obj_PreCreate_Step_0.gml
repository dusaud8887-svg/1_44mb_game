if (waitSpawn > 1)
{
    waitSpawn--;
}
else if (waitSpawn == 1)
{
    var vfx = instance_create_depth(x, y, depth + 1, obj_vfx);
    vfx.sprite_index = spr_spawnFX;
    vfx.add = true;
    spawnScript(self, theConfig, true, srad);
}
