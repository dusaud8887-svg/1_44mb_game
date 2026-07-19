if (y >= destY)
{
    var randSize = 0.5 + random(0.5);
    var vfx = instance_create_depth(x, y, depth - 1, obj_vfx);
    vfx.sprite_index = spr_RainFloor;
    vfx.image_xsscale = randSize;
    vfx.image_yscale = randSize;
    instance_destroy();
}
