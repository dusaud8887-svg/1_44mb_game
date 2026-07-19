for (var i = 0; i < 50; i++)
{
    var vfx = instance_create_depth(x, y, depth - 30, obj_vfxGUI);
    vfx.sprite_index = hudfx_sparkle;
    vfx.image_speed = 0;
    vfx.image_xscale = 0.5 + random(0.5);
    vfx.image_yscale = vfx.image_xscale;
    vfx.add = true;
    vfx.alarm[1] = 1;
    vfx.alarm[2] = 1;
    vfx.direction = irandom(359);
    vfx.speed = 1 + random(10);
    vfx.color = color;
    vfx.image_angle = irandom(359);
    vfx.gravity = 0.2;
}
instance_destroy();
